using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace HealthMonitorWinForms
{
    public class HealthData_Sync
    {
        public interface ISet
        {
        }

        public delegate ISet NewSetDelegate(string Title, SqlDataReader dr);
        public delegate void NewRowDelegate(ISet set, SqlDataReader dr);
        public delegate void SetCompleteDelegate(ISet set);

        public static void RefreshView(Action Starting, NewSetDelegate NewSet, NewRowDelegate NewRow, SetCompleteDelegate SetComplete, Action Finishing) {
            if (Starting != null)
            {
                Starting();
            }

            SqlConnection cn = new SqlConnection("Data Source=(local);Initial Catalog=LeversAndTurtles;Trusted_Connection=True");
            cn.Open();
            SqlCommand cm = new SqlCommand("DBHealth.RunChecks", cn);
            cm.CommandType = System.Data.CommandType.StoredProcedure;
            SqlDataReader dr = cm.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
            while (true)
            {
                if (dr.HasRows)
                {
                    bool firstrow = true;
                    ISet set = null;
                    while (dr.Read())
                    {
                        if (firstrow)
                        {
                            set = NewSet(dr["Problem"].ToString(), dr);
                            firstrow = false;
                        }

                        NewRow(set, dr);
                    }
                    SetComplete(set);
                }
                if (!dr.NextResult()) break;
            }
            dr.Close();
            cn.Close();

            if (Finishing != null)
            {
                Finishing();
            }
        }
    }
}

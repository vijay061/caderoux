/*
    Presentation: Get a Lever and Pick Any Turtle
	Ref: https://bitly.com/bundles/caderoux/3
	By: Cade Roux cade@rosecrescent.com
	This work is licensed under a Creative Commons Attribution-ShareAlike 3.0 Unported License.
	http://creativecommons.org/licenses/by-sa/3.0/
 */
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace HealthMonitorWinForms
{
    public class HealthData_ASync
    {
        public interface ISet
        {
        }

        public delegate ISet NewSetDelegate(string Title, SqlDataReader dr);
        public delegate void NewRowDelegate(ISet set, SqlDataReader dr);
        public delegate void SetCompleteDelegate(ISet set);

        private static Form _Form;
        private static NewSetDelegate _NewSet;
        private static NewRowDelegate _NewRow;
        private static SetCompleteDelegate _SetComplete;

        private static void HandleCompletion(IAsyncResult result)
        {
            SqlCommand cm = (SqlCommand)result.AsyncState;
            SqlDataReader dr = cm.EndExecuteReader(result);
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
                            set = (ISet) _Form.Invoke(_NewSet, dr["Problem"].ToString(), dr);
                            firstrow = false;
                        }

                        _Form.Invoke(_NewRow, set, dr);
                    }
                    _Form.Invoke(_SetComplete, set);
                }
                if (!dr.NextResult()) break;
            }
            dr.Close();
        }

        public static void RefreshView(Form Form, Action Starting, NewSetDelegate NewSet, NewRowDelegate NewRow, SetCompleteDelegate SetComplete, Action Finishing) {
            _Form = Form;
            _NewSet = NewSet;
            _NewRow = NewRow;
            _SetComplete = SetComplete;

            if (Starting != null)
            {
                Starting();
            }

            SqlConnection cn = new SqlConnection("Data Source=(local);Initial Catalog=LeversAndTurtles;Trusted_Connection=True;Asynchronous Processing=True");
            cn.Open();
            SqlCommand cm = new SqlCommand("DBHealth.RunChecks", cn);
            cm.CommandType = System.Data.CommandType.StoredProcedure;
            cm.BeginExecuteReader(HandleCompletion, cm, System.Data.CommandBehavior.CloseConnection);
        }
    }
}

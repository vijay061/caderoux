using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace HealthMonitorWinForms
{
    public partial class HealthMonitorForm : Form
    {
        public class Set : HealthData_ASync.ISet
        {
            public readonly ListView lv;
            public Set(ListView lv)
            {
                this.lv = lv;
            }
        }

        public HealthMonitorForm()
        {
            InitializeComponent();
        }

        private void RefreshStarting()
        {
            tabsHealth.TabPages.Clear();
        }

        private Set NewSet(string Title, SqlDataReader dr)
        {
            TabPage t = new TabPage(Title);
            tabsHealth.TabPages.Add(t);
            ListView lv = new ListView();
            t.Controls.Add(lv);
            lv.Dock = DockStyle.Fill;
            lv.View = View.Details;
            lv.Columns.Clear();
            for (int lp = 0; lp < dr.FieldCount; lp++)
            {
                ColumnHeader ch = new ColumnHeader();
                ch.Text = dr.GetName(lp);
                lv.Columns.Add(ch);
            }

            return new Set(lv);
        }

        private void NewRow(HealthData_ASync.ISet set, SqlDataReader dr)
        {
            ListViewItem lvi = new ListViewItem();
            object[] row = new object[dr.FieldCount];

            for (int lp = 0; lp < dr.FieldCount; lp++)
            {
                if (lp == 0)
                {
                    lvi.Text = dr[lp].ToString();
                }
                else
                {
                    lvi.SubItems.Add(dr[lp].ToString());
                }
            }
            ((Set) set).lv.Items.Add(lvi);
        }

        private void SetComplete(HealthData_ASync.ISet set)
        {
            foreach (ColumnHeader ch in ((Set) set).lv.Columns)
            {
                ch.AutoResize(ColumnHeaderAutoResizeStyle.ColumnContent);
            }
        }

        private void HealthMonitorForm_KeyUp(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.F5)
            {
                HealthData_ASync.RefreshView(this, RefreshStarting, new HealthData_ASync.NewSetDelegate(NewSet), new HealthData_ASync.NewRowDelegate(NewRow), new HealthData_ASync.SetCompleteDelegate(SetComplete), null);
                e.Handled = true;
            }
        }
    }
}

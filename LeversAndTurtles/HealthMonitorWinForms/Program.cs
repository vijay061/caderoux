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
using System.Windows.Forms;

namespace HealthMonitorWinForms
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new HealthMonitorForm());
        }
    }
}

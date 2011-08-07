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

// Comment this!
public class DumpLookups {
	public static void DumpAll() {
		DumpLookup_CodeGen1();
		DumpLookup_CodeGen2();
		DumpLookup_CodeGen3();
		DumpLookup_CodeGen4();
	}

	public static void DumpLookup_CodeGen1() {
		SqlConnection cn = new SqlConnection("Data Source=(local);Initial Catalog=LeversAndTurtles;Trusted_Connection=True");
		cn.Open();
		SqlCommand cm = new SqlCommand("[Demo].[Lookup_CodeGen1]", cn);
		cm.CommandType = System.Data.CommandType.StoredProcedure;
		SqlDataReader dr = cm.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
		Console.WriteLine("{0} Table Contents", "Lookup_CodeGen1");
		while (dr.Read()) {
			for (int lp = 0 ; lp < dr.FieldCount ; lp++) {
				Console.WriteLine("{0}: {1}", dr.GetName(lp), dr[lp].ToString());
			}
		}
		dr.Close();	
	}

	public static void DumpLookup_CodeGen2() {
		SqlConnection cn = new SqlConnection("Data Source=(local);Initial Catalog=LeversAndTurtles;Trusted_Connection=True");
		cn.Open();
		SqlCommand cm = new SqlCommand("[Demo].[Lookup_CodeGen2]", cn);
		cm.CommandType = System.Data.CommandType.StoredProcedure;
		SqlDataReader dr = cm.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
		Console.WriteLine("{0} Table Contents", "Lookup_CodeGen2");
		while (dr.Read()) {
			for (int lp = 0 ; lp < dr.FieldCount ; lp++) {
				Console.WriteLine("{0}: {1}", dr.GetName(lp), dr[lp].ToString());
			}
		}
		dr.Close();	
	}

	public static void DumpLookup_CodeGen3() {
		SqlConnection cn = new SqlConnection("Data Source=(local);Initial Catalog=LeversAndTurtles;Trusted_Connection=True");
		cn.Open();
		SqlCommand cm = new SqlCommand("[Demo].[Lookup_CodeGen3]", cn);
		cm.CommandType = System.Data.CommandType.StoredProcedure;
		SqlDataReader dr = cm.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
		Console.WriteLine("{0} Table Contents", "Lookup_CodeGen3");
		while (dr.Read()) {
			for (int lp = 0 ; lp < dr.FieldCount ; lp++) {
				Console.WriteLine("{0}: {1}", dr.GetName(lp), dr[lp].ToString());
			}
		}
		dr.Close();	
	}

	public static void DumpLookup_CodeGen4() {
		SqlConnection cn = new SqlConnection("Data Source=(local);Initial Catalog=LeversAndTurtles;Trusted_Connection=True");
		cn.Open();
		SqlCommand cm = new SqlCommand("[Demo].[Lookup_CodeGen4]", cn);
		cm.CommandType = System.Data.CommandType.StoredProcedure;
		SqlDataReader dr = cm.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
		Console.WriteLine("{0} Table Contents", "Lookup_CodeGen4");
		while (dr.Read()) {
			for (int lp = 0 ; lp < dr.FieldCount ; lp++) {
				Console.WriteLine("{0}: {1}", dr.GetName(lp), dr[lp].ToString());
			}
		}
		dr.Close();	
	}

}
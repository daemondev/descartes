using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Entidad;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Datos
{
    public class Dtb_Reportes
    {
        static string cad = ConfigurationManager.ConnectionStrings["dbConexion"].ConnectionString;

        public DataSet D_Reportes(string f1, string f2, string in_sede, string in_camp)
        {
            using (SqlConnection cn = new SqlConnection(cad))
            {
                SqlCommand cmd = new SqlCommand("USP_REPORTES", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 900000000;
                              
                cmd.Parameters.AddWithValue("@F1", f1);
                cmd.Parameters.AddWithValue("@F2", f2);
                cmd.Parameters.AddWithValue("@SEDE", in_sede);
                cmd.Parameters.AddWithValue("@CAMPANNIA", in_camp);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                da.Fill(ds);
                return ds;
            }
        }

        public DataSet D_ReportesG(string f1, string f2, string in_sede, string in_camp)
        {
            using (SqlConnection cn = new SqlConnection(cad))
            {
                SqlCommand cmd = new SqlCommand("REPORTE_GENERAL", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 900000000;

                cmd.Parameters.AddWithValue("@F1", f1);
                cmd.Parameters.AddWithValue("@F2", f2);
                cmd.Parameters.AddWithValue("@SEDE", in_sede);
                cmd.Parameters.AddWithValue("@CAMPANNIA", in_camp);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                da.Fill(ds);
                return ds;
            }
        }

        //public DataTable D_ReportesCantAsisFalt(int in_AgenteID)
        //{
        //    using (SqlConnection cn = new SqlConnection(cad))
        //    {
        //        SqlCommand cmd = new SqlCommand("usp_MantAsistencia", cn);
        //        cmd.CommandType = CommandType.StoredProcedure;
        //        cmd.CommandTimeout = 900000000;
        //        cmd.Parameters.AddWithValue("@in_Opc", 6);
        //        cmd.Parameters.AddWithValue("@in_CapaID", 0);
        //        cmd.Parameters.AddWithValue("@in_UsuRegist", 0);
        //        cmd.Parameters.AddWithValue("@in_CantAsitentes", 0);
        //        cmd.Parameters.AddWithValue("@in_CantFaltantes", 0);
        //        cmd.Parameters.AddWithValue("@in_AgenteID", in_AgenteID);
        //        cmd.Parameters.AddWithValue("@in_Asistencia", 0);
        //        cmd.Parameters.AddWithValue("@in_Condicion", 0);
        //        SqlDataAdapter da = new SqlDataAdapter(cmd);
        //        DataTable dt = new DataTable();
        //        da.Fill(dt);
        //        return dt;
        //    }
        //}

        //public DataTable D_ReportesPagosValid(int in_AgenteID, int in_NroPago)
        //{
        //    using (SqlConnection cn = new SqlConnection(cad))
        //    {
        //        SqlCommand cmd = new SqlCommand("usp_Reporte", cn);
        //        cmd.CommandType = CommandType.StoredProcedure;
        //        cmd.CommandTimeout = 900000000;
        //        cmd.Parameters.AddWithValue("@in_Opc", 3);
        //        cmd.Parameters.AddWithValue("@in_NroPago", in_NroPago);
        //        cmd.Parameters.AddWithValue("@in_AgenteID", in_AgenteID);
        //        SqlDataAdapter da = new SqlDataAdapter(cmd);
        //        DataTable dt = new DataTable();
        //        da.Fill(dt);
        //        return dt;
        //    }
        //}
    }
}

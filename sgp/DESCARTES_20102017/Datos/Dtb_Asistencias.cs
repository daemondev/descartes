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
    public class Dtb_Asistencias
    {
        static string cad = ConfigurationManager.ConnectionStrings["dbConexion"].ConnectionString;

        public DataSet D_DetalleAsistencias(Etb_Asistencias ent)
        {
            using (SqlConnection cn = new SqlConnection(cad))
            {
                SqlCommand cmd = new SqlCommand("usp_MantAsistencia", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 900000000;
                cmd.Parameters.AddWithValue("@in_Opc", ent.in_Opc);
                cmd.Parameters.AddWithValue("@in_CapaID", ent.in_CapaID);
                cmd.Parameters.AddWithValue("@in_UsuRegist", ent.in_UsuRegist);
                cmd.Parameters.AddWithValue("@in_CantAsitentes", ent.in_CantAsitentes);
                cmd.Parameters.AddWithValue("@in_CantFaltantes", ent.in_CantFaltantes);
                cmd.Parameters.AddWithValue("@in_AgenteID", ent.in_AgenteID);
                cmd.Parameters.AddWithValue("@in_Asistencia", ent.in_Asistencia);
                cmd.Parameters.AddWithValue("@in_Condicion", ent.in_Condicion);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                //DataTable dt = new DataTable();
                da.Fill(ds);
                return ds;
            }
        }

        public List<Etb_Asistencias> D_MantAsistencia(Etb_Asistencias ent)
        {
            using (SqlConnection cn = new SqlConnection(cad))
            {
                List<Etb_Asistencias> lista = new List<Etb_Asistencias>();
                Etb_Asistencias obj;

                SqlCommand cmd = new SqlCommand("usp_MantAsistencia", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 900000000;
                cmd.Parameters.AddWithValue("@in_Opc", ent.in_Opc);
                cmd.Parameters.AddWithValue("@in_CapaID", ent.in_CapaID);
                cmd.Parameters.AddWithValue("@in_UsuRegist", ent.in_UsuRegist);
                cmd.Parameters.AddWithValue("@in_CantAsitentes", ent.in_CantAsitentes);//tambien usado para enviar el ultimo codigo generado en tb_asistencia
                cmd.Parameters.AddWithValue("@in_CantFaltantes", ent.in_CantFaltantes);
                cmd.Parameters.AddWithValue("@in_AgenteID", ent.in_AgenteID);
                cmd.Parameters.AddWithValue("@in_Asistencia", ent.in_Asistencia);
                cmd.Parameters.AddWithValue("@in_Condicion", ent.in_Condicion);

                cn.Open();

                switch (ent.in_Opc)
                {
                    case 2:
                    case 5:
                    case 6:
                    case 7:
                        SqlDataReader dr = cmd.ExecuteReader();
                        if (dr.HasRows)
                        {
                            while (dr.Read())
                            {
                                obj = new Etb_Asistencias();
                                if (ent.in_Opc == 6)
                                {
                                    obj.in_CantAsitentes = dr.GetInt32(0);
                                    obj.in_CantFaltantes = dr.GetInt32(1);
                                }
                                else
                                {
                                    obj.in_Resul = dr.GetInt32(0);
                                }
                                lista.Add(obj);
                            }
                        }
                        dr.Close();
                        break;
                    case 3:
                        obj = new Etb_Asistencias();
                        SqlParameter id = cmd.Parameters.Add("SCOPE_IDENTITY()", SqlDbType.Int);
                        id.Direction = ParameterDirection.ReturnValue;
                        int resul = (int)cmd.ExecuteNonQuery();
                        obj.in_Resul = (int)id.Value;
                        lista.Add(obj);
                        break;
                    case 4:
                    case 8:
                    case 9:
                        obj = new Etb_Asistencias();
                        int res = (int)cmd.ExecuteNonQuery();
                        obj.in_Resul = res;
                        lista.Add(obj);
                        break;
                }
                cn.Close();
                return lista;
            }
        }

    }
}

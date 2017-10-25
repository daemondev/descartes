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
    public class Dtb_AgenteBuscar
    {
        static string cad = ConfigurationManager.ConnectionStrings["dbConexion"].ConnectionString;

        public List<Etb_AgenteBuscar> D_AgenteBuscar(Etb_AgenteBuscar ent)
        {
            using (SqlConnection cn = new SqlConnection(cad))
            {
                List<Etb_AgenteBuscar> lista = new List<Etb_AgenteBuscar>();
                Etb_AgenteBuscar obj;

                SqlCommand cmd = new SqlCommand("usp_BuscarAgente", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 900000000;
                cmd.Parameters.AddWithValue("@in_Opc", ent.in_Opc);
                cmd.Parameters.AddWithValue("@in_NumPagina", ent.in_NumPagina);
                cmd.Parameters.AddWithValue("@in_TamPagina", ent.in_TamPagina);
                cmd.Parameters.AddWithValue("@vc_Agente", ent.vc_Agente);
                cmd.Parameters.AddWithValue("@in_AgenteID", ent.in_AgenteID);
                cmd.Parameters.AddWithValue("@in_CampaniaID", ent.in_CampaniaID);
                cmd.Parameters.AddWithValue("@in_CapaID", ent.in_CapaID);

                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        obj = new Etb_AgenteBuscar();
                        obj.in_AgenteID = dr.GetInt32(0);
                        obj.vc_Usuario = dr.GetString(1);
                        obj.vc_DNI = dr.GetString(2);
                        obj.Nombres = dr.GetString(3);
                        obj.in_CapaID = dr.GetInt32(4);
                        obj.vc_Titulo = dr.GetString(5);
                        obj.vc_Campania = dr.GetString(6);
                        obj.in_Estado = dr.GetInt32(7);
                        obj.in_TotalRegistros = dr.GetInt32(8);
                        lista.Add(obj);
                    }
                }
                cn.Close();
                return lista;
            }
        }

        public DataSet D_AgenteBuscarDetalle(Etb_AgenteBuscar ent)
        {
            using (SqlConnection cn = new SqlConnection(cad))
            {
                SqlCommand cmd = new SqlCommand("usp_BuscarAgente", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 900000000;
                cmd.Parameters.AddWithValue("@in_Opc", ent.in_Opc);
                cmd.Parameters.AddWithValue("@in_NumPagina", ent.in_NumPagina);
                cmd.Parameters.AddWithValue("@in_TamPagina", ent.in_TamPagina);
                cmd.Parameters.AddWithValue("@vc_Agente", ent.vc_Agente);
                cmd.Parameters.AddWithValue("@in_AgenteID", ent.in_AgenteID);
                cmd.Parameters.AddWithValue("@in_CampaniaID", ent.in_CampaniaID);
                cmd.Parameters.AddWithValue("@in_CapaID", ent.in_CapaID);
                try
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();
                    da.Fill(ds);
                    return ds;
                }
                catch (Exception)
                {
                    return null;
                }
            }
        }
    }
}

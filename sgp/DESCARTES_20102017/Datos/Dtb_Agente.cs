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
    public class Dtb_Agente
    {
        static string cad = ConfigurationManager.ConnectionStrings["dbConexion"].ConnectionString;

        public List<Etb_CargaAgentes> D_MantAgente(Etb_CargaAgentes ent)
        {
            using (SqlConnection cn = new SqlConnection(cad))
            {
                List<Etb_CargaAgentes> lista = new List<Etb_CargaAgentes>();
                Etb_CargaAgentes obj;

                SqlCommand cmd = new SqlCommand("usp_MantAgentes", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 900000000;
                cmd.Parameters.AddWithValue("@in_Opc", ent.in_Opc);
                cmd.Parameters.AddWithValue("@in_CargaID", ent.in_CargaID);
                cmd.Parameters.AddWithValue("@in_CapaID", ent.in_CapaID);
                cmd.Parameters.AddWithValue("@in_UsuRegistroID", ent.in_UsuRegistroID);
                cmd.Parameters.AddWithValue("@in_CantAgentes", ent.in_CantAgentes);
                cmd.Parameters.AddWithValue("@in_AgenteID", ent.in_AgenteID);
                cmd.Parameters.AddWithValue("@vc_Usuario", ent.vc_Usuario);
                cmd.Parameters.AddWithValue("@vc_DNI", ent.vc_DNI);
                cmd.Parameters.AddWithValue("@vc_Nombre", ent.vc_Nombre);
                cmd.Parameters.AddWithValue("@vc_ApePaterno", ent.vc_ApePaterno);
                cmd.Parameters.AddWithValue("@vc_ApeMaterno", ent.vc_ApeMaterno);
                cmd.Parameters.AddWithValue("@in_Estado", ent.in_Estado);
                cmd.Parameters.AddWithValue("@vc_Observacion", ent.vc_Observacion);

                cn.Open();

                switch (ent.in_Opc)
                {
                    case 3:
                        SqlDataReader dr = cmd.ExecuteReader();
                        if (dr.HasRows)
                        {
                            while (dr.Read())
                            {
                                obj = new Etb_CargaAgentes();
                                obj.vc_Usuario = dr.GetString(0);
                                obj.vc_DNI = dr.GetString(1);
                                obj.vc_Nombre = dr.GetString(2);
                                obj.vc_ApePaterno = dr.GetString(3);
                                obj.vc_ApeMaterno = dr.GetString(4);
                                lista.Add(obj);
                            }
                        }
                        dr.Close();
                        break;
                }
                cn.Close();
                return lista;
            }
        }
    }
}

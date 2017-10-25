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
    public class Dtb_Perfil
    {
        static string cad = ConfigurationManager.ConnectionStrings["dbConexion"].ConnectionString;

        public List<Etb_Perfil> D_MantPerfil()
        {
            using (SqlConnection cn = new SqlConnection(cad))
            {
                List<Etb_Perfil> lista = new List<Etb_Perfil>();
                Etb_Perfil obj;

                SqlCommand cmd = new SqlCommand("usp_MantPerfil", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 900000000;
                cmd.Parameters.AddWithValue("@in_Opc", 1);

                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        obj = new Etb_Perfil();
                        obj.in_PerfilID = dr.GetInt32(0);
                        obj.vc_Perfil = dr.GetString(1);
                        obj.in_Estado = dr.GetInt32(2);
                        lista.Add(obj);
                    }
                }
                dr.Close();
                cn.Close();
                return lista;
            }
        }
    }
}

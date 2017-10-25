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
    public class Dtb_MenuPerfil
    {
        static string cad = ConfigurationManager.ConnectionStrings["dbConexion"].ConnectionString;

        public List<Etb_MenuPerfil> D_ListarMenuPerfil(Etb_MenuPerfil ent)
        {
            using (SqlConnection cn = new SqlConnection(cad))
            {
                List<Etb_MenuPerfil> lista = new List<Etb_MenuPerfil>();
                Etb_MenuPerfil obj;

                SqlCommand cmd = new SqlCommand("usp_MantMenuPerfil", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 900000000;
                cmd.Parameters.AddWithValue("@opc", 1);
                cmd.Parameters.AddWithValue("@in_PerfilID", ent.in_PerfilID);

                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        obj = new Etb_MenuPerfil();
                        obj.in_PerfilMenu = Convert.ToString(dr.GetInt32(0));
                        obj.in_MenuID = Convert.ToString(dr.GetInt32(1));
                        obj.vc_NomMenu = dr.GetString(2);
                        obj.vc_Url = dr.GetString(3);
                        obj.in_PadreID = Convert.ToString(dr.GetInt32(4));
                        obj.in_Orden = Convert.ToString(dr.GetInt32(5));
                        obj.vc_Imagen = dr.GetString(6);
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

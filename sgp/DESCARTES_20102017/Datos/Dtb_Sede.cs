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
    public class Dtb_Sede
    {
        static string cad = ConfigurationManager.ConnectionStrings["dbConexion"].ConnectionString;

        public List<Etb_Sede> D_MantSede(Etb_Sede ent)
        {
            using (SqlConnection cn = new SqlConnection(cad))
            {
                List<Etb_Sede> lista = new List<Etb_Sede>();
                Etb_Sede obj;

                SqlCommand cmd = new SqlCommand("usp_mantSede", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 900000000;
                cmd.Parameters.AddWithValue("@in_Opc", ent.in_Opc);
                cmd.Parameters.AddWithValue("@in_SedeID", ent.in_SedeID);
                cmd.Parameters.AddWithValue("@in_UsuarioID", ent.in_UsuarioID);
                cmd.Parameters.AddWithValue("@vc_Sede", ent.vc_Sede);

                cn.Open();

                switch (ent.in_Opc)
                {
                    case 1:
                    case 2:
                    case 6:
                        SqlDataReader dr = cmd.ExecuteReader();
                        if (dr.HasRows)
                        {
                            while (dr.Read())
                            {
                                obj = new Etb_Sede();
                                obj.in_SedeID = dr.GetInt32(0);
                                obj.vc_Sede = dr.GetString(1);
                                obj.in_Estado = dr.GetInt32(2);
                                obj.vc_Nombres = dr.GetString(3);
                                obj.dt_FechRegistro = dr.GetString(4);
                                lista.Add(obj);
                            }
                        }
                        dr.Close();
                        break;
                    case 3:
                    case 4:
                    case 5:
                        obj = new Etb_Sede();
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

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
    public class Dtb_Campania
    {
        static string cad = ConfigurationManager.ConnectionStrings["dbConexion"].ConnectionString;


        public List<Etb_Campania> D_asignacion(Etb_Campania ent)
        {
            using (SqlConnection cn = new SqlConnection(cad))
            {
                List<Etb_Campania> lista = new List<Etb_Campania>();
                Etb_Campania obj;

                SqlCommand cmd = new SqlCommand("USP_ASIGNAR_CAMP_NIVEL", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 90000000;
                cmd.Parameters.AddWithValue("@indice", ent.indice);
                cmd.Parameters.AddWithValue("@in_campannia", ent.in_campannia);
                cmd.Parameters.AddWithValue("@in_nivel", ent.in_nivel);
                cmd.Parameters.AddWithValue("@cod", ent.cod);
                cmd.Parameters.AddWithValue("@in_UsuarioID", ent.in_usuario_reg);
                cmd.Parameters.AddWithValue("@pagenum", ent.pagenum);
                cmd.Parameters.AddWithValue("@pagesize", ent.pagesize);

                cn.Open();

                switch (ent.indice)
                {
                    case 1:
                        SqlDataReader dr = cmd.ExecuteReader();
                        if (dr.HasRows)
                        {
                            while (dr.Read())
                            {
                                obj = new Etb_Campania();
                                obj.cod = dr.GetInt32(0);
                                obj.vc_titulo = dr.GetString(1);
                                obj.vc_url_img = dr.GetString(2);
                                obj.in_orden = dr.GetInt32(3);
                  
                                lista.Add(obj);
                            }
                        }
                        dr.Close();
                        break;
                    case 2:
                        SqlDataReader dr4 = cmd.ExecuteReader();
                        if (dr4.HasRows)
                        {
                            while (dr4.Read())
                            {
                                obj = new Etb_Campania();
                                obj.cod = dr4.GetInt32(0);
                                obj.vc_titulo = dr4.GetString(1);
                                obj.total = dr4.GetInt32(2);
                                lista.Add(obj);
                            }
                        }
                        dr4.Close();
                        break;
                    case 3:
                         obj = new Etb_Campania();
                        int res = (int)cmd.ExecuteNonQuery();
                        obj.in_Resul = res;
                        lista.Add(obj);
                        break;
                    case 4:

                         obj = new Etb_Campania();
                        int res2 = (int)cmd.ExecuteNonQuery();
                        obj.in_Resul = res2;
                        lista.Add(obj);
                        break;                
                }
                cn.Close();
                return lista;
            }
        }

        public List<Etb_Campania> D_MantCampania(Etb_Campania ent)
        {
            using (SqlConnection cn = new SqlConnection(cad))
            {
                List<Etb_Campania> lista = new List<Etb_Campania>();
                Etb_Campania obj;

                SqlCommand cmd = new SqlCommand("usp_mantCampania", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 900000000;
                cmd.Parameters.AddWithValue("@in_Opc", ent.in_Opc);
                cmd.Parameters.AddWithValue("@in_CampaniaID", ent.in_CampaniaID);
                cmd.Parameters.AddWithValue("@in_SedeID", ent.in_SedeID);
                cmd.Parameters.AddWithValue("@in_UsuarioID", ent.in_UsuarioID);
                cmd.Parameters.AddWithValue("@vc_Campania", ent.vc_Campania);
          
                cn.Open();

                switch (ent.in_Opc)
                {
                    case 1:
                          SqlDataReader dr = cmd.ExecuteReader();
                        if (dr.HasRows)
                        {
                            while (dr.Read())
                            {
                                obj = new Etb_Campania();
                                obj.in_CampaniaID = dr.GetInt32(0);
                                obj.vc_Campania = dr.GetString(1);
                                obj.dt_FechRegistro = dr.GetString(3);
                                obj.in_Estado = dr.GetInt32(4);
                                lista.Add(obj);
                            }
                        }
                        dr.Close();
                        break;
                    case 2:
                        SqlDataReader dr4 = cmd.ExecuteReader();
                        if (dr4.HasRows)
                        {
                            while (dr4.Read())
                            {
                                obj = new Etb_Campania();
                                obj.in_CampaniaID = dr4.GetInt32(0);
                                obj.vc_Campania = dr4.GetString(1);
                                obj.vc_Sede = dr4.GetString(2);
                                obj.dt_FechRegistro = dr4.GetString(3);
                                obj.in_Estado = dr4.GetInt32(4);
                                obj.vc_Nombres = dr4.GetString(5);
                                //obj.dc_PagoDia = dr4.GetDecimal(6);
                                lista.Add(obj);
                            }
                        }
                        dr4.Close();
                        break;
                    case 3:
                    case 4:
                    case 5:
                    case 7:
                        obj = new Etb_Campania();
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

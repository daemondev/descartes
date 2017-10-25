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
    public class Dtb_Usuario
    {
        static string cad = ConfigurationManager.ConnectionStrings["dbConexion"].ConnectionString;

        public void finalizaSesion(Etb_Usuario usu)
        {
            using(SqlConnection cn = new SqlConnection(cad))
            {
                SqlCommand cmd = new SqlCommand("finalizaSesion", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 900000000;
                cmd.Parameters.AddWithValue("@vc_Usuario", usu.vc_Usuario);
                cmd.Parameters.AddWithValue("@vc_Clave", usu.vc_Clave);
                cn.Open();
                cmd.ExecuteNonQuery();
                cn.Close();
            }
        }


		public List<Etb_Usuario> traerAdmins()
		{
			using (SqlConnection cn = new SqlConnection(cad))
			{
				List<Etb_Usuario> lista = new List<Etb_Usuario>();
				Etb_Usuario obj;
				SqlCommand cmd = new SqlCommand("traerAdmins", cn);
				cmd.CommandType = CommandType.StoredProcedure;
				cmd.CommandTimeout = 900000000;
				cn.Open();
				SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows)
				{
					while (dr.Read())
					{
						obj = new Etb_Usuario();
						obj.in_UsuarioID = dr.GetInt32(0);
						obj.vc_Nombre = dr.GetString(1);
						lista.Add(obj);
					}
				}
				dr.Close();
				cn.Close();
				return lista;
			}
		}

		public int[] mensajesNoLeidos(int id)
        {
            using (SqlConnection cn = new SqlConnection(cad))
            {
                int[] msgsNoLeidos= new int[2];
                SqlCommand cmd = new SqlCommand("mensajesNoLeidos", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 900000000;
                cmd.Parameters.AddWithValue("@usuarioID", id);
                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();            
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        msgsNoLeidos[0] = dr.GetInt32(0);
                        msgsNoLeidos[1] = dr.GetInt32(1);
                    }
                }
                dr.Close();
                cn.Close();
                return msgsNoLeidos;
            }
        }
        //usp_cargarCombos
        public List<Etb_combos> D_cargarCombos(Etb_combos ent)
        {
            using (SqlConnection cn = new SqlConnection(cad))
            {
                List<Etb_combos> lista = new List<Etb_combos>();
                Etb_combos obj;

                SqlCommand cmd = new SqlCommand("sp_Mant_Usuario", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 900000000;
                cmd.Parameters.AddWithValue("@indice", ent.indice);
                cmd.Parameters.AddWithValue("@in_SedeID", ent.in_id);           

                cn.Open();

                     SqlDataReader dr = cmd.ExecuteReader();
                        if (dr.HasRows)
                        {
                            while (dr.Read())
                            {
                                obj = new Etb_combos();
                                obj.in_id = dr.GetInt32(0);
                                obj.vc_desc = dr.GetString(1);                       

                                lista.Add(obj);
                            }
                        }
                        dr.Close();                   
                
                cn.Close();
                return lista;
            }
        }

        public int D_MantUsuarioCarga(Etb_Usuario ent)
        {
            using (SqlConnection cn = new SqlConnection(cad))
            {
                List<Etb_Usuario> lista = new List<Etb_Usuario>();
                Etb_Usuario obj;

                SqlCommand cmd = new SqlCommand("sp_Mant_Usuario", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 900000000;
                cmd.Parameters.AddWithValue("@in_Opc", ent.in_Opc); 
                cmd.Parameters.AddWithValue("@vc_DNI", ent.vc_DNI);
                cmd.Parameters.AddWithValue("@vc_Nombre", ent.vc_Nombre);
                cmd.Parameters.AddWithValue("@vc_ApePaterno", ent.vc_ApePaterno);
                cmd.Parameters.AddWithValue("@vc_ApeMaterno", ent.vc_ApeMaterno);
                cmd.Parameters.AddWithValue("@vc_Usuario", ent.vc_Usuario);               
                //cmd.Parameters.AddWithValue("@vc_Correo", ent.vc_Correo);
                cmd.Parameters.AddWithValue("@in_PerfilID", ent.in_PerfilID);
                cmd.Parameters.AddWithValue("@in_SedeID", ent.in_SedeID);
                cmd.Parameters.AddWithValue("@in_CampaniaID", ent.in_CampaniaID);
                cn.Open();
                       
                obj = new Etb_Usuario();
                int res = (int)cmd.ExecuteNonQuery();   
                
                cn.Close();
                return res;
            }
        }


        public List<Etb_Usuario> D_MantUsuario(Etb_Usuario ent)
        {
            using (SqlConnection cn = new SqlConnection(cad))
            {
                List<Etb_Usuario> lista = new List<Etb_Usuario>();
                Etb_Usuario obj;

                SqlCommand cmd = new SqlCommand("sp_Mant_Usuario", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 900000000;
                cmd.Parameters.AddWithValue("@in_Opc", ent.in_Opc);
                cmd.Parameters.AddWithValue("@in_NumPagina", ent.in_NumPagina);
                cmd.Parameters.AddWithValue("@in_TamPagina", ent.in_TamPagina);
                cmd.Parameters.AddWithValue("@in_UsuarioID", ent.in_UsuarioID);
                cmd.Parameters.AddWithValue("@vc_DNI", ent.vc_DNI);
                cmd.Parameters.AddWithValue("@vc_Nombre", ent.vc_Nombre);
                cmd.Parameters.AddWithValue("@vc_ApePaterno", ent.vc_ApePaterno);
                cmd.Parameters.AddWithValue("@vc_ApeMaterno", ent.vc_ApeMaterno);
                cmd.Parameters.AddWithValue("@vc_Usuario", ent.vc_Usuario);
                cmd.Parameters.AddWithValue("@vc_Clave", ent.vc_Clave);
                //cmd.Parameters.AddWithValue("@vc_Correo", ent.vc_Correo);
                cmd.Parameters.AddWithValue("@in_PerfilID", ent.in_PerfilID);
                cmd.Parameters.AddWithValue("@in_SedeID", ent.in_SedeID);
                cmd.Parameters.AddWithValue("@in_CampaniaID", ent.in_CampaniaID);
                cn.Open();

                switch (ent.in_Opc)
                {
                    case 1:
                    case 2:
                    case 3:
                        SqlDataReader dr = cmd.ExecuteReader();
                        if (dr.HasRows)
                        {
                            while (dr.Read())
                            {
                                obj = new Etb_Usuario();
                                obj.in_UsuarioID = dr.GetInt32(0);
                                obj.vc_DNI = dr.GetString(1);
                                obj.vc_Nombre = dr.GetString(2);
                                obj.vc_ApePaterno = dr.GetString(3);
                                obj.vc_ApeMaterno = dr.GetString(4);
                                obj.vc_Usuario = dr.GetString(5);
                                //obj.vc_Correo = dr.GetString(6);

                                obj.vc_Clave = dr.GetString(7);
                                obj.in_PerfilID = dr.GetInt32(8);
                                obj.vc_Perfil = dr.GetString(9);
                                obj.in_SedeID = dr.GetInt32(10);
                                obj.vc_Sede = dr.GetString(11);                                
                                obj.vc_FecRegistro = dr.GetString(12);
                                obj.in_Estado = dr.GetInt32(13);
                                obj.in_CampaniaID = dr.GetInt32(14);
                                obj.vc_CampaniaID = dr.GetString(15);
                                obj.in_TotalRegistros = dr.GetInt32(16);
                                
                                //obj.in_PerfilID = dr.GetInt32(7);
                                //obj.in_SedeID = dr.GetInt32(8);

                                lista.Add(obj);
                            }
                        }
                        dr.Close();
                        break;
                    case 4:
                    case 5:
                    case 6:
                        obj = new Etb_Usuario();
                        int res = (int)cmd.ExecuteNonQuery();
                        obj.in_Resul = res;
                        lista.Add(obj);
                        break;
                    case 8:
                        dr = cmd.ExecuteReader();
                        if (dr.HasRows)
                        {
                            while (dr.Read())
                            {
                                obj = new Etb_Usuario();
                                obj.in_UsuarioID = dr.GetInt32(0);
                                obj.vc_Nombre = dr.GetString(1);
                                obj.vc_ApePaterno = dr.GetString(2);
                                obj.vc_ApeMaterno = dr.GetString(3);
                                obj.vc_Usuario = dr.GetString(4);
                                obj.vc_Perfil = dr.GetString(5);
                                obj.EstadoConexion = dr.GetBoolean(6);
                                obj.msgsNoleidos = dr.GetInt32(7);
                                obj.in_TotalRegistros = dr.GetInt32(8);                               
                                lista.Add(obj);
                            }
                        }
                        dr.Close();
                        break;
					case 9:
						dr = cmd.ExecuteReader();
						if (dr.HasRows)
						{
							while (dr.Read())
							{
								obj = new Etb_Usuario();
								obj.in_UsuarioID = dr.GetInt32(0);
								obj.vc_Nombre = dr.GetString(1);
								obj.vc_ApePaterno = dr.GetString(2);
								obj.vc_ApeMaterno = dr.GetString(3);
								obj.vc_Usuario = dr.GetString(4);
								obj.vc_Perfil = dr.GetString(5);
								obj.EstadoConexion = dr.GetBoolean(6);
								obj.msgsNoleidos = dr.GetInt32(7);
								obj.in_TotalRegistros = dr.GetInt32(8);
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

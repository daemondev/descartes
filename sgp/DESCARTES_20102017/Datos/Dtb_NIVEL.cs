using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Entidad;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

	namespace Datos
{
	public class Dtb_NIVEL
	{
		static string cad = ConfigurationManager.ConnectionStrings["dbConexion"].ConnectionString;

		public List<Etb_NIVEL> Da_ArmarPreview(Etb_NIVEL ent)
		{
			List<Etb_NIVEL> lista = new List<Etb_NIVEL>();
			Etb_NIVEL obj;
			int res;
			using (SqlConnection cn = new SqlConnection(cad))
			{
				
					

						SqlCommand cmd = new SqlCommand("USP_ARMAR_preview", cn);
						cmd.CommandType = CommandType.StoredProcedure;
						cmd.CommandTimeout = 900000000;
						cmd.Parameters.AddWithValue("@INDICE", ent.indice);
						cmd.Parameters.AddWithValue("@in_parametro", ent.in_dpndncia_idnivel);
                        if (ent.in_dpndncia_idnivel == 0)
                        {
                        cmd.Parameters.AddWithValue("@vc_UsuarioID", Convert.ToString(ent.in_UsuarioID));
                        }
                       
					

						cn.Open();
						SqlDataReader dr = cmd.ExecuteReader();
						if (dr.HasRows)
						{
							while (dr.Read())
							{
								obj = new Etb_NIVEL();
								obj.id_nivel = dr.GetInt32(0);
								obj.in_cate = dr.GetInt32(1);
								obj.vc_titulo = dr.GetString(2);
								obj.vc_descripcion = dr.GetString(3);
								obj.vc_url_img = dr.GetString(4);
								obj.in_rpta = dr.GetInt32(5);								
								obj.in_dpndncia_idnivel = dr.GetInt32(6);
								obj.vc_alerta = dr.GetString(7);
								obj.in_link = dr.GetInt32(8);
                                obj.vc_color_alerta = dr.GetString(9);
								lista.Add(obj);
							}
						}
						cn.Close();
										

				
			}



			return lista;
		}

		public List<Etb_NIVEL> traerMatrices()
		{
			List<Etb_NIVEL> lista = new List<Etb_NIVEL>();
			Etb_NIVEL obj;
			using (SqlConnection cn = new SqlConnection(cad))
			{
				SqlCommand cmd = new SqlCommand("traerMatrices", cn);
				cmd.CommandType = CommandType.StoredProcedure;
				cmd.CommandTimeout = 900000000;
				cn.Open();
				SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows)
				{
					while (dr.Read())
					{
						obj = new Etb_NIVEL();
						obj.id_nivel = dr.GetInt32(0);
						obj.vc_titulo = dr.GetString(1);
						lista.Add(obj);
					}
				}
				cn.Close();
			}
			return lista;
		}

		public List<Etb_NIVEL> traerProcesos(Etb_NIVEL ent)
		{
			List<Etb_NIVEL> lista = new List<Etb_NIVEL>();
			Etb_NIVEL obj;
			using (SqlConnection cn = new SqlConnection(cad))
			{
				SqlCommand cmd = new SqlCommand("traerProcesos", cn);
				cmd.CommandType = CommandType.StoredProcedure;
				cmd.CommandTimeout = 900000000;
				cmd.Parameters.AddWithValue("@matrizAnterior", ent.in_dpndncia_idnivel);
				cn.Open();
				SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows)
				{
					while (dr.Read())
					{
						obj = new Etb_NIVEL();
						obj.id_nivel = dr.GetInt32(0);
						obj.vc_titulo = dr.GetString(1);
						lista.Add(obj);
					}
				}
				cn.Close();
			}
			return lista;
		}

		public List<Etb_NIVEL> dameTitulo(Etb_NIVEL ent)
		{
			List<Etb_NIVEL> lista = new List<Etb_NIVEL>();
			Etb_NIVEL obj;
			using (SqlConnection cn = new SqlConnection(cad))
			{
				SqlCommand cmd = new SqlCommand("dameTitulo", cn);
				cmd.CommandType = CommandType.StoredProcedure;
				cmd.CommandTimeout = 900000000;
				cmd.Parameters.AddWithValue("@id_nivel", ent.id_nivel);
				cn.Open();
				SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows)
				{
					while (dr.Read())
					{
						obj = new Etb_NIVEL();
						obj.vc_titulo = dr.GetString(0);
						lista.Add(obj);
					}
				}
				cn.Close();
			}
			return lista;
		}

		public List<Etb_NIVEL> D_manNivel(Etb_NIVEL ent)
		{
			List<Etb_NIVEL> lista = new List<Etb_NIVEL>();
			Etb_NIVEL obj;
			int res;
			using (SqlConnection cn = new SqlConnection(cad))
			{
				SqlCommand cmd = new SqlCommand("USP_MANT_NIVEL", cn);
				cmd.CommandType = CommandType.StoredProcedure;
				cmd.CommandTimeout = 900000000;
				Etb_NIVEL objN;

				switch (ent.indice)
				{
					case 1:
				
					cmd.Parameters.AddWithValue("@INDICE", ent.indice);
					cmd.Parameters.AddWithValue("@in_dpndncia_idnivel", ent.in_dpndncia_idnivel);
					cmd.Parameters.AddWithValue("@pagenum", ent.pagenum);
					cmd.Parameters.AddWithValue("@pagesize", ent.pagesize);

					cn.Open();
					SqlDataReader dr = cmd.ExecuteReader();
					if (dr.HasRows)
					{
						while (dr.Read())
						{
							obj = new Etb_NIVEL();
							obj.id_nivel = dr.GetInt32(0); //validar fecha de pago
							obj.in_cate = dr.GetInt32(1);
							obj.vc_titulo = dr.GetString(2);
							obj.vc_descripcion = dr.GetString(3);
							obj.vc_url_img = dr.GetString(4);
							obj.in_rpta = dr.GetInt32(5);
							obj.in_tipo_rpta = dr.GetInt32(6);
							obj.in_dpndncia_idnivel= dr.GetInt32(7);
							obj.vc_alerta = dr.GetString(8);
							obj.in_orden = dr.GetInt32(9);
							obj.in_estado = dr.GetInt32(10);
							obj.in_link = dr.GetInt32(11);
							//obj.vc_enlase = dr.GetString(12);
                            obj.vc_color_alerta = dr.GetString(12);
							obj.total = dr.GetInt32(13);
							lista.Add(obj);
						}
					}
					cn.Close();
					
					break;
					case 2:
			
					cmd.Parameters.AddWithValue("@INDICE", ent.indice);
					cmd.Parameters.AddWithValue("@IN_CATE", ent.in_cate);
					cmd.Parameters.AddWithValue("@VC_TITULO", ent.vc_titulo);
					cmd.Parameters.AddWithValue("@vc_descripcion", ent.vc_descripcion);
					if (ent.vc_url_img != "")
					{
						cmd.Parameters.AddWithValue("@vc_url_img", ent.vc_url_img);
					}					
					cmd.Parameters.AddWithValue("@in_rpta", ent.in_rpta);
					cmd.Parameters.AddWithValue("@in_dpndncia_idnivel", ent.in_dpndncia_idnivel);
					cmd.Parameters.AddWithValue("@vc_alerta", ent.vc_alerta);
					cmd.Parameters.AddWithValue("@IN_ID_LINK", ent.in_link);
					cmd.Parameters.AddWithValue("@vc_color_alerta", ent.vc_color_alerta);



					cn.Open();

				
					objN= new Etb_NIVEL();
						
                         res = (int)cmd.ExecuteNonQuery();
                        objN.in_result = res;
                        lista.Add(objN);
						cn.Close();
                        break;

					case 3:
				
						cmd.Parameters.AddWithValue("@INDICE", ent.indice);
						cmd.Parameters.AddWithValue("@IN_CATE", ent.in_cate);
						cmd.Parameters.AddWithValue("@VC_TITULO", ent.vc_titulo);
						cmd.Parameters.AddWithValue("@vc_descripcion", ent.vc_descripcion);

						if (ent.vc_url_img != null)
						{
							cmd.Parameters.AddWithValue("@vc_url_img", ent.vc_url_img);
						}
						cmd.Parameters.AddWithValue("@in_rpta", ent.in_rpta);
						cmd.Parameters.AddWithValue("@in_dpndncia_idnivel", ent.in_dpndncia_idnivel);
						cmd.Parameters.AddWithValue("@vc_alerta", ent.vc_alerta);
						cmd.Parameters.AddWithValue("@IN_ID_LINK", ent.in_link);
						cmd.Parameters.AddWithValue("@vc_color_alerta", ent.vc_color_alerta);
						cmd.Parameters.AddWithValue("@ID_NIVEL", ent.id_nivel);

						cn.Open();

						objN = new Etb_NIVEL();

						res = (int)cmd.ExecuteNonQuery();
						objN.in_result = res;
						lista.Add(objN);
						cn.Close();
						break;

					case 4:
					
						cmd.Parameters.AddWithValue("@INDICE", ent.indice);
						cmd.Parameters.AddWithValue("@ID_NIVEL", ent.id_nivel);	

					cn.Open();
						 
					objN= new Etb_NIVEL();

					res = (int)cmd.ExecuteNonQuery();
                        objN.in_result = res;
                        lista.Add(objN);
						cn.Close();

						break;

					case 5:
						
					
						cmd.Parameters.AddWithValue("@INDICE", ent.indice);
						cmd.Parameters.AddWithValue("@ID_NIVEL", ent.id_nivel);
						cmd.Parameters.AddWithValue("@IN_ESTADO", ent.in_estado);

						cn.Open();
						objN = new Etb_NIVEL();

						res = (int)cmd.ExecuteNonQuery();
						objN.in_result = res;
						lista.Add(objN);
						cn.Close();

						break;

					case 6:


						cmd.Parameters.AddWithValue("@INDICE", ent.indice);
						cmd.Parameters.AddWithValue("@ID_NIVEL", ent.id_nivel);
						cmd.Parameters.AddWithValue("@IN_ID_LINK", ent.in_link);

						cn.Open();
						objN = new Etb_NIVEL();

						res = (int)cmd.ExecuteNonQuery();
						objN.in_result = res;
						lista.Add(objN);
						cn.Close();

						break;
				}
			}



			return lista;
		}

		public Int32 Guardar_Contenidos(Etb_NIVEL ent,Int32 op)
		{
			Int32 resul = 0;
			using (SqlConnection cn = new SqlConnection(cad))
			{
				SqlCommand cmd = new SqlCommand("usp_mantContenido_Nivel", cn);
				cmd.CommandType = CommandType.StoredProcedure;
				cmd.CommandTimeout = 900000000;
				cmd.Parameters.AddWithValue("@in_opc", op);
				cmd.Parameters.AddWithValue("@in_idnivel", ent.id_nivel);
				cmd.Parameters.AddWithValue("@vc_contenido", ent.vc_contexto);
				cmd.Parameters.AddWithValue("@vc_color", ent.vc_color);
				cmd.Parameters.AddWithValue("@in_subrayado", ent.vc_subrayado);
				cn.Open();
				resul=(Int32)cmd.ExecuteNonQuery();
				cn.Close();
			}
			return resul;
		}

		public Int32 Actualizar_Contenidos(Etb_NIVEL ent, Int32 op)
		{
			Int32 resul = 0;
			using (SqlConnection cn = new SqlConnection(cad))
			{
				SqlCommand cmd = new SqlCommand("usp_mantContenido_Nivel", cn);
				cmd.CommandType = CommandType.StoredProcedure;
				cmd.CommandTimeout = 900000000;
				cmd.Parameters.AddWithValue("@in_opc", op);
				cmd.Parameters.AddWithValue("@in_idcontenido", ent.in_idcontenido);
				cmd.Parameters.AddWithValue("@vc_contenido", ent.vc_contexto);
				cmd.Parameters.AddWithValue("@vc_color", ent.vc_color);
				cmd.Parameters.AddWithValue("@in_subrayado", ent.vc_subrayado);
				cn.Open();
				resul = (Int32)cmd.ExecuteNonQuery();
				cn.Close();
			}
			return resul;
		}

		public Int32 Estado_Contenidos(Int32 in_idcontenido, Int32 op)
		{
			Int32 resul = 0;
			using (SqlConnection cn = new SqlConnection(cad))
			{
				SqlCommand cmd = new SqlCommand("usp_mantContenido_Nivel", cn);
				cmd.CommandType = CommandType.StoredProcedure;
				cmd.CommandTimeout = 900000000;
				cmd.Parameters.AddWithValue("@in_opc", op);
				cmd.Parameters.AddWithValue("@in_idcontenido", in_idcontenido);
				cn.Open();
				resul = (Int32)cmd.ExecuteNonQuery();
				cn.Close();
			}
			return resul;
		}

		public List<Etb_NIVEL> Lista_Contenidos(Int32 op, Int32 in_idnivel, Int32 tamPagina, Int32 nroPagina)
		{
			List<Etb_NIVEL> lista = new List<Etb_NIVEL>();
			Etb_NIVEL obj;
			using (SqlConnection cn = new SqlConnection(cad))
			{
				SqlCommand cmd = new SqlCommand("usp_mantContenido_Nivel", cn);
				cmd.CommandType = CommandType.StoredProcedure;
				cmd.CommandTimeout = 900000000;
				cmd.Parameters.AddWithValue("@in_Opc", op);
				cmd.Parameters.AddWithValue("@in_idnivel", in_idnivel);
				cmd.Parameters.AddWithValue("@pagenum", nroPagina);
				cmd.Parameters.AddWithValue("@pagesize", tamPagina);
				cn.Open();
				SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows)
				{
					while (dr.Read())
					{
						obj = new Etb_NIVEL();
						obj.in_idcontenido = dr.GetInt32(0);
						obj.vc_contexto = dr.GetString(1);
						obj.vc_color = dr.GetString(2);
						obj.vc_subrayado = dr.GetString(3);
						obj.in_estado = dr.GetInt32(4);
						obj.total = dr.GetInt32(5);
						lista.Add(obj);
					}
				}
				cn.Close();
			}
			return lista;
		}

		public List<Etb_NIVEL> Lista_Contenidos(Int32 op, Int32 in_idcontenido)
		{
			List<Etb_NIVEL> lista = new List<Etb_NIVEL>();
			Etb_NIVEL obj;
			using (SqlConnection cn = new SqlConnection(cad))
			{
				SqlCommand cmd = new SqlCommand("usp_mantContenido_Nivel", cn);
				cmd.CommandType = CommandType.StoredProcedure;
				cmd.CommandTimeout = 900000000;
				cmd.Parameters.AddWithValue("@in_Opc", op);
				cmd.Parameters.AddWithValue("@in_idcontenido", in_idcontenido);
				cn.Open();
				SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows)
				{
					while (dr.Read())
					{
						obj = new Etb_NIVEL();
						obj.in_idcontenido = dr.GetInt32(0);
						obj.vc_contexto = dr.GetString(1);
						obj.vc_color = dr.GetString(2);
						obj.vc_subrayado = Convert.ToString(dr.GetInt32(3));
						lista.Add(obj);
					}
				}
				cn.Close();
			}
			return lista;
		}

		public List<Etb_NIVEL> Armar_Contenidos(Int32 op, Int32 in_idnivel)
		{
			List<Etb_NIVEL> lista = new List<Etb_NIVEL>();
			Etb_NIVEL obj;
			using (SqlConnection cn = new SqlConnection(cad))
			{
				SqlCommand cmd = new SqlCommand("usp_mantContenido_Nivel", cn);
				cmd.CommandType = CommandType.StoredProcedure;
				cmd.CommandTimeout = 900000000;
				cmd.Parameters.AddWithValue("@in_Opc", op);
				cmd.Parameters.AddWithValue("@in_idnivel", in_idnivel);
				cn.Open();
				SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows)
				{
					while (dr.Read())
					{
						obj = new Etb_NIVEL();
						obj.in_idcontenido = dr.GetInt32(0);
						obj.vc_contexto = dr.GetString(1);
						obj.vc_color = dr.GetString(2);
						obj.vc_subrayado = Convert.ToString(dr.GetInt32(3));
						lista.Add(obj);
					}
				}
				cn.Close();
			}
			return lista;
		}
	}
}

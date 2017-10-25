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
	public class Dtb_CargarClientes
	{
		static string cad = ConfigurationManager.ConnectionStrings["dbConexion"].ConnectionString;

		public int D_MantCargaClientes(Etb_Cliente ent)
		{
			using (SqlConnection cn = new SqlConnection(cad))
			{
				List<Etb_Cliente> lista = new List<Etb_Cliente>();
				Etb_Cliente obj;

				SqlCommand cmd = new SqlCommand("USP_MANT_CLIENTE", cn);
				cmd.CommandType = CommandType.StoredProcedure;
				cmd.CommandTimeout = 900000000;
				cmd.Parameters.AddWithValue("@INDICE", ent.indice);
				cmd.Parameters.AddWithValue("@VC_NOMBRE", ent.vc_nombre);
				cmd.Parameters.AddWithValue("@VC_CODIGO", ent.vc_codigo);
				cmd.Parameters.AddWithValue("@VC_APELLIDOS", ent.vc_apellidos);
				cmd.Parameters.AddWithValue("@IN_ARCHIVO", ent.in_archivo);
				cmd.Parameters.AddWithValue("@ID_CLIENTE", ent.id_cliente);

				cn.Open();
				obj = new Etb_Cliente();

				int res = (int)cmd.ExecuteNonQuery();			
			

				cn.Close();
				return res;
			}
		}

		public int D_ModEstadoClientes(Etb_Cliente ent)
		{
			using (SqlConnection cn = new SqlConnection(cad))
			{
				List<Etb_Cliente> lista = new List<Etb_Cliente>();
				Etb_Cliente obj;

				SqlCommand cmd = new SqlCommand("USP_MANT_CLIENTE", cn);
				cmd.CommandType = CommandType.StoredProcedure;
				cmd.CommandTimeout = 900000;
				cmd.Parameters.AddWithValue("@INDICE", ent.indice);				
				cmd.Parameters.AddWithValue("@ID_CLIENTE", ent.id_cliente);
				cmd.Parameters.AddWithValue("@in_estado", ent.in_estado);
				cn.Open();
				obj = new Etb_Cliente();

				int res = (int)cmd.ExecuteNonQuery();


				cn.Close();
				return res;
			}
		}
		public int D_DeleteClientes(Etb_Cliente ent)
		{
			using (SqlConnection cn = new SqlConnection(cad))
			{
				List<Etb_Cliente> lista = new List<Etb_Cliente>();
				Etb_Cliente obj;

				SqlCommand cmd = new SqlCommand("USP_MANT_CLIENTE", cn);
				cmd.CommandType = CommandType.StoredProcedure;
				cmd.CommandTimeout = 900000;
				cmd.Parameters.AddWithValue("@INDICE", ent.indice);
				cmd.Parameters.AddWithValue("@ID_CLIENTE", ent.id_cliente);

				cn.Open();
				obj = new Etb_Cliente();

				int res = (int)cmd.ExecuteNonQuery();


				cn.Close();
				return res;
			}
		}

		public List<Etb_Cliente> D_UpdateClientes(Etb_Cliente ent)
		{
			using (SqlConnection cn = new SqlConnection(cad))
			{
				List<Etb_Cliente> lista = new List<Etb_Cliente>();
				Etb_Cliente obj;

				SqlCommand cmd = new SqlCommand("USP_MANT_CLIENTE", cn);
				cmd.CommandType = CommandType.StoredProcedure;
				cmd.CommandTimeout = 900000000;
				cmd.Parameters.AddWithValue("@INDICE", ent.indice);
				cmd.Parameters.AddWithValue("@VC_NOMBRE", ent.vc_nombre);
				cmd.Parameters.AddWithValue("@VC_CODIGO", ent.vc_codigo);
				cmd.Parameters.AddWithValue("@IN_ARCHIVO", ent.in_archivo);

				cn.Open();
				obj = new Etb_Cliente();
				int res = (int)cmd.ExecuteNonQuery();
				obj.in_Resul = res;
				lista.Add(obj);

				cn.Close();
				return lista;
			}
		}
		public List<Etb_Cliente> D_ListarClientes(Etb_Cliente ent)
		{
			using (SqlConnection cn = new SqlConnection(cad))
			{
				List<Etb_Cliente> lista = new List<Etb_Cliente>();
				
				Etb_Cliente obj;

				SqlCommand cmd = new SqlCommand("USP_MANT_CLIENTE", cn);
				cmd.CommandType = CommandType.StoredProcedure;
				cmd.CommandTimeout = 900000000;
				cmd.Parameters.AddWithValue("@INDICE", ent.indice);
				cmd.Parameters.AddWithValue("@pagenum", ent.pagenum);
				cmd.Parameters.AddWithValue("@pagesize", ent.pagesize);

				cn.Open();
				SqlDataReader dr = cmd.ExecuteReader();

				while (dr.Read())
				{
					obj = new Etb_Cliente();
					obj.id_cliente = dr.GetInt32(0);
					obj.vc_nombre = dr.GetString(1);
					obj.vc_apellidos = dr.GetString(2);
					obj.vc_codigo = dr.GetString(3);
					obj.dt_fecregistro = Convert.ToString(dr.GetDateTime(4));
					obj.in_estado = dr.GetInt32(5);
					obj.total = dr.GetInt32(6);
					lista.Add(obj);						
				}				
				cn.Close();
				return lista;
			}
		}
	}
}

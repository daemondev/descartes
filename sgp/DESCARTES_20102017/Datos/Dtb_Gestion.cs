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
	public class Dtb_Gestion
	{
		static string cad = ConfigurationManager.ConnectionStrings["dbConexion"].ConnectionString;

		
        public List<Etb_Cliente> D_Gestion_guardar(Etb_Gestion entG)
		{
			List<Etb_Cliente> lista = new List<Etb_Cliente>();
			Etb_Cliente obj;
			int res;
			using (SqlConnection cn = new SqlConnection(cad))
			{
				SqlCommand cmd = new SqlCommand("USP_GESTION", cn);
				cmd.CommandType = CommandType.StoredProcedure;
				cmd.CommandTimeout = 900000000;
				Etb_Cliente objN;

				switch (entG.indice)
				{					
					case 2:
												
						cmd.Parameters.AddWithValue("@INDICE", entG.indice);
						cmd.Parameters.AddWithValue("@IN_USUARIO", entG.in_usuario);
                        cmd.Parameters.AddWithValue("@PROCESO", entG.proceso);
                        cmd.Parameters.AddWithValue("@VC_TIPIFICACION", entG.vc_tipificacion);
                        cmd.Parameters.AddWithValue("@HORAINICIO", entG.horaInicio);
                        cmd.Parameters.AddWithValue("@VC_DURACION", entG.vc_duracion);                         

						cn.Open();

						objN = new Etb_Cliente();

						res = (int)cmd.ExecuteScalar();						
						obj= new Etb_Cliente();
						obj.in_result = res;
						lista.Add(obj);					

						cn.Close();
						break;

				}
			}



			return lista;
		}

        public List<Etb_Cliente> D_ConsultarHistorial(Etb_Cliente ent)
        {
            List<Etb_Cliente> lista = new List<Etb_Cliente>();
            Etb_Cliente obj;
            int res;
            using (SqlConnection cn = new SqlConnection(cad))
            {
                SqlCommand cmd = new SqlCommand("USP_VERHISTORIAL", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 900000000;
            

                switch (ent.indice)
                {
                    case 1:

                        cmd.Parameters.AddWithValue("@INDICE", ent.indice);
                        cmd.Parameters.AddWithValue("@VC_CODIGO", ent.vc_codigo);
                        cmd.Parameters.AddWithValue("@pagenum", ent.pagenum);
                        cmd.Parameters.AddWithValue("@pagesize", ent.pagesize);

                        cn.Open();
                        SqlDataReader dr = cmd.ExecuteReader();
                        if (dr.HasRows)
                        {
                            while (dr.Read())
                            {
                                obj = new Etb_Cliente();
                                obj.vc_nombre = dr.GetString(0); 
                                obj.vc_codigo = dr.GetString(1);
                                obj.vc_resultado =  dr.GetString(2);
                                obj.dt_fecregistro = dr.GetString(3);
                                obj.vc_duracion = dr.GetString(4);
                                obj.vc_tipificacion = dr.GetString(5);
                                obj.vc_obs = dr.GetString(6);
                                obj.total = dr.GetInt32(7);
                                lista.Add(obj);
                            }
                        }
                        cn.Close();
                        break;  
                }
            }



            return lista;
        }

        /*public List<Etb_Cliente> D_Gestion(Etb_Cliente ent)
		{
			List<Etb_Cliente> lista = new List<Etb_Cliente>();
			Etb_Cliente obj;
			int res;
			using (SqlConnection cn = new SqlConnection(cad))
			{
				SqlCommand cmd = new SqlCommand("USP_GESTION", cn);
				cmd.CommandType = CommandType.StoredProcedure;
				cmd.CommandTimeout = 900000000;
				Etb_Cliente objN;

				switch (ent.indice)
				{
					case 1:

						cmd.Parameters.AddWithValue("@INDICE", ent.indice);
						cmd.Parameters.AddWithValue("@VALUE", ent.vc_value);
				
						cn.Open();
						SqlDataReader dr = cmd.ExecuteReader();
						if (dr.HasRows)
						{
							while (dr.Read())
							{
								obj = new Etb_Cliente();
								obj.id_cliente = dr.GetInt32(0); //validar fecha de pago
								obj.vc_nombre = dr.GetString(1);
								obj.vc_codigo = dr.GetString(2);
								obj.vc_apellidos = dr.GetString(3);
								obj.in_estado = dr.GetInt32(4);
								lista.Add(obj);
							}
						}
						cn.Close();

						break;
					case 2:
						Etb_Gestion entG;
						entG = new Etb_Gestion();
						cmd.Parameters.AddWithValue("@INDICE", entG.indice);					
						cmd.Parameters.AddWithValue("@IN_USUARIO", entG.in_usuario);
						cmd.Parameters.AddWithValue("@IN_CLIENTE", entG.in_cliente);
						cmd.Parameters.AddWithValue("@VC_TIPIFICACION", entG.vc_tipificacion);
						cmd.Parameters.AddWithValue("@VC_DURACION", entG.vc_duracion);
						cmd.Parameters.AddWithValue("@VC_RESULTADO", entG.vc_resultado);					

						cn.Open();

						objN = new Etb_Cliente();

						res = (int)cmd.ExecuteNonQuery();

						SqlCommand cmdid= new SqlCommand("select top 1 ID from TBL_GESTION order by ID desc");
						cmdid.CommandType=CommandType.Text;
						SqlDataReader dr2 = cmd.ExecuteReader();
						if (dr2.HasRows)
						{
							while(dr2.Read()){
								obj= new Etb_Cliente();
								obj.in_result=dr2.GetInt32(0);
								lista.Add(obj);
							}
						}			
                  
						cn.Close();
						break;

									}
			}



			return lista;
		}*/
    }
}

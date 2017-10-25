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
    public class Dtb_Mensaje
    {
        static string cad = ConfigurationManager.ConnectionStrings["dbConexion"].ConnectionString;

        public List<Etb_Mensaje> mostrarChat(int Emisor, int Receptor)
        {
            using (SqlConnection cn = new SqlConnection(cad))
            {
                List<Etb_Mensaje> lista = new List<Etb_Mensaje>();
                Etb_Mensaje obj;

                SqlCommand cmd = new SqlCommand("sp_mostrarChat", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 900000000;
                cmd.Parameters.AddWithValue("@Emisor", Emisor);
                cmd.Parameters.AddWithValue("@Receptor", Receptor);

                cn.Open();

                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        obj = new Etb_Mensaje();
                        obj.in_MensajeID = dr.GetInt32(0);
                        obj.emisor = dr.GetInt32(1);
                        obj.receptor = dr.GetInt32(2);
                        obj.mensaje = dr.GetString(3);
                        obj.FechaHoraMSG = Convert.ToString(dr.GetDateTime(4));
                        obj.visto = dr.GetBoolean(5);
                        obj.nombreEmisor = dr.GetString(6);
                        lista.Add(obj);
                    }
                }
                dr.Close();

                cn.Close();
                return lista;
            }
        }

        public void EnviarMensaje(string mensaje, int emisor, int receptor)
        {
            using (SqlConnection cn = new SqlConnection(cad))
            {
                SqlCommand cmd = new SqlCommand("enviarMensaje", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 900000000;
                cmd.Parameters.AddWithValue("@mensaje", mensaje);
                cmd.Parameters.AddWithValue("@emisor", emisor);
                cmd.Parameters.AddWithValue("@receptor", receptor);
                cn.Open();
                cmd.ExecuteNonQuery();
                cn.Close();
            }
        }

        public void EliminarHistorial(int emisor, int receptor)
        {
            using (SqlConnection cn = new SqlConnection(cad))
            {
                SqlCommand cmd = new SqlCommand("EliminarHistorial", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 900000000;                
                cmd.Parameters.AddWithValue("@emisor", emisor);
                cmd.Parameters.AddWithValue("@receptor", receptor);
                cn.Open();
                cmd.ExecuteNonQuery();
                cn.Close();
            }
        }
    }
}

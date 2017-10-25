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
    public class Dtb_Capacitador
    {
        static string cad = ConfigurationManager.ConnectionStrings["dbConexion"].ConnectionString;

        public List<Etb_Capacitador> D_MantCapacitador(Etb_Capacitador ent)
        {
            using (SqlConnection cn = new SqlConnection(cad))
            {
                List<Etb_Capacitador> lista = new List<Etb_Capacitador>();
                Etb_Capacitador obj;

                SqlCommand cmd = new SqlCommand("usp_MantCapacitador", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 900000000;
                cmd.Parameters.AddWithValue("@in_Opc", ent.in_Opc);
                cmd.Parameters.AddWithValue("@in_NumPagina", ent.in_NumPagina);
                cmd.Parameters.AddWithValue("@in_TamPagina", ent.in_TamPagina);
                cmd.Parameters.AddWithValue("@in_CapacitadorID", ent.in_CapacitadorID);
                cmd.Parameters.AddWithValue("@in_UsuRegistroID", ent.in_UsuarioID);
                cmd.Parameters.AddWithValue("@vc_DNI", ent.vc_DNI);
                cmd.Parameters.AddWithValue("@vc_Nombre", ent.vc_Nombre);
                cmd.Parameters.AddWithValue("@vc_ApePaterno", ent.vc_ApePaterno);
                cmd.Parameters.AddWithValue("@vc_ApeMaterno", ent.vc_ApeMaterno);
                cmd.Parameters.AddWithValue("@vc_Usuario", ent.vc_Usuario);
                cmd.Parameters.AddWithValue("@vc_Clave", ent.vc_Clave);
                cmd.Parameters.AddWithValue("@vc_Buscar", ent.vc_Buscar);
                cmd.Parameters.AddWithValue("@in_SedeID", ent.in_SedeID);
                cmd.Parameters.AddWithValue("@in_CampaniaID", ent.in_CampaniaID);

                cn.Open();

                switch (ent.in_Opc)
                {
                    case 1:
                    case 2:
                        SqlDataReader dr = cmd.ExecuteReader();
                        if (dr.HasRows)
                        {
                            while (dr.Read())
                            {
                                obj = new Etb_Capacitador();
                                obj.in_CapacitadorID = dr.GetInt32(0);
                                obj.vc_DNI = dr.GetString(1);
                                obj.vc_Nombre = dr.GetString(2);
                                obj.vc_ApePaterno = dr.GetString(3);
                                obj.vc_ApeMaterno = dr.GetString(4);
                                obj.vc_Usuario = dr.GetString(5);
                                if (ent.in_Opc == 1)
                                {
                                    obj.vc_FecRegistro = dr.GetString(6);
                                    obj.NomRegistro = dr.GetString(7);
                                    obj.in_Estado = dr.GetInt32(8);
                                    obj.in_TotalRegistros = dr.GetInt32(9);
                                }
                                lista.Add(obj);
                            }
                        }
                        dr.Close();
                        break;
                    case 3:
                    case 4:
                    case 5:
                        obj = new Etb_Capacitador();
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

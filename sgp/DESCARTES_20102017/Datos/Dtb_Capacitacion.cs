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
    public class Dtb_Capacitacion
    {
        static string cad = ConfigurationManager.ConnectionStrings["dbConexion"].ConnectionString;

        public List<Etb_Capacitacion> D_MantCapacitacion(Etb_Capacitacion ent)
        {
            using (SqlConnection cn = new SqlConnection(cad))
            {
                List<Etb_Capacitacion> lista = new List<Etb_Capacitacion>();
                Etb_Capacitacion obj;

                SqlCommand cmd = new SqlCommand("usp_MantCapacitacion", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 900000000;
                cmd.Parameters.AddWithValue("@in_Opc", ent.in_Opc);
                cmd.Parameters.AddWithValue("@in_NumPagina", ent.in_NumPagina);
                cmd.Parameters.AddWithValue("@in_TamPagina", ent.in_TamPagina);
                cmd.Parameters.AddWithValue("@in_CapaID", ent.in_CapaID);
                cmd.Parameters.AddWithValue("@vc_Abreviatura", ent.vc_Abreviatura);
                cmd.Parameters.AddWithValue("@vc_Titulo", ent.vc_Titulo);
                cmd.Parameters.AddWithValue("@in_CampaniaID", ent.in_CampaniaID);
                cmd.Parameters.AddWithValue("@vc_FechInicio", ent.dt_FechInicio);
                cmd.Parameters.AddWithValue("@in_UsuarioID", ent.in_UsuarioID);
                cmd.Parameters.AddWithValue("@in_CantAgentes", ent.in_CantAgentes);
                cmd.Parameters.AddWithValue("@in_CantDias", ent.in_CantDias);
                cmd.Parameters.AddWithValue("@dc_PagoTotal", ent.dc_PagoTotal);
                cmd.Parameters.AddWithValue("@dc_PagoDia", ent.dc_PagoDia);
                cmd.Parameters.AddWithValue("@in_CantPartes", ent.in_CantPartes);
                cmd.Parameters.AddWithValue("@vc_Cierre", ent.vc_Cierre);
                cmd.Parameters.AddWithValue("@vc_Monto", ent.vc_Monto);
                cmd.Parameters.AddWithValue("@vc_Pago", ent.vc_Pago);
                cmd.Parameters.AddWithValue("@in_Turno", ent.in_TurnoID);

                cn.Open();

                switch (ent.in_Opc)
                {
                    case 1:
                    case 3:
                    case 4:
                    case 5:
                    case 6:
                    case 9:
                        SqlDataReader dr = cmd.ExecuteReader();
                        if (dr.HasRows)
                        {
                            while (dr.Read())
                            {
                                obj = new Etb_Capacitacion();
                                obj.in_CapaID = dr.GetInt32(0);
                                obj.vc_Abreviatura = dr.GetString(1);
                                obj.vc_Titulo = dr.GetString(2);
                                if (ent.in_Opc == 4 || ent.in_Opc == 5)
                                {
                                    obj.vc_Campania = dr.GetString(3);
                                }
                                else
                                {
                                    obj.in_CampaniaID = dr.GetInt32(3); 
                                }
                                obj.dt_FechRegistro = dr.GetString(4);
                                obj.dt_FechInicio = dr.GetString(5);
                                obj.dt_FechFin = dr.GetString(6);
                                if (ent.in_Opc == 3)
                                {
                                    obj.in_TurnoID = dr.GetInt32(7);
                                }
                                else
                                {
                                    obj.vc_Turno = dr.GetString(7);
                                }
                                obj.vc_Nombres = dr.GetString(8);
                                obj.in_CantAgentes = dr.GetInt32(9);
                                obj.in_CantDias = dr.GetInt32(10);
                                obj.dc_PagoTotal = dr.GetDecimal(11);
                                obj.dc_PagoDia = dr.GetDecimal(12);
                                obj.in_CantPartes = dr.GetInt32(13);
                                obj.vc_Estado = dr.GetString(14);
                                obj.in_TotalRegistros = dr.GetInt32(15);
                                lista.Add(obj);
                            }
                        }
                        dr.Close();
                        break;
                    case 2:
                    case 8:
                        obj = new Etb_Capacitacion();
                        int res = (int)cmd.ExecuteNonQuery();
                        obj.in_Resul = res;
                        lista.Add(obj);
                        break;
                }
                cn.Close();
                return lista;
            }
        }

        public List<Etb_Capacitacion> D_DetalleCapacitacion(Etb_Capacitacion ent)
        {
            using (SqlConnection cn = new SqlConnection(cad))
            {
                List<Etb_Capacitacion> lista = new List<Etb_Capacitacion>();
                Etb_Capacitacion obj;

                SqlCommand cmd = new SqlCommand("usp_MantDetalleCapa", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 900000000;
                cmd.Parameters.AddWithValue("@in_Opc", 1);
                cmd.Parameters.AddWithValue("@in_CapaID", ent.in_CapaID);

                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        obj = new Etb_Capacitacion();
                        obj.in_Orden = dr.GetInt32(0);
                        obj.in_Cierre = dr.GetInt32(1);
                        obj.dc_Monto = dr.GetDecimal(2);
                        obj.in_Dia = dr.GetInt32(3);
                        lista.Add(obj);
                    }
                }
                dr.Close();                
                cn.Close();
                return lista;
            }
        }

        public List<Etb_Capacitacion> D_ListaDiaMaxPagoActual(Etb_Capacitacion ent)
        {
            using (SqlConnection cn = new SqlConnection(cad))
            {
                List<Etb_Capacitacion> lista = new List<Etb_Capacitacion>();
                Etb_Capacitacion obj;

                SqlCommand cmd = new SqlCommand("usp_MantCapacitacion", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 900000000;
                cmd.Parameters.AddWithValue("@in_Opc", 7);
                cmd.Parameters.AddWithValue("@in_CapaID", ent.in_CapaID);

                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        obj = new Etb_Capacitacion();
                        obj.in_Dia = dr.GetInt32(0);
                        obj.in_Orden = dr.GetInt32(1);
                        obj.dc_Monto = dr.GetDecimal(2);
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

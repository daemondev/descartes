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
    public class Dtb_Pagos
    {
        static string cad = ConfigurationManager.ConnectionStrings["dbConexion"].ConnectionString;

        public DataSet D_MantPagos(Etb_Pagos ent)
        {
            using (SqlConnection cn = new SqlConnection(cad))
            {
                SqlCommand cmd = new SqlCommand("usp_mantPagosValidaciones", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 900000000;
                cmd.Parameters.AddWithValue("@in_Opc", ent.in_Opc);
                cmd.Parameters.AddWithValue("@in_CapaID", ent.in_CapaID);
                cmd.Parameters.AddWithValue("@in_AgenteID", ent.in_AgenteID);
                cmd.Parameters.AddWithValue("@in_NroPago", ent.in_NroPago);
                cmd.Parameters.AddWithValue("@in_Validar", ent.in_Validar);
                try
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();
                    da.Fill(ds);
                    return ds;
                }
                catch (Exception)
                {
                    return null;
                    //throw;
                }
            }
        }

        public List<Etb_Pagos> D_MantPagoDetalle(Etb_Pagos ent)
        {
            using (SqlConnection cn = new SqlConnection(cad))
            {
                List<Etb_Pagos> lista = new List<Etb_Pagos>();
                Etb_Pagos obj;

                SqlCommand cmd = new SqlCommand("usp_mantPagosValidaciones", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 900000000;
                cmd.Parameters.AddWithValue("@in_Opc", ent.in_Opc);
                cmd.Parameters.AddWithValue("@in_CapaID", ent.in_CapaID);
                cmd.Parameters.AddWithValue("@in_AgenteID", ent.in_AgenteID);
                cmd.Parameters.AddWithValue("@in_NroPago", ent.in_NroPago);
                cmd.Parameters.AddWithValue("@in_Validar", ent.in_Validar);

                cn.Open();

                switch (ent.in_Opc)
                {
                    case 3:
                    case 8:
                        SqlDataReader dr = cmd.ExecuteReader();
                        if (dr.HasRows)
                        {
                            while (dr.Read())
                            {
                                obj = new Etb_Pagos();
                                obj.in_CantAsis = dr.GetInt32(0); //validar fecha de pago
                                obj.in_CantFalt = dr.GetInt32(1);
                                obj.dc_Monto = dr.GetDecimal(2);
                                obj.in_ValidCapa = dr.GetInt32(3);
                                obj.in_ValidDH = dr.GetInt32(4);
                                obj.in_ValidPM = dr.GetInt32(5);
                                obj.in_Pagado = dr.GetInt32(6);
                                lista.Add(obj);
                            }
                        }
                        dr.Close();
                        break;
                    case 4:
                    case 5:
                    case 6:
                    case 7:
                        obj = new Etb_Pagos();
                        int res = (int)cmd.ExecuteNonQuery();
                        obj.in_Resul = res;
                        lista.Add(obj);
                        break;
                }
                cn.Close();
                return lista;
            }
        }

        public List<Etb_Pagos> D_ListarCabeValidaciones(Etb_Pagos ent)
        {
            using (SqlConnection cn = new SqlConnection(cad))
            {
                List<Etb_Pagos> lista = new List<Etb_Pagos>();
                Etb_Pagos obj;

                SqlCommand cmd = new SqlCommand("usp_mantPagosValidaciones", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 900000000;
                cmd.Parameters.AddWithValue("@in_Opc", ent.in_Opc);
                cmd.Parameters.AddWithValue("@in_CapaID", ent.in_CapaID);
                cmd.Parameters.AddWithValue("@in_AgenteID", ent.in_AgenteID);
                cmd.Parameters.AddWithValue("@in_NroPago", ent.in_NroPago);
                cmd.Parameters.AddWithValue("@in_Validar", ent.in_Validar);

                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        obj = new Etb_Pagos();
                        obj.in_NroPago = dr.GetInt32(0);
                        obj.in_ValidCapa = dr.GetInt32(1);
                        obj.in_ValidDH = dr.GetInt32(2);
                        obj.in_ValidPM = dr.GetInt32(3);
                        lista.Add(obj);
                    }
                }
                cn.Close();
                return lista;
            }
        }
    }
}

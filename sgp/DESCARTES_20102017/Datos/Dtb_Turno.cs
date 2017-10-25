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
    public class Dtb_Turno
    {
        static string cad = ConfigurationManager.ConnectionStrings["dbConexion"].ConnectionString;

        public List<Etb_Turno> D_MantTurno(Etb_Turno ent)
        {
            using (SqlConnection cn = new SqlConnection(cad))
            {
                List<Etb_Turno> lista = new List<Etb_Turno>();
                Etb_Turno obj;

                SqlCommand cmd = new SqlCommand("usp_MantTurno", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 900000000;
                cmd.Parameters.AddWithValue("@in_Opc", ent.in_Opc);
                cmd.Parameters.AddWithValue("@in_UsuRegistroID", ent.in_UsuRegistroID);
                cmd.Parameters.AddWithValue("@in_TurnoID", ent.in_TurnoID);
                cmd.Parameters.AddWithValue("@in_SedeID", ent.in_SedeID);
                cmd.Parameters.AddWithValue("@vc_Simbolo", ent.vc_Simbolo);
                cmd.Parameters.AddWithValue("@vc_Descripcion", ent.vc_Descripcion);
                cmd.Parameters.AddWithValue("@hr_HoraInicio", ent.vc_HoraInicio);
                cmd.Parameters.AddWithValue("@hr_HoraFin", ent.vc_HoraFin);

                cn.Open();

                switch (ent.in_Opc)
                {
                    case 1:
                    case 2:
                    case 5:
                        SqlDataReader dr = cmd.ExecuteReader();
                        if (dr.HasRows)
                        {
                            while (dr.Read())
                            {
                                obj = new Etb_Turno();
                                obj.in_TurnoID = dr.GetInt32(0);
                                obj.vc_Simbolo = dr.GetString(1);
                                obj.vc_Descripcion = dr.GetString(2);
                                obj.vc_HoraInicio = dr.GetString(3);
                                obj.vc_HoraFin = dr.GetString(4);
                                if (ent.in_Opc == 2)
                                {
                                    obj.in_UsuRegistroID = dr.GetInt32(5);
                                }
                                else
                                {
                                    obj.vc_Nombres = dr.GetString(5);
                                }
                                obj.in_Estado = dr.GetInt32(6);
                                lista.Add(obj);
                            }
                        }
                        dr.Close();
                        break;
                    case 3:
                    case 4:
                        obj = new Etb_Turno();
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

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
    public class Dtb_CargaAgentes
    {
        static string cad = ConfigurationManager.ConnectionStrings["dbConexion"].ConnectionString;

        public List<Etb_CargaAgentes> D_MantCargaAgentes(Etb_CargaAgentes ent)
        {
            using (SqlConnection cn = new SqlConnection(cad))
            {
                List<Etb_CargaAgentes> lista = new List<Etb_CargaAgentes>();
                Etb_CargaAgentes obj;

                SqlCommand cmd = new SqlCommand("usp_MantAgentes", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 900000000;
                cmd.Parameters.AddWithValue("@in_Opc", ent.in_Opc);
                cmd.Parameters.AddWithValue("@in_CargaID", ent.in_CargaID);
                cmd.Parameters.AddWithValue("@in_CapaID", ent.in_CapaID);
                cmd.Parameters.AddWithValue("@in_UsuRegistroID", ent.in_UsuRegistroID);
                cmd.Parameters.AddWithValue("@in_CantAgentes", ent.in_CantAgentes);
                cmd.Parameters.AddWithValue("@in_AgenteID", ent.in_AgenteID);
                cmd.Parameters.AddWithValue("@vc_Usuario", ent.vc_Usuario);
                cmd.Parameters.AddWithValue("@vc_DNI", ent.vc_DNI);
                cmd.Parameters.AddWithValue("@vc_Nombre", ent.vc_Nombre);
                cmd.Parameters.AddWithValue("@vc_ApePaterno", ent.vc_ApePaterno);
                cmd.Parameters.AddWithValue("@vc_ApeMaterno", ent.vc_ApeMaterno);
                cmd.Parameters.AddWithValue("@in_Estado", ent.in_Estado);
                cmd.Parameters.AddWithValue("@vc_Observacion", ent.vc_Observacion);

                cn.Open();

                switch (ent.in_Opc)
                {
                    case 1:
                    case 2:
                        obj = new Etb_CargaAgentes();
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

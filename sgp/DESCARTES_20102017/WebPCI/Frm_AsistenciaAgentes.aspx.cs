using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Web.Services;
using Entidad;
using Negocio;
using System.Data;

public partial class Frm_AsistenciaAgentes : System.Web.UI.Page
{
    [WebMethod]
    public static List<Etb_Asistencias> VerDetalleAsistencias(int idCapa)
    {

        List<Etb_Asistencias> lis = new List<Etb_Asistencias>();
        Etb_Asistencias ent = new Etb_Asistencias();

        DataSet ds = new DataSet();
        DataTable dt = new DataTable();
        Ntb_Asistencias ng = new Ntb_Asistencias();
        ent.in_Opc = 1;
        ent.in_CapaID = idCapa;
        ent.in_UsuRegist = 0;
        ent.in_CantAsitentes = 0;
        ent.in_CantFaltantes = 0;
        ent.in_AgenteID = 0;
        ent.in_Asistencia = 0;
        ent.in_Condicion = 0;
        ds = ng.N_DetalleAsistencias(ent);
        //int columnas = 0;
        //int filas = 0;
        //columnas = dt.Columns.Count;
        //filas = dt.Rows.Count + 1;
        Etb_Asistencias ent2;
        ent2 = new Etb_Asistencias();
        string cadCabecera = "";
        for (int i = 0; i < ds.Tables[1].Columns.Count; i++)
        {
            cadCabecera += ds.Tables[1].Columns[i].ColumnName.ToString() + ";";
        }
        ent2.vc_ItemAsistencia = cadCabecera.Substring(0, cadCabecera.Length - 1);
        lis.Add(ent2);

        foreach (DataRow row in ds.Tables[0].Rows)
        {
            ent2 = new Etb_Asistencias();
            string cadDetalle = "";
            foreach (DataColumn colum in ds.Tables[0].Columns)
            {
                cadDetalle += row[colum].ToString() + ";";
            }
            ent2.vc_ItemAsistencia = cadDetalle.Substring(0, cadDetalle.Length - 1);
            lis.Add(ent2);
        }

        foreach (DataRow row in ds.Tables[1].Rows)
        {
            ent2 = new Etb_Asistencias();
            string cadDetalle = "";
            foreach (DataColumn colum in ds.Tables[1].Columns)
            {
                cadDetalle += row[colum].ToString() + ";";
            }
            ent2.vc_ItemAsistencia = cadDetalle.Substring(0, cadDetalle.Length - 1);
            lis.Add(ent2);
        }
        return lis;
    }

    [WebMethod]
    public static List<Etb_Asistencias> mantAsistencias(int in_Opc, int in_CapaID, int in_CantAsist, int in_CantFalt, int in_Agente,
        int in_Asitencia, int in_Condicion)
    {

        List<Etb_Asistencias> lis = new List<Etb_Asistencias>();
        Etb_Asistencias ent = new Etb_Asistencias();
        Ntb_Asistencias ng = new Ntb_Asistencias();
        Etb_Usuario entUsu = new Etb_Usuario();
        entUsu = (Etb_Usuario)HttpContext.Current.Session["sessUsuario"];
        ent.in_Opc = in_Opc;
        ent.in_CapaID = in_CapaID;
        ent.in_UsuRegist = entUsu.in_UsuarioID;
        ent.in_CantAsitentes = in_CantAsist;
        ent.in_CantFaltantes = in_CantFalt;
        ent.in_AgenteID = in_Agente;
        ent.in_Asistencia = in_Asitencia;
        ent.in_Condicion = in_Condicion;

        return lis = ng.N_MantAsistencias(ent);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        Entidad.Etb_Usuario Ent_usu = new Etb_Usuario();
        Ent_usu = (Entidad.Etb_Usuario)HttpContext.Current.Session["sessUsuario"];
        //Session.Timeout = 30;
    }

    //protected void Page_Init(object sender, EventArgs e)
    //{
    //    Page.Server.ScriptTimeout = 9000;
    //}
}
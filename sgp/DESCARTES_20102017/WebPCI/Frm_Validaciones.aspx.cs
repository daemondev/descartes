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

public partial class Frm_Validaciones : System.Web.UI.Page
{
    [WebMethod]
    public static List<Etb_Pagos> getCabeceraPagos(int inOpc, int idCapa, int inAgenteID, int inNroPago, int inValidar)
    {

        List<Etb_Pagos> lis = new List<Etb_Pagos>();
        Etb_Pagos ent = new Etb_Pagos();

        DataSet ds = new DataSet();
        DataTable dt = new DataTable();
        Ntb_Pagos ng = new Ntb_Pagos();
        ent.in_Opc = inOpc;
        ent.in_CapaID = idCapa;
        ent.in_AgenteID = inAgenteID;
        ent.in_NroPago = inNroPago;
        ent.in_Validar = inValidar;
        ds = ng.N_MantPagos(ent);
        if (ds != null)
        {
            int cantTablas = ds.Tables.Count;
            Etb_Pagos ent2;
            ent2 = new Etb_Pagos();
            string cadCabecera = "";
            for (int i = 0; i < ds.Tables[0].Columns.Count; i++)
            {
                cadCabecera += ds.Tables[0].Columns[i].ColumnName.ToString() + ";";
            }
            ent2.vc_Filas = cadCabecera.Substring(0, cadCabecera.Length - 1);
            lis.Add(ent2);
            for (int i = 0; i < cantTablas; i++)
            {
                foreach (DataRow row in ds.Tables[i].Rows)
                {
                    ent2 = new Etb_Pagos();
                    string cadDetalle = "";
                    foreach (DataColumn colum in ds.Tables[i].Columns)
                    {
                        cadDetalle += row[colum].ToString() + ";";
                    }
                    ent2.vc_Filas = cadDetalle.Substring(0, cadDetalle.Length - 1);
                    lis.Add(ent2);
                }
            }
        }        
        return lis;
    }

    [WebMethod]
    public static List<Etb_Pagos> getPagosDetalle(int inOpc, int idCapa, int inAgenteID, int inNroPago, int inValidar)
    {
        List<Etb_Pagos> lis = new List<Etb_Pagos>();
        Etb_Pagos ent = new Etb_Pagos();
        Ntb_Pagos ng = new Ntb_Pagos();
        ent.in_Opc = inOpc;
        ent.in_CapaID = idCapa;
        ent.in_AgenteID = inAgenteID;
        ent.in_NroPago = inNroPago;
        ent.in_Validar = inValidar;
        return lis = ng.N_MantPagoDetalle(ent);
    }

    [WebMethod]
    public static List<Etb_Pagos> getCabeValidaciones(int inOpc, int idCapa, int inAgenteID, int inNroPago, int inValidar)
    {
        List<Etb_Pagos> lis = new List<Etb_Pagos>();
        Etb_Pagos ent = new Etb_Pagos();
        Ntb_Pagos ng = new Ntb_Pagos();
        ent.in_Opc = inOpc;
        ent.in_CapaID = idCapa;
        ent.in_AgenteID = inAgenteID;
        ent.in_NroPago = inNroPago;
        ent.in_Validar = inValidar;
        return lis = ng.N_ListarCabeValidaciones(ent);
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
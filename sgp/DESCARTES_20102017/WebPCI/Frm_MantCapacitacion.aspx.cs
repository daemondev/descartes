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

public partial class Frm_MantCapacitacion : System.Web.UI.Page
{
    [WebMethod]
    public static List<Etb_Capacitacion> mantCapacitacion (int in_opc, int nroPagina, int tamPagina, int in_CapaID, string vc_Abreviatura, string vc_Titulo, int in_CampaniaID,
        string vc_FechaInicio, int in_CantAgentes, int in_CantDias, decimal PagoTotal, decimal PagoDia, int in_CantPartes, string vc_Cierre, string vc_Monto, string vc_Pago, int in_TurnoID)
    {
        List<Etb_Capacitacion> lst = new List<Etb_Capacitacion>();
        Ntb_Capacitacion neg = new Ntb_Capacitacion();
        Etb_Capacitacion ent = new Etb_Capacitacion();
        Etb_Usuario entUsu = new Etb_Usuario();
        entUsu = (Etb_Usuario)HttpContext.Current.Session["sessUsuario"];
        ent.in_Opc = in_opc;
        ent.in_NumPagina = nroPagina;
        ent.in_TamPagina = tamPagina;
        ent.in_CapaID = in_CapaID;
        ent.vc_Abreviatura = vc_Abreviatura;
        ent.vc_Titulo = vc_Titulo;
        ent.in_CampaniaID = in_CampaniaID;
        ent.dt_FechInicio = vc_FechaInicio;
        ent.in_UsuarioID = entUsu.in_UsuarioID;
        ent.in_CantAgentes = in_CantAgentes;
        ent.in_CantDias = in_CantDias;
        ent.dc_PagoTotal = PagoTotal;
        ent.dc_PagoDia = PagoDia;
        ent.in_CantPartes = in_CantPartes;
        ent.vc_Cierre = vc_Cierre;
        ent.vc_Monto = vc_Monto;
        ent.vc_Pago = vc_Pago;
        ent.in_TurnoID = in_TurnoID;
        return lst = neg.N_MantCapacitacion(ent);
    }

    [WebMethod]
    public static List<Etb_Capacitacion> VerDetalle(int id)
    {

        List<Etb_Capacitacion> lis = new List<Etb_Capacitacion>();
        Etb_Capacitacion ent = new Etb_Capacitacion();
        Ntb_Capacitacion ng = new Ntb_Capacitacion();
        ent.in_CapaID = Convert.ToInt32(id);
        return lis = ng.N_DetalleCapacitacion(ent);
    }

    [WebMethod]
    public static List<Etb_Capacitacion> getDiaMaxPagoActual(int idCapa)
    {

        List<Etb_Capacitacion> lis = new List<Etb_Capacitacion>();
        Etb_Capacitacion ent = new Etb_Capacitacion();
        Ntb_Capacitacion ng = new Ntb_Capacitacion();
        ent.in_CapaID = Convert.ToInt32(idCapa);
        return lis = ng.N_ListaDiaMaxPagoActual(ent);
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
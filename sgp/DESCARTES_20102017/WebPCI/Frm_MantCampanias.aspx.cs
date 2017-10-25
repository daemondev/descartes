using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Web.Services;
using Entidad;
using Negocio;

public partial class Frm_MantCampanias : System.Web.UI.Page
{
    [WebMethod]
    public static List<Etb_Campania> mantCampania(int in_opc, int in_CampaniaID, int in_SedeID, string vc_Campania, decimal dc_PagoDia)
    {
        List<Etb_Campania> lst = new List<Etb_Campania>();
        Ntb_Campania neg = new Ntb_Campania();
        Etb_Campania ent = new Etb_Campania();
        Etb_Usuario entUsu = new Etb_Usuario();
        entUsu = (Etb_Usuario)HttpContext.Current.Session["sessUsuario"];
        ent.in_Opc = in_opc;
        ent.in_CampaniaID = in_CampaniaID;
        ent.in_SedeID = in_SedeID;
        ent.in_UsuarioID = Convert.ToInt32(entUsu.in_UsuarioID);
        ent.vc_Campania = vc_Campania;
        ent.dc_PagoDia = dc_PagoDia;
        return lst = neg.N_MantCampania(ent);
    }

  [WebMethod]
    public static List<Etb_Campania> Asignacion(Etb_Campania objData)
    {
        List<Etb_Campania> lst = new List<Etb_Campania>();
        Ntb_Campania neg = new Ntb_Campania();
   
        Etb_Usuario entUsu = new Etb_Usuario();
        entUsu = (Etb_Usuario)HttpContext.Current.Session["sessUsuario"];

        objData.in_usuario_reg = Convert.ToInt32(entUsu.in_UsuarioID);

        return lst = neg.N_asignacion(objData);
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
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Web.Services;
using Entidad;
using Negocio;

public partial class Frm_MantSede : System.Web.UI.Page
{
    [WebMethod]
    public static List<Etb_Sede> mantSedes(int in_opc, int in_SedeID, string vc_Sede)
    {
        List<Etb_Sede> lst = new List<Etb_Sede>();
        Ntb_Sede neg = new Ntb_Sede();
        Etb_Sede ent = new Etb_Sede();
        Etb_Usuario entUsu = new Etb_Usuario();
        entUsu = (Etb_Usuario)HttpContext.Current.Session["sessUsuario"];
        ent.in_Opc = in_opc;
        ent.in_SedeID = in_SedeID;
        ent.in_UsuarioID = Convert.ToInt32(entUsu.in_UsuarioID);
        ent.vc_Sede = vc_Sede;
        return lst = neg.N_MantSede(ent);
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
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Web.Services;
using Entidad;
using Negocio;

public partial class Frm_Principal : System.Web.UI.Page
{
    [WebMethod]
    public static List<Etb_MenuPerfil> getMenuPerfil()
    {
        Etb_Usuario entUsuario = new Etb_Usuario();
        Etb_MenuPerfil entMenuPerfil = new Etb_MenuPerfil();
        List<Etb_MenuPerfil> lista = new List<Etb_MenuPerfil>();
        Ntb_MenuPerfil bl = new Ntb_MenuPerfil();
        entUsuario = (Etb_Usuario)HttpContext.Current.Session["sessUsuario"];
        entMenuPerfil.in_PerfilID = Convert.ToInt32(entUsuario.in_PerfilID);
        lista = bl.N_ListarMenuPerfil(entMenuPerfil);
        HttpContext.Current.Session["sMenuAccesos"] = lista;
        return lista;
    }

    [WebMethod]
    public static Int32 cerrarSession()
    {
        Etb_Usuario entUsuario = (Etb_Usuario)HttpContext.Current.Session["sessUsuario"];
        Ntb_Usuario bl = new Ntb_Usuario();
        bl.finalizaSesion(entUsuario);

        int resul = 1;
        HttpContext.Current.Session.Abandon();
        HttpContext.Current.Session.Clear();
        return resul;
    }

    [WebMethod]
    public static int[] mensajesNoLeidos()
    {
        Etb_Usuario entUsuario = (Etb_Usuario)HttpContext.Current.Session["sessUsuario"];
        Ntb_Usuario bl = new Ntb_Usuario();
        return bl.mensajesNoLeidos(entUsuario.in_UsuarioID);

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
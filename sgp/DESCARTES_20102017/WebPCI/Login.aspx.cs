using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

using System.Web.Services;
using Entidad;
using Negocio;

public partial class Login : System.Web.UI.Page
{
    [WebMethod]
    public static string LoginUsuario(string vc_Usuario, string vc_Clave)
    {
        List<Etb_Usuario> lista = new List<Etb_Usuario>();
        Etb_Usuario ent = new Etb_Usuario();
        Ntb_Usuario neg = new Ntb_Usuario();
        String resul = "";

        ent.in_Opc = 1;
        ent.in_NumPagina = 0;
        ent.in_TamPagina = 0;
        ent.in_UsuarioID = 0;
        ent.vc_DNI = "";
        ent.vc_Nombre = "";
        ent.vc_ApePaterno = "";
        ent.vc_ApeMaterno = "";
        ent.vc_Usuario = vc_Usuario;
        ent.vc_Clave = vc_Clave;
        ent.in_PerfilID = 0;
        ent.in_SedeID = 0;

        lista = neg.N_MantUsuario(ent);
        if (lista.Count > 0)
        { 
            HttpContext.Current.Session["sessUsuario"] = lista[0];
            HttpCookie ckUsuario = new HttpCookie("detUsuario");
            ckUsuario.Values["in_UsuarioID"] = Convert.ToString(lista[0].in_UsuarioID);
            ckUsuario.Values["vc_Nombre"] = Convert.ToString(lista[0].vc_Nombre);
            ckUsuario.Values["vc_Apellidos"] = Convert.ToString(lista[0].vc_ApePaterno);
            ckUsuario.Values["vc_Usuario"] = Convert.ToString(lista[0].vc_Usuario);
            ckUsuario.Values["in_PerfilID"] = Convert.ToString(lista[0].in_PerfilID);
            ckUsuario.Values["vc_Perfil"] = Convert.ToString(lista[0].vc_Perfil);
            ckUsuario.Expires = DateTime.Now.AddDays(1);
            HttpContext.Current.Response.Cookies.Add(ckUsuario);
            resul = Convert.ToString(lista[0].vc_Perfil);
        }
        return resul;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.ServerAndNoCache);
        Response.Cache.SetAllowResponseInBrowserHistory(false);
        Response.Cache.SetNoStore();
    }
}
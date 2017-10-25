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
using System.Configuration;
using System.IO;
using System.Text.RegularExpressions;

public partial class Frm_mensaje : System.Web.UI.Page
{
    [WebMethod]
    public static List<Etb_Mensaje> mostrarChat(int Emisor)
    {
        List<Etb_Mensaje> lst = new List<Etb_Mensaje>();
        Entidad.Etb_Usuario Ent_usu = new Etb_Usuario();
        Ent_usu = (Etb_Usuario)HttpContext.Current.Session["sessUsuario"];
        Ntb_Mensaje neg = new Ntb_Mensaje();

        return lst = neg.mostrarChat(Emisor, Ent_usu.in_UsuarioID);
    }

    [WebMethod]
    public static void EnviarMensaje(string msg, int receptor)
    {
        Entidad.Etb_Usuario Ent_usu = new Etb_Usuario();
        Ent_usu = (Etb_Usuario)HttpContext.Current.Session["sessUsuario"];
        Ntb_Mensaje neg = new Ntb_Mensaje();

        neg.EnviarMensaje(msg, Ent_usu.in_UsuarioID, receptor);
    }

	[WebMethod]
	public static List<Etb_Usuario> traerAdmins()
	{
		Ntb_Usuario neg = new Ntb_Usuario();
		return neg.traerAdmins();
	}

	protected void Page_Load(object sender, EventArgs e)
    {
        Entidad.Etb_Usuario Ent_usu = new Etb_Usuario();
        Ent_usu = (Entidad.Etb_Usuario)HttpContext.Current.Session["sessUsuario"];
    }
}
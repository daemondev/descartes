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

public partial class frm_personasConectadas : System.Web.UI.Page
{
    [WebMethod]
    public static List<Etb_Usuario> conectados(int in_opc, int nroPagina, int tamPagina, int in_UsuarioID, string vc_DNI, string vc_Nombre, string vc_ApePaterno,
        string vc_ApeMaterno, string vc_Usuario, string vc_Clave, int in_PerfilID, int in_SedeID, int in_CampaniaID)
    {
        List<Etb_Usuario> lst = new List<Etb_Usuario>();
        Ntb_Usuario neg = new Ntb_Usuario();
        Etb_Usuario ent = new Etb_Usuario();
        ent.in_Opc = in_opc;
        ent.in_NumPagina = nroPagina;
        ent.in_TamPagina = tamPagina;
        ent.in_UsuarioID = in_UsuarioID;
        ent.vc_DNI = vc_DNI;
        ent.vc_Nombre = vc_Nombre;
        ent.vc_ApePaterno = vc_ApePaterno;
        ent.vc_ApeMaterno = vc_ApeMaterno;
        ent.vc_Usuario = vc_Usuario;
        ent.in_CampaniaID = in_CampaniaID;
        ent.vc_Clave = vc_Clave;
        ent.in_PerfilID = in_PerfilID;
        ent.in_SedeID = in_SedeID;

        return lst = neg.N_MantUsuario(ent);
    }

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

        neg.EnviarMensaje(msg, Ent_usu.in_UsuarioID,receptor);
    }

    [WebMethod]
    public static void EliminarHistorial(int receptor)
    {
        Entidad.Etb_Usuario Ent_usu = new Etb_Usuario();
        Ent_usu = (Etb_Usuario)HttpContext.Current.Session["sessUsuario"];
        Ntb_Mensaje neg = new Ntb_Mensaje();

        neg.EliminarHistorial(Ent_usu.in_UsuarioID, receptor);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        Entidad.Etb_Usuario Ent_usu = new Etb_Usuario();
        Ent_usu = (Entidad.Etb_Usuario)HttpContext.Current.Session["sessUsuario"];
    }
}
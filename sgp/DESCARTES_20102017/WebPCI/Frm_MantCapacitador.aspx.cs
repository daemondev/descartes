using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Web.Services;
using Entidad;
using Negocio;

public partial class Frm_MantCapacitador : System.Web.UI.Page
{
    [WebMethod]
    public static List<Etb_Capacitador> mantCapacitador(int in_opc, int nroPagina, int tamPagina, int in_CapacitadorID, string vc_DNI, string vc_Nombre, string vc_ApePaterno,
        string vc_ApeMaterno, string vc_Usuario, string vc_Clave, string vc_Buscar, int in_SedeID, int in_CampaniaID)
    {
        List<Etb_Capacitador> lst = new List<Etb_Capacitador>();
        Ntb_Capacitador neg = new Ntb_Capacitador();
        Etb_Capacitador ent = new Etb_Capacitador();
        Etb_Usuario entUsu = new Etb_Usuario();
        entUsu = (Etb_Usuario)HttpContext.Current.Session["sessUsuario"];
        ent.in_Opc = in_opc;
        ent.in_NumPagina = nroPagina;
        ent.in_TamPagina = tamPagina;
        ent.in_UsuarioID = entUsu.in_UsuarioID;
        ent.in_CapacitadorID = in_CapacitadorID;
        ent.vc_DNI = vc_DNI;
        ent.vc_Nombre = vc_Nombre;
        ent.vc_ApePaterno = vc_ApePaterno;
        ent.vc_ApeMaterno = vc_ApeMaterno;
        ent.vc_Usuario = vc_Usuario;
        ent.vc_Clave = vc_Buscar;
        ent.in_SedeID = in_SedeID;
        ent.in_CampaniaID = in_CampaniaID;

        return lst = neg.N_MantCapacitador(ent);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        Entidad.Etb_Usuario Ent_usu = new Etb_Usuario();
        Ent_usu = (Entidad.Etb_Usuario)HttpContext.Current.Session["sessUsuario"];
    }
}
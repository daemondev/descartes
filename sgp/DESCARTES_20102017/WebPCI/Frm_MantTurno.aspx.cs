using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Web.Services;
using Entidad;
using Negocio;

public partial class Frm_MantTurno : System.Web.UI.Page
{
    [WebMethod]
    public static List<Etb_Turno> mantTurno(int in_opc, int in_TurnoID, int in_SedeID, string vc_Simbolo, string vc_Descripcion, string vc_HoraInicio, string vc_HoraFin)
    {
        List<Etb_Turno> lst = new List<Etb_Turno>();
        Ntb_Turno neg = new Ntb_Turno();
        Etb_Turno ent = new Etb_Turno();
        Etb_Usuario entUsu = new Etb_Usuario();
        entUsu = (Etb_Usuario)HttpContext.Current.Session["sessUsuario"];
        ent.in_Opc = in_opc;
        ent.in_UsuRegistroID = entUsu.in_UsuarioID;
        ent.in_TurnoID = in_TurnoID;
        ent.in_SedeID = in_SedeID;
        ent.vc_Simbolo = vc_Simbolo;
        ent.vc_Descripcion = vc_Descripcion;
        ent.vc_HoraInicio = vc_HoraInicio;
        ent.vc_HoraFin = vc_HoraFin;

        return lst = neg.N_MantTurno(ent);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        Entidad.Etb_Usuario Ent_usu = new Etb_Usuario();
        Ent_usu = (Entidad.Etb_Usuario)HttpContext.Current.Session["sessUsuario"];
    }
}
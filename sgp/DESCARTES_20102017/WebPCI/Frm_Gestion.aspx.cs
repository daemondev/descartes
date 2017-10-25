using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Negocio;
using Entidad;
using System.Web.Services;

public partial class Frm_Gestion : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
[WebMethod]
	public static List<Etb_Cliente> ConsultarHistorial(Etb_Cliente objData)
	{
        List<Etb_Cliente> lst = new List<Etb_Cliente>();
        Ntb_Gestion neg = new Ntb_Gestion();
		Etb_NIVEL ent = new Etb_NIVEL();
		Etb_Usuario entUsu = new Etb_Usuario();
	
        lst = neg.N_ConsultarHistorial(objData);

		return lst;
	}

	[WebMethod]
	public static List<Etb_NIVEL> ArmarPreview(Etb_NIVEL objData)
	{
		List<Etb_NIVEL> lst = new List<Etb_NIVEL>();
		Ntb_NIVEL neg = new Ntb_NIVEL();
		Etb_NIVEL ent = new Etb_NIVEL();
		Etb_Usuario entUsu = new Etb_Usuario();
		entUsu = (Etb_Usuario)HttpContext.Current.Session["sessUsuario"];
        if (objData.in_dpndncia_idnivel==0) {
            objData.in_UsuarioID = Convert.ToInt32(entUsu.in_UsuarioID);
        }
        
		lst = neg.N_ArmarPreview(objData);

		return lst;
	}

	/*[WebMethod]
	public static List<Etb_Cliente> ConsultarClie(Etb_Cliente objData)
	{
		List<Etb_Cliente> lst = new List<Etb_Cliente>();
		Ntb_Gestion neg = new Ntb_Gestion();
		Etb_Cliente ent = new Etb_Cliente();
		Etb_Usuario entUsu = new Etb_Usuario();
		entUsu = (Etb_Usuario)HttpContext.Current.Session["sessUsuario"];

		lst = neg.N_Gestion_listar(objData);

		return lst;
	}*/


	[WebMethod]
	public static List<Etb_Cliente> Gestion(Etb_Gestion objData)
	{
		List<Etb_Cliente> lst = new List<Etb_Cliente>();
		Ntb_Gestion neg = new Ntb_Gestion();
		Etb_Cliente ent = new Etb_Cliente();
		Etb_Usuario entUsu = new Etb_Usuario();
		entUsu = (Etb_Usuario)HttpContext.Current.Session["sessUsuario"];
		objData.in_usuario = entUsu.in_UsuarioID;
		lst = neg.N_Gestion_guardar(objData);

		return lst;
	}
}
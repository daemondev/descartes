using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Entidad;
using Negocio;
using System.Web.Services;

public partial class Frm_MantNivel : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

	[WebMethod]
	public static List<Etb_NIVEL> mantNivel(Etb_NIVEL objData)
	{
		List<Etb_NIVEL> lst = new List<Etb_NIVEL>();
		Ntb_NIVEL neg = new Ntb_NIVEL();
		Etb_NIVEL ent ;
		ent= new Etb_NIVEL();
		Etb_Usuario entUsu = new Etb_Usuario();
		entUsu = (Etb_Usuario)HttpContext.Current.Session["sessUsuario"];

		lst = neg.N_manNiveles(objData);

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

		lst = neg.N_ArmarPreview(objData);
		 
		return lst;
	}

	[WebMethod]
	public static List<Etb_NIVEL> traerProcesos(Etb_NIVEL objData)
	{
		List<Etb_NIVEL> lst = new List<Etb_NIVEL>();
		Ntb_NIVEL neg = new Ntb_NIVEL();
		lst = neg.traerProcesos(objData);

		return lst;
	}

    [WebMethod]
    public static List<Etb_NIVEL> traerSubProcesos(Etb_NIVEL objData)
    {
        List<Etb_NIVEL> lst = new List<Etb_NIVEL>();
        Ntb_NIVEL neg = new Ntb_NIVEL();
        lst = neg.traerSubProcesos(objData);

        return lst;
    }

    [WebMethod]
	public static List<Etb_NIVEL> traerMatrices()
	{
		List<Etb_NIVEL> lst = new List<Etb_NIVEL>();
		Ntb_NIVEL neg = new Ntb_NIVEL();
		lst = neg.traerMatrices();
		return lst;
	}

	[WebMethod]
	public static List<Etb_NIVEL> dameTitulo(Etb_NIVEL objData)
	{
		List<Etb_NIVEL> lst = new List<Etb_NIVEL>();
		Ntb_NIVEL neg = new Ntb_NIVEL();
		lst = neg.dameTitulo(objData);

		return lst;
	}

	[WebMethod]
	public static Int32 Guardar_Contenidos(Int32 in_idcontenido, Int32 in_idnivel, String vc_contexto, String vc_color, String vc_subrayado,Int32 op)
	{
		Entidad.Etb_NIVEL Ent = new Entidad.Etb_NIVEL();
		Ntb_NIVEL Neg = new Ntb_NIVEL();

		Int32 Resul = 0;
		if (in_idcontenido == 0)
		{
			//Registrar
			Ent.id_nivel = in_idnivel;
			Ent.vc_contexto = vc_contexto;
			Ent.vc_color = vc_color;
			Ent.vc_subrayado = vc_subrayado;
			Int32 R = Neg.Guardar_Contenidos(Ent, 1);
            //if (R > 0) { Resul = 1; } else { Resul = 0; }
            Resul = R;
		} else {
			//Actualizar
			Ent.in_idcontenido = in_idcontenido;
			Ent.vc_contexto = vc_contexto;
			Ent.vc_color = vc_color;
			Ent.vc_subrayado = vc_subrayado;
			Int32 R = Neg.Actualizar_Contenidos(Ent,4);
            //if (R > 0) { Resul = 1; } else { Resul = 0; }
            Resul = R;
        }

		return Resul;
	}

	[WebMethod]
	public static List<Etb_NIVEL> Lista_Contenidos(Int32 op, Int32 in_idnivel, Int32 tamPagina, Int32 nroPagina)
	{
		List<Etb_NIVEL> lst = new List<Etb_NIVEL>();
		Ntb_NIVEL neg = new Ntb_NIVEL();
		lst = neg.Lista_Contenidos(op, in_idnivel, tamPagina, nroPagina);
		return lst;
	}

	[WebMethod]
	public static List<Etb_NIVEL> Datos_Contenido(Int32 op, Int32 in_idcontenido)
	{
		List<Etb_NIVEL> lst = new List<Etb_NIVEL>();
		Ntb_NIVEL neg = new Ntb_NIVEL();
		lst = neg.Datos_Contenido(op, in_idcontenido);
		return lst;
	}

	[WebMethod]
	public static Int32 Estado_Contenidos(Int32 in_idcontenido)
	{
		Entidad.Etb_NIVEL Ent = new Entidad.Etb_NIVEL();
		Ntb_NIVEL Neg = new Ntb_NIVEL();

		Int32 Resul = 0;
		Int32 R = Neg.Estado_Contenidos(in_idcontenido, 5);
		if (R > 0) { Resul = 1; } else { Resul = 0; }
		return Resul;
	}

    [WebMethod]
    public static Int32 Eliminar_Contenidos(Int32 in_idcontenido) {
        if (R.set("delDeleteContent", in_idcontenido).Equals("successful")) {
            return 1;
        }
        return 0;
    }

    [WebMethod]
	public static List<Etb_NIVEL> Armar_Contenidos(Int32 op, Int32 in_idnivel)
	{
		List<Etb_NIVEL> lst = new List<Etb_NIVEL>();
		Ntb_NIVEL neg = new Ntb_NIVEL();
		lst = neg.Armar_Contenidos(op, in_idnivel);
		return lst;
	}

    [WebMethod]
    public static string getContentOfNivel(int opc, int idNivel) {
        Dictionary<string, object> data = new Dictionary<string, object>() {
            {"in_opc",opc },
            { "in_idnivel", idNivel}
        };
        return R.getJSON("usp_mantContenido_Nivel", data);
    }

}
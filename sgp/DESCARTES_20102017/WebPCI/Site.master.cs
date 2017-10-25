using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Site : System.Web.UI.MasterPage
{
    Entidad.Etb_Usuario Ent_Usu;
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetNoStore();
        //Page.Header.DataBind();
        if (Session["sessUsuario"] != null)
        {
            if (Request.Cookies["detUsuario"] != null)
            {
                Ent_Usu = new Entidad.Etb_Usuario();
                //Recoger los Dato del Cookis - Session
                HttpCookie usu_Cookie = Request.Cookies["detUsuario"];
                Ent_Usu.in_UsuarioID = Convert.ToInt32(usu_Cookie["in_UsuarioID"]);
                Ent_Usu.in_PerfilID = Convert.ToInt32(usu_Cookie["in_PerfilID"]);
                Ent_Usu.vc_Nombre = usu_Cookie["vc_Nombre"];
                Ent_Usu.vc_ApeMaterno = usu_Cookie["vc_Apellidos"];
                Ent_Usu.vc_Usuario = usu_Cookie["vc_Usuario"];
                Ent_Usu.vc_Perfil = usu_Cookie["vc_Perfil"];
                Session["User_PP"] = Ent_Usu;
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }
        else
        {
            Response.Redirect("Login.aspx");
        }


        if (!Page.IsPostBack)
        {
            this.lblPersonal.Text = Ent_Usu.vc_Nombre + ", " + Ent_Usu.vc_ApeMaterno;
            this.lbl_linea.Text = Ent_Usu.vc_Nombre + ", " + Ent_Usu.vc_ApeMaterno;
            //this.lblUser.Text = Ent_Usu.vc_Usuario;
            this.lblPerfil.Text = Ent_Usu.vc_Perfil;
            this.lblFecha.Text = DateTime.Now.ToString("dd/MM/yyyy");
        }
    }
}

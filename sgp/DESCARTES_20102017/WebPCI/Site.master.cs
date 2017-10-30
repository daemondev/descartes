using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Entidad;
public partial class Site : System.Web.UI.MasterPage
{
    Entidad.Etb_Usuario Ent_Usu;

    bool debug = true;    

    void debugAction() {

        Ent_Usu = new Etb_Usuario();
        
        Ent_Usu.in_Opc = 1;
        Ent_Usu.vc_Usuario = "admin";
        Ent_Usu.vc_Clave = "123456";
        Ent_Usu = R.getObject<Etb_Usuario>("sp_Mant_Usuario", Ent_Usu);

        HttpContext.Current.Session["sessUsuario"] = Ent_Usu;        
        
        HttpCookie ckUsuario = new HttpCookie("detUsuario");        

        ckUsuario.Values["in_UsuarioID"] = Convert.ToString(Ent_Usu.in_UsuarioID);
        ckUsuario.Values["vc_Nombre"] = Convert.ToString(Ent_Usu.vc_Nombre);
        ckUsuario.Values["vc_Apellidos"] = Convert.ToString(Ent_Usu.vc_ApePaterno);
        ckUsuario.Values["vc_Usuario"] = Convert.ToString(Ent_Usu.vc_Usuario);
        ckUsuario.Values["in_PerfilID"] = Convert.ToString(Ent_Usu.in_PerfilID);
        ckUsuario.Values["vc_Perfil"] = Convert.ToString(Ent_Usu.vc_Perfil);
     

        
        ckUsuario.Expires = DateTime.Now.AddDays(1);
        HttpContext.Current.Response.Cookies.Add(ckUsuario);
        Session["ready"] = true;
        
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetNoStore();
        //Page.Header.DataBind();

        //if (debug){
        if (debug && Session["ready"] == null) {
                debugAction();
        }
        

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

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

    static T getObject<T>() where T: new (){

        T ins = new T();
        //T ins = (T)Convert.ChangeType(default(T), typeof(T));
        var obj = X.R.get("sp_Mant_Usuario", 1, 0, 0, 0, "", "", "", "", "admin", "123456", "", 0, 0, 0).Rows[0];
        List<string> columns = obj.Table.Columns.Cast<System.Data.DataColumn>().Select(x => x.ColumnName).ToList();
        foreach (var prop in typeof(T).GetProperties()) {
            if (columns.Contains(prop.Name)) {
                prop.SetValue(ins, obj[prop.Name], null);
            }
        }
        //return (T)Convert.ChangeType("Etb_Usuario", typeof(T));
        return (T)Convert.ChangeType(ins, typeof(T));
    }

    public T GetAnything<T>(Func<T> createInstanceOfT) {
        //do whatever
        //Computer comp = GetAnything(() => new Computer());
        return createInstanceOfT();
    }
    

    void debugAction() {

        Ent_Usu = new Entidad.Etb_Usuario();
        Etb_Usuario u = getObject<Etb_Usuario>();

        var obj = X.R.get("sp_Mant_Usuario", 1, 0, 0, 0, "", "", "", "", "admin", "123456", "", 0, 0, 0).Rows[0];
        
        //Ent_Usu.GetType().GetProperties().ToList().ForEach(p => Console.Write(p.));

        List<string> columns = obj.Table.Columns.Cast<System.Data.DataColumn>().Select(x => x.ColumnName).ToList();
        HttpCookie ckUsuario = new HttpCookie("detUsuario");

        foreach (var item in Ent_Usu.GetType().GetProperties()){
            if (columns.Contains(item.Name)) { 
                item.SetValue(Ent_Usu, obj[item.Name], null);
                ckUsuario.Values[item.Name] = obj[item.Name].ToString();
            }
        }
        //https://stackoverflow.com/questions/731452/create-instance-of-generic-type
        //Activator.CreateInstance
        //return (T)Activator.CreateInstance(typeof(T), new object[] { weight });
        //https://codeblog.jonskeet.uk/2008/08/29/lessons-learned-from-protocol-buffers-part-4-static-interfaces/

        HttpContext.Current.Session["sessUsuario"] = Ent_Usu;        
        ckUsuario.Expires = DateTime.Now.AddDays(1);
        HttpContext.Current.Response.Cookies.Add(ckUsuario);
        Session["ready"] = true;
        
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetNoStore();
        //Page.Header.DataBind();

        if (debug &&  Session["ready"] == null){
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

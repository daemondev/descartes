using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Web.Services;
using Entidad;
using Negocio;

using System.Web.Services;
using Entidad;
using Negocio;
using System.Data;
using System.Configuration;
using System.IO;
using System.Text.RegularExpressions;

public partial class Frm_Usuarios : System.Web.UI.Page
{
    [WebMethod]
    public static List<Etb_Usuario> mantUsuarios(int in_opc, int nroPagina, int tamPagina, int in_UsuarioID, string vc_DNI, string vc_Nombre, string vc_ApePaterno,
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
        if (vc_Clave != "")
        {
            Etb_Usuario entUsu = new Etb_Usuario();
            entUsu = (Etb_Usuario)HttpContext.Current.Session["sessUsuario"];
            ent.in_UsuarioID = entUsu.in_UsuarioID;
        }
        ent.vc_Clave = vc_Clave;
        //ent.vc_Correo = vc_Correo;
        ent.in_PerfilID = in_PerfilID;
        ent.in_SedeID = in_SedeID;

        return lst = neg.N_MantUsuario(ent);
    }



    [WebMethod]
    public static List<Etb_combos> ListarCombo(Etb_combos Etb)
    {
        List<Etb_combos> lst = new List<Etb_combos>();
        Ntb_Usuario neg = new Ntb_Usuario();
        return lst = neg.N_cargarCombos(Etb);
    }

    [WebMethod]
    public static List<Etb_Perfil> mantPerfil()
    {
        List<Etb_Perfil> lst = new List<Etb_Perfil>();
        Ntb_Perfil neg = new Ntb_Perfil();
        return lst = neg.N_MantPerfil();
    }

    [WebMethod]
    public static List<Etb_Campania> mantCampania(int in_Opc, int in_SedeID)
    {
        List<Etb_Campania> lst = new List<Etb_Campania>();
        Ntb_Campania neg = new Ntb_Campania();
        Etb_Campania ent = new Etb_Campania();
        Etb_Usuario entUsu = new Etb_Usuario();
        ent.in_Opc = in_Opc;
        ent.in_SedeID = in_SedeID;
        return lst = neg.N_MantCampania(ent);
    }


    [WebMethod]
    public static List<Etb_Cliente> setCargaAsFile(string vc_archivo, int in_SedeID, int in_CampaniaID, int in_PerfilID)
    {
        Etb_Usuario Ent = new Etb_Usuario();
        Etb_Cliente ent_res = new Etb_Cliente();
        Etb_Usuario entUsu = new Etb_Usuario();
        entUsu = (Etb_Usuario)HttpContext.Current.Session["sessUsuario"];
        Ntb_Usuario Neg = new Ntb_Usuario();
        List<Etb_Usuario> Lista = new List<Etb_Usuario>();
        List<Etb_Cliente> LisResul = new List<Etb_Cliente>();
        int res = 0;
        try
        {
            //Cantidad de datos
            String ruta_archivo = ConfigurationManager.AppSettings["Ubicacion"];
            String ruta = System.Web.HttpContext.Current.Server.MapPath(ruta_archivo) + "\\" + vc_archivo;

            StreamReader Leer_archivo = new StreamReader(ruta, System.Text.Encoding.Default);
            String[] Columna;
            String readfila = Leer_archivo.ReadToEnd();
            Columna = Regex.Split(readfila, System.Environment.NewLine);

            int filas = 0;
            for (Int32 i = 1; i <= Columna.Length - 2; i++)
            {
                String[] Rows;
                Rows = Regex.Split(Columna[i], "\\t");
                if (Convert.ToString(Rows[0]) != "")
                {
                    filas++;
                }
            }

            for (Int32 i = 1; i <= filas; i++)
            {
                String[] Rows;
                Rows = Regex.Split(Columna[i], "\\t");
                Ent = new Etb_Usuario();
                Ent.in_Opc = 4;
                Ent.vc_DNI = Convert.ToString(Rows[0]);
                Ent.vc_Nombre = Convert.ToString(Rows[1]);
                Ent.vc_ApePaterno = Convert.ToString(Rows[2]);
                Ent.vc_ApeMaterno = Convert.ToString(Rows[3]);
                Ent.vc_Usuario = Convert.ToString(Rows[4]);
                Ent.in_SedeID = in_SedeID;
                Ent.in_CampaniaID = in_CampaniaID;
                Ent.in_PerfilID = in_PerfilID;               
                // Ent.in_CapaID = idCapacitacion;
             
                //Almacenar en una Lista
                Lista.Add(Ent);
            }
            //Ent = new Etb_Cliente();
            //Ent.vc_nombre = entUsu.vc_nombre;
            //Ent.vc_codigo = entUsu.vc_codigo;
            //Ent.in_archivo = entUsu.in_archivo;

            //Cargar Datos

            res = Neg.N_MantCargaUsuarios(Ent, Lista);
            ent_res = new Etb_Cliente();
            ent_res.in_Resul = res;
            LisResul.Add(ent_res);
        }
        catch (Exception ex)
        {
        //    Ent = new Etb_Usuario();
        //    Ent.in_Resul = 0;
        //    LisResul.Add(Ent);
        }
        return LisResul;
    }

    [WebMethod]
    public static List<Etb_Cliente> setCargaAgente(int indice, int id_cliente, string vc_nombre, string vc_codigo, string vc_apellidos)
    {
        Etb_Cliente Ent = new Etb_Cliente();
        Etb_Usuario entUsu = new Etb_Usuario();
        entUsu = (Etb_Usuario)HttpContext.Current.Session["sessUsuario"];
        Ntb_CargaAgentes Neg = new Ntb_CargaAgentes();
        List<Etb_Cliente> Lista = new List<Etb_Cliente>();
        List<Etb_Cliente> LisResul = new List<Etb_Cliente>();
        int res = 0;
        try
        {
            Ent = new Etb_Cliente();
            Ent.indice = indice;
            Ent.id_cliente = id_cliente;
            Ent.vc_nombre = vc_nombre;
            Ent.vc_codigo = vc_codigo;
            Ent.vc_apellidos = vc_apellidos;

            //Almacenar en una Lista
            Lista.Add(Ent);

            Ent = new Etb_Cliente();
            Ent.indice = indice;
            Ent.id_cliente = id_cliente;
            Ent.vc_nombre = vc_nombre;
            Ent.vc_codigo = vc_codigo;
            Ent.vc_apellidos = vc_apellidos;

            //Cargar Datos
            res = Neg.N_MantCargaCliente(Ent, Lista);
            Ent = new Etb_Cliente();
            Ent.in_Resul = res;
            LisResul.Add(Ent);
        }
        catch (Exception ex)
        {
            Ent = new Etb_Cliente();
            Ent.in_Resul = 0;
            LisResul.Add(Ent);
        }
        return LisResul;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        Entidad.Etb_Usuario Ent_usu = new Etb_Usuario();
        Ent_usu = (Entidad.Etb_Usuario)HttpContext.Current.Session["sessUsuario"];
        //Session.Timeout = 30;
    }

    //protected void Page_Init(object sender, EventArgs e)
    //{
    //    Page.Server.ScriptTimeout = 9000;
    //}
}
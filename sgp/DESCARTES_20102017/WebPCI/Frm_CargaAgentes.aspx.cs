﻿using System;
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

public partial class Frm_CargaAgentes : System.Web.UI.Page
{
	
	[WebMethod]
	public static List<Etb_Cliente> mantClie(int indice,int pagenum, int pagesize)
	{
		List<Etb_Cliente> lst = new List<Etb_Cliente>();
		Ntb_CargaAgentes neg = new Ntb_CargaAgentes();
		Etb_Usuario entUsu = new Etb_Usuario();
		Etb_Cliente ent = new Etb_Cliente();
		//entUsu = (Etb_Usuario)HttpContext.Current.Session["sessUsuario"];
		ent.indice = indice;
		ent.pagenum = pagenum;
		ent.pagesize = pagesize;


		return lst = neg.N_LstCliente(ent);
	}
	[WebMethod]
	public static int ModEstadoClie(int indice,int id_cliente, int in_estado )
	{
		int result = 0;
		Ntb_CargaAgentes neg = new Ntb_CargaAgentes();
		Etb_Usuario entUsu = new Etb_Usuario();
		Etb_Cliente ent = new Etb_Cliente();
		//entUsu = (Etb_Usuario)HttpContext.Current.Session["sessUsuario"];
		ent.indice = indice;
		ent.id_cliente = id_cliente;
		ent.in_estado= in_estado;
	
		return result = neg.N_ModEstadoClientes(ent);
	}
		[WebMethod]
	public static int DeleteClie(int indice, int id_cliente)
	{
		int result = 0;
		Ntb_CargaAgentes neg = new Ntb_CargaAgentes();
		Etb_Usuario entUsu = new Etb_Usuario();
		Etb_Cliente ent = new Etb_Cliente();
		//entUsu = (Etb_Usuario)HttpContext.Current.Session["sessUsuario"];
		ent.indice = indice;
		ent.id_cliente = id_cliente;
	

		return result = neg.N_DeleteClientes(ent);
	}
	[WebMethod]
	public static List<Etb_Cliente> setCargaAgenteFile(string vc_archivo)
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
				Ent = new Etb_Cliente();
				Ent.indice = 1;
                Ent.vc_nombre = Convert.ToString(Rows[0]);
				Ent.vc_apellidos = Convert.ToString(Rows[1]);
                Ent.vc_codigo= Convert.ToString(Rows[2]);
				
                // Ent.in_CapaID = idCapacitacion;
                Ent.in_archivo = 0;   
                //Almacenar en una Lista
                Lista.Add(Ent);
            }

			//Ent = new Etb_Cliente();
			//Ent.vc_nombre = entUsu.vc_nombre;
			//Ent.vc_codigo = entUsu.vc_codigo;
			//Ent.in_archivo = entUsu.in_archivo;

            //Cargar Datos
			
			res = Neg.N_MantCargaCliente(Ent, Lista);
			Ent = new Etb_Cliente();
			Ent.in_Resul = res;
			LisResul.Add(Ent);
        }
        catch (Exception ex) {
			Ent = new Etb_Cliente();
            Ent.in_Resul = 0;
            LisResul.Add(Ent);
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
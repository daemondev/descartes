using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Entidad;
using Datos;


namespace Negocio
{
    public class Ntb_CargaAgentes
    {
        Dtb_CargarClientes objDatos;
		//public List<Etb_CargaAgentes> N_MantCargaAgente(Etb_CargaAgentes ent, List<Etb_CargaAgentes> listAgentes)
		//{
		//	List<Etb_CargaAgentes> lis = new List<Etb_CargaAgentes>();
		//	objDatos = new Dtb_CargaAgentes();
		//	lis = objDatos.D_MantCargaAgentes(ent);

		//	foreach (Etb_CargaAgentes item in listAgentes)
		//	{
		//		lis = objDatos.D_MantCargaAgentes(item);
		//	}
		//	return lis;
		//}
		public int N_MantCargaCliente(Etb_Cliente ent, List<Etb_Cliente> listClie)
        {
			List<Etb_Cliente> lis = new List<Etb_Cliente>();
            objDatos = new Dtb_CargarClientes();
			//lis = objDatos.D_MantCargaClientes(ent);
			int result = 0;
			foreach (Etb_Cliente item in listClie)
            {
				result += objDatos.D_MantCargaClientes(item);
				
            }
            return result;
        }



		public int N_ModEstadoClientes(Etb_Cliente ent)
        {
			List<Etb_Cliente> lis = new List<Etb_Cliente>();
            objDatos = new Dtb_CargarClientes();
			//lis = objDatos.D_MantCargaClientes(ent);
			int result = 0;
			result = objDatos.D_ModEstadoClientes(ent);            
            return result;
        }

		public int N_DeleteClientes(Etb_Cliente ent)
        {
			List<Etb_Cliente> lis = new List<Etb_Cliente>();
            objDatos = new Dtb_CargarClientes();
			//lis = objDatos.D_MantCargaClientes(ent);
			int result = 0;		
				result = objDatos.D_DeleteClientes(ent);            
            return result;
        }

		public List<Etb_Cliente> N_LstCliente(Etb_Cliente ent)
		{
			List<Etb_Cliente> lis = new List<Etb_Cliente>();
			objDatos = new Dtb_CargarClientes();
			//lis = objDatos.D_MantCargaClientes(ent);

			lis = objDatos.D_ListarClientes(ent);
		
			return lis;
		}
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Entidad;
using Datos;

namespace Negocio
{
    public class Ntb_Usuario
    {
        Dtb_Usuario objDatos;

        public void finalizaSesion (Etb_Usuario usu)
        {
            objDatos = new Dtb_Usuario();
            objDatos.finalizaSesion(usu);
        }

        public int[] mensajesNoLeidos(int id)
        {
            objDatos = new Dtb_Usuario();
            return objDatos.mensajesNoLeidos(id);
        }

        public List<Etb_Usuario> N_MantUsuario(Etb_Usuario ent)
        {
            objDatos = new Dtb_Usuario();
            return objDatos.D_MantUsuario(ent);
        }
		public List<Etb_Usuario> traerAdmins()
		{
			objDatos = new Dtb_Usuario();
			return objDatos.traerAdmins();
		}
		public List<Etb_combos> N_cargarCombos(Etb_combos ent)
        {
            objDatos = new Dtb_Usuario();
            return objDatos.D_cargarCombos(ent);
        }

        public int N_MantCargaUsuarios(Etb_Usuario ent, List<Etb_Usuario> listUsu)
        {
            List<Etb_Usuario> lis = new List<Etb_Usuario>();
            objDatos = new Dtb_Usuario();
            //lis = objDatos.D_MantCargaClientes(ent);
            int result = 0;
            foreach (Etb_Usuario item in listUsu)
            {
                result += objDatos.D_MantUsuarioCarga(item);

            }
            return result;
        }
    }
}

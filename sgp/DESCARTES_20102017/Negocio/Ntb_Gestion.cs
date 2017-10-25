using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Datos;
using Entidad;

namespace Negocio
{
    public	class Ntb_Gestion
	{
		//D_Gestion
		Dtb_Gestion objDatos;
		/*public List<Etb_Cliente> N_Gestion_listar(Etb_Cliente objNivel)
		{
			objDatos = new Dtb_Gestion();
			return objDatos.D_Gestion(objNivel);
		}*/
	
		public List<Etb_Cliente> N_Gestion_guardar(Etb_Gestion objNivel)
		{
			objDatos = new Dtb_Gestion();
			return objDatos.D_Gestion_guardar(objNivel);
		}
        public List<Etb_Cliente> N_ConsultarHistorial(Etb_Cliente objNivel)
		{
			objDatos = new Dtb_Gestion();
            return objDatos.D_ConsultarHistorial(objNivel);
		}

	}
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Datos;
using Entidad;

namespace Negocio
{
	public class Ntb_NIVEL
	{
		Dtb_NIVEL objDatos;
		public List<Etb_NIVEL> N_manNiveles(Etb_NIVEL objNivel)
		{
			objDatos = new Dtb_NIVEL();
			return objDatos.D_manNivel(objNivel);
		}

		public List<Etb_NIVEL> N_ArmarPreview(Etb_NIVEL objNivel)
		{
			objDatos = new Dtb_NIVEL();
			return objDatos.Da_ArmarPreview(objNivel);
		}

		public List<Etb_NIVEL> traerMatrices()
		{
			objDatos = new Dtb_NIVEL();
			return objDatos.traerMatrices();
		}
		public List<Etb_NIVEL> traerProcesos(Etb_NIVEL objNivel)
		{
			objDatos = new Dtb_NIVEL();
			return objDatos.traerProcesos(objNivel);
		}

        public List<Etb_NIVEL> traerSubProcesos(Etb_NIVEL objNivel)
        {
            objDatos = new Dtb_NIVEL();
            return objDatos.traerSubProcesos(objNivel);
        }

        public List<Etb_NIVEL> dameTitulo(Etb_NIVEL objNivel)
		{
			objDatos = new Dtb_NIVEL();
			return objDatos.dameTitulo(objNivel);
		}

		public Int32 Guardar_Contenidos(Etb_NIVEL objNivel,Int32 op) {
			objDatos = new Dtb_NIVEL();
			return objDatos.Guardar_Contenidos(objNivel, op);
		}

		public Int32 Actualizar_Contenidos(Etb_NIVEL objNivel, Int32 op)
		{
			objDatos = new Dtb_NIVEL();
			return objDatos.Actualizar_Contenidos(objNivel, op);
		}

		public Int32 Estado_Contenidos(Int32 in_idcontenido, Int32 op)
		{
			objDatos = new Dtb_NIVEL();
			return objDatos.Estado_Contenidos(in_idcontenido, op);
		}

		public List<Etb_NIVEL> Lista_Contenidos(Int32 op, Int32 in_idnivel, Int32 tamPagina, Int32 nroPagina)
		{
			objDatos = new Dtb_NIVEL();
			return objDatos.Lista_Contenidos(op, in_idnivel, tamPagina, nroPagina);
		}

		public List<Etb_NIVEL> Datos_Contenido(Int32 op, Int32 in_idcontenido)
		{
			objDatos = new Dtb_NIVEL();
			return objDatos.Lista_Contenidos(op, in_idcontenido);
		}

		public List<Etb_NIVEL> Armar_Contenidos(Int32 op, Int32 in_idnivel)
		{
			objDatos = new Dtb_NIVEL();
			return objDatos.Armar_Contenidos(op, in_idnivel);
		}

	}
}

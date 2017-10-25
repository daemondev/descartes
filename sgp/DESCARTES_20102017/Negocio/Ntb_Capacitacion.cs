using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Entidad;
using Datos;
using System.Data;

namespace Negocio
{
    public class Ntb_Capacitacion
    {
        Dtb_Capacitacion objDatos;
        public List<Etb_Capacitacion> N_MantCapacitacion(Etb_Capacitacion ent)
        {
            objDatos = new Dtb_Capacitacion();
            return objDatos.D_MantCapacitacion(ent);
        }

        public List<Etb_Capacitacion> N_DetalleCapacitacion(Etb_Capacitacion ent)
        {
            objDatos = new Dtb_Capacitacion();
            return objDatos.D_DetalleCapacitacion(ent);
        }

        public List<Etb_Capacitacion> N_ListaDiaMaxPagoActual(Etb_Capacitacion ent)
        {
            objDatos = new Dtb_Capacitacion();
            return objDatos.D_ListaDiaMaxPagoActual(ent);
        }
    }
}

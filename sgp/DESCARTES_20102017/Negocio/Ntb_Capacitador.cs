using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Entidad;
using Datos;

namespace Negocio
{
    public class Ntb_Capacitador
    {
        Dtb_Capacitador objDatos;
        public List<Etb_Capacitador> N_MantCapacitador(Etb_Capacitador ent)
        {
            objDatos = new Dtb_Capacitador();
            return objDatos.D_MantCapacitador(ent);
        }
    }
}

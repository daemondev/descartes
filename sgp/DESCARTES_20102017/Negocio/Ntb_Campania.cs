using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Entidad;
using Datos;

namespace Negocio
{
    public class Ntb_Campania
    {
        Dtb_Campania objCamp;
        public List<Etb_Campania> N_MantCampania(Etb_Campania ent)
        {
            objCamp = new Dtb_Campania();
            return objCamp.D_MantCampania(ent);
        }

        public List<Etb_Campania> N_asignacion(Etb_Campania ent)
        {
            objCamp = new Dtb_Campania();
            return objCamp.D_asignacion(ent);
        }
    }
}

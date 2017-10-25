using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Entidad;
using Datos;

namespace Negocio
{
    public class Ntb_Sede
    {
        Dtb_Sede objSede;
        public List<Etb_Sede> N_MantSede(Etb_Sede ent)
        {
            objSede = new Dtb_Sede();
            return objSede.D_MantSede(ent);
        }
    }
}

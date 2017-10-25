using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Entidad;
using Datos;

namespace Negocio
{
    public class Ntb_Turno
    {
        Dtb_Turno objDatos;
        public List<Etb_Turno> N_MantTurno(Etb_Turno ent)
        {
            objDatos = new Dtb_Turno();
            return objDatos.D_MantTurno(ent);
        }
    }
}

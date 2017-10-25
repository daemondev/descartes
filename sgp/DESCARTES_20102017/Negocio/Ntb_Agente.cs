using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Entidad;
using Datos;

namespace Negocio
{
    public class Ntb_Agente
    {
        Dtb_Agente objAgente;
        public List<Etb_CargaAgentes> N_MantAgente(Etb_CargaAgentes ent)
        {
            objAgente = new Dtb_Agente();
            return objAgente.D_MantAgente(ent);
        }
    }
}

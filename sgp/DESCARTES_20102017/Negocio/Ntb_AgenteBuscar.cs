using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Entidad;
using Datos;
using System.Data;

namespace Negocio
{
    public class Ntb_AgenteBuscar
    {
        Dtb_AgenteBuscar obj;
        public List<Etb_AgenteBuscar> N_AgenteBuscar(Etb_AgenteBuscar ent)
        {
            obj = new Dtb_AgenteBuscar();
            return obj.D_AgenteBuscar(ent);
        }

        public DataSet N_AgenteBuscarDetalle(Etb_AgenteBuscar ent)
        {
            obj = new Dtb_AgenteBuscar();
            return obj.D_AgenteBuscarDetalle(ent);
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Entidad;
using Datos;
using System.Data;

namespace Negocio
{
    public class Ntb_Pagos
    {
        Dtb_Pagos objDatos;
        public DataSet N_MantPagos(Etb_Pagos ent)
        {
            objDatos = new Dtb_Pagos();
            return objDatos.D_MantPagos(ent);
        }

        public List<Etb_Pagos> N_MantPagoDetalle(Etb_Pagos ent)
        {
            objDatos = new Dtb_Pagos();
            return objDatos.D_MantPagoDetalle(ent);
        }

        public List<Etb_Pagos> N_ListarCabeValidaciones(Etb_Pagos ent)
        {
            objDatos = new Dtb_Pagos();
            return objDatos.D_ListarCabeValidaciones(ent);
        }
    }
}

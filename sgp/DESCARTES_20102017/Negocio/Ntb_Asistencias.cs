using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Entidad;
using Datos;
using System.Data;

namespace Negocio
{
    public class Ntb_Asistencias
    {
        Dtb_Asistencias objDatos;
        public DataSet N_DetalleAsistencias(Etb_Asistencias ent)
        {
            objDatos = new Dtb_Asistencias();
            return objDatos.D_DetalleAsistencias(ent);
        }

        public List<Etb_Asistencias> N_MantAsistencias(Etb_Asistencias ent)
        {
            objDatos = new Dtb_Asistencias();
            return objDatos.D_MantAsistencia(ent);
        }
    }
}

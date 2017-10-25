using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Entidad;
using Datos;
using System.Data;

namespace Negocio
{
    public class Ntb_Reportes
    {
        Dtb_Reportes objDatos;
        public DataSet N_Reportes(string f1, string f2, string in_sede, string in_camp)
        {
            objDatos = new Dtb_Reportes();
            return objDatos.D_Reportes(f1,f2,in_sede,in_camp);
        }

        public DataSet N_ReportesG(string f1, string f2, string in_sede, string in_camp)
        {
            objDatos = new Dtb_Reportes();
            return objDatos.D_ReportesG(f1, f2, in_sede, in_camp);
        }

        //public DataTable N_ReportesCantAsisFalt(int in_AgenteID)
        //{
        //    objDatos = new Dtb_Reportes();
        //    return objDatos.D_ReportesCantAsisFalt(in_AgenteID);
        //}

        //public DataTable N_ReportesPagosValid(int in_AgenteID, int in_NroPago)
        //{
        //    objDatos = new Dtb_Reportes();
        //    return objDatos.D_ReportesPagosValid(in_AgenteID, in_NroPago);
        //}
    }
}

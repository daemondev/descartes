using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Entidad
{
     public class Etb_Capacitacion : E_VariablesGenerales
    {
        public int in_CapaID { get; set; }
        public int in_CampaniaID { get; set; }
        public int in_CantAgentes { get; set; }
        public int in_CantDias { get; set; }
        public int in_CantPartes { get; set; }
        public int in_UsuarioID { get; set; }

        public int in_Orden { get; set; }
        public int in_Cierre { get; set; }
        public int in_Dia { get; set; }
        public int in_TurnoID { get; set; }
        public decimal dc_Monto { get; set; }

        public decimal dc_PagoTotal { get; set; }
        public decimal dc_PagoDia { get; set; }

        public string vc_Abreviatura { get; set; }
        public string vc_Titulo { get; set; }
        public string dt_FechRegistro { get; set; }
        public string dt_FechInicio { get; set; }
        public string dt_FechFin { get; set; }
        public string vc_Nombres { get; set; }
        public string vc_Estado { get; set; }
        public string vc_Cierre { get; set; }
        public string vc_Monto { get; set; }
        public string vc_Pago { get; set; }
        public string vc_Campania { get; set; }
        public string vc_Turno { get; set; }

        public string cadDatos { get; set; }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Entidad
{
    public class Etb_Pagos : E_VariablesGenerales
    {
        public int in_CapaID { get; set; }
        public int in_AgenteID { get; set; }
        public int in_NroPago { get; set; }
        public int in_Validar { get; set; }

        public int in_CantAsis { get; set; }
        public int in_CantFalt { get; set; }
        public int in_ValidCapa { get; set; }
        public int in_ValidDH { get; set; }
        public int in_ValidPM { get; set; }
        public int in_Pagado { get; set; }

        public decimal dc_Monto { get; set; }

        public string vc_Filas { get; set; }
    }
}

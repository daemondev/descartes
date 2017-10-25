using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Entidad
{
    public class Etb_Mensaje : E_VariablesGenerales
    {
        public int in_MensajeID { get; set; }
        public int emisor { get; set; }
        public int receptor { get; set; }
        public string mensaje { get; set; }
        public string FechaHoraMSG { get; set; }
        public Boolean visto { get; set; }
        public string nombreEmisor { get; set; }
        public string nombreReceptor { get; set; }
    }
}

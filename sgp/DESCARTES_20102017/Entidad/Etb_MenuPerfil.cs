using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Entidad
{
    public class Etb_MenuPerfil
    {
        public int in_PerfilID { get; set; }

        public string in_PerfilMenu { get; set; }
        public string in_MenuID { get; set; }
        public string in_PadreID { get; set; }
        public string in_Orden { get; set; }
        public string vc_NomMenu { get; set; }
        public string vc_Url { get; set; }
        public string vc_Imagen { get; set; }
    }
}

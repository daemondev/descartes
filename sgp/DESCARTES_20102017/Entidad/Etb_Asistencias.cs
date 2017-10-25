using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Entidad
{
    public class Etb_Asistencias : E_VariablesGenerales
    {
        public int in_CapaID { get; set; }
        public int in_UsuRegist { get; set; }
        public int in_CantAsitentes { get; set; }
        public int in_CantFaltantes { get; set; }
        public int in_AgenteID { get; set; }
        public int in_Asistencia { get; set; }
        public int in_Condicion { get; set; }
        public int in_Resul { get; set; }
        public string vc_Usuario { get; set; }
        public string vc_Nombres { get; set; }

        public string vc_ItemAsistencia { get; set; }
    }
}

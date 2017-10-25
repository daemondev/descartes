using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Entidad
{
    public class Etb_CargaAgentes : E_VariablesGenerales
    {
        public int in_CargaID { get; set; }
        public int in_CapaID { get; set; }
        public int in_UsuRegistroID { get; set; }
        public int in_CantAgentes { get; set; }
        public int in_AgenteID { get; set; }
        public int in_Estado { get; set; }
        public string vc_Usuario { get; set; }
        public string vc_DNI { get; set; }
        public string vc_Nombre { get; set; }
        public string vc_ApePaterno { get; set; }
        public string vc_ApeMaterno { get; set; }
        public string vc_Observacion { get; set; }
    }
}

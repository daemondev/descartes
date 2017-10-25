using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Entidad
{
    public class Etb_Sede : E_VariablesGenerales
    {
        public int in_SedeID { get; set; }
        public string vc_Sede { get; set; }
        public int in_Estado { get; set; }
        public int in_UsuarioID { get; set; }
        public string vc_Nombres { get; set; }
        public string dt_FechRegistro { get; set; }
    }
}

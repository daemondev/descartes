using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Entidad
{
    public class Etb_Turno : E_VariablesGenerales
    {
        public int in_UsuRegistroID { get; set; }
        public int in_TurnoID { get; set; }
        public int in_SedeID { get; set; }
        public int in_Estado { get; set; }

        public string vc_Simbolo { get; set; }
        public string vc_Descripcion { get; set; }
        public string vc_HoraInicio { get; set; }
        public string vc_HoraFin { get; set; }
        public string vc_Nombres { get; set; }
    }
}

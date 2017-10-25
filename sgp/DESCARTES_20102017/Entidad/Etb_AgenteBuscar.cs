using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Entidad
{
    public class Etb_AgenteBuscar : E_VariablesGenerales
    {
        public int in_AgenteID { get; set; }
        public int in_CampaniaID { get; set; }
        public int in_Estado { get; set; }
        public int in_CapaID { get; set; }
        public string vc_Agente { get; set; }
        public string vc_Usuario { get; set; }
        public string vc_DNI { get; set; }
        public string Nombres { get; set; }
        public string vc_Titulo { get; set; }
        public string vc_Campania { get; set; }

        public string vc_ItemAsistencia { get; set; }
        public string vc_Filas { get; set; }
    }
}

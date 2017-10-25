using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Entidad
{
    public class Etb_Usuario : E_VariablesGenerales
    {
        public int in_UsuarioID { get; set; }
        public int in_Estado { get; set; }
        public int in_PerfilID { get; set; }
        public int in_SedeID { get; set; }
        public string vc_DNI { get; set; }
        public string vc_Nombre { get; set; }
        public string vc_ApePaterno { get; set; }
        public string vc_ApeMaterno { get; set; }
        public string vc_Usuario { get; set; }
        public string vc_Clave { get; set; }
        public string vc_Perfil { get; set; }
        public string vc_Sede { get; set; }
        public string vc_FecRegistro { get; set; }
        public string vc_Correo { get; set; }
        public int in_CampaniaID { get; set; }
        public string vc_CampaniaID { get; set; }
        public string vc_usuario { get; set; }
        public bool EstadoConexion { get; set; }
        public int msgsNoleidos { get; set; }

    }
}

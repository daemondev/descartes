using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Entidad
{
    public class Etb_Campania : E_VariablesGenerales
    {
        public int in_CampaniaID { get; set; }
        public int in_SedeID { get; set; }
        public int in_UsuarioID { get; set; }
        public int in_Estado { get; set; }
        public string dt_FechRegistro { get; set; }
        public string vc_Nombres { get; set; }
        public string vc_Campania { get; set; }
        public string vc_Sede { get; set; }
        public decimal dc_PagoDia { get; set; }

        //asignacion matrices

        public int cod { get; set; }
        public int in_campannia { get; set; }
        public int in_nivel { get; set; }
        public int in_estado { get; set; }
        public int indice { get; set; }
        public int id_nivel { get; set; }
        public string vc_titulo { get; set; }
        public string vc_url_img { get; set; }
        public int in_orden { get; set; }
        public int in_usuario_reg { get; set; }
        public int total { get; set; }
        public int pagenum { get; set; }
        public int pagesize { get; set; }

    }
}

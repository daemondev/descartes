using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Entidad
{
	public class Etb_NIVEL
	{
		public int indice { get; set; }
		public int id_nivel { get; set; }
		public int in_cate { get; set; }
		public string vc_titulo { get; set; }
		public string vc_descripcion { get; set; }
		public string vc_url_img { get; set; }
		public int in_rpta { get; set; }
		public int in_tipo_rpta { get; set; }
		public int in_dpndncia_idnivel { get; set; }
		public string vc_alerta { get; set; }
		public int in_orden { get; set; }
		public int in_estado { get; set; }
		public int total { get; set; }
		public int pagenum { get; set; }
		public int pagesize { get; set; }
		public int in_result { get; set; }
		public int in_link { get; set; }
		public string vc_enlase { get; set; }
        public string vc_color_alerta { get; set; }

        public int in_UsuarioID { get; set; }

		//CAMPOS DE REGISTRO DE CONTENIDO.
		public string vc_contexto { get; set; }
		public string vc_color { get; set; }
		public string vc_subrayado { get; set; }
		public int in_idcontenido { get; set; }
        public string vc_contenido { get; set; }

    }
}

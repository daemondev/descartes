using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Entidad
{
	public class Etb_Cliente
	{
		public int id_cliente { get; set; }
		public string vc_nombre { get; set; }
		public string vc_codigo { get; set; }
		public int in_archivo { get; set; }
		public int in_estado { get; set; }
		public int in_Resul { get; set; }
		public int indice { get; set; }
		public int pagenum { get; set; }
		public int pagesize { get; set; }
		public string dt_fecregistro { get; set; }
		public int total { get; set; }
		public string vc_apellidos { get; set; }
		public string vc_value { get; set; }
		public int in_result { get; set; }
        public string vc_resultado { get; set; }
        public string vc_tipificacion { get; set; }
        public string vc_obs { get; set; }
        public string vc_duracion { get; set; }
	}
}

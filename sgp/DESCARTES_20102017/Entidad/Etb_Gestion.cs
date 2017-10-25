using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Entidad
{
	public class Etb_Gestion
	{
		public int ID { get; set; }
        public int in_usuario { get; set; }
        public string proceso { get; set; }
        public string vc_tipificacion { get; set; }
        public string horaInicio { get; set; }
        public string vc_duracion { get; set; }
        public string dt_fec_registro { get; set; }
        public int indice { get; set; }
	}
}

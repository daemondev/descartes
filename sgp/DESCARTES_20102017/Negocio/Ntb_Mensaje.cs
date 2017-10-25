using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Entidad;
using Datos;

namespace Negocio
{
    public class Ntb_Mensaje
    {
        Dtb_Mensaje objDatos;

        public List<Etb_Mensaje> mostrarChat(int Emisor, int Receptor)
        {
            objDatos = new Dtb_Mensaje();
            return objDatos.mostrarChat(Emisor,Receptor);
        }

        public void EnviarMensaje(string msg, int emisor, int receptor)
        {
            objDatos = new Dtb_Mensaje();
            objDatos.EnviarMensaje(msg, emisor, receptor);
        }
        public void EliminarHistorial(int emisor, int receptor)
        {
            objDatos = new Dtb_Mensaje();
            objDatos.EliminarHistorial(emisor, receptor);
        }
    }
}

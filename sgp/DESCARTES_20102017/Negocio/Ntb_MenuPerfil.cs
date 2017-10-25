using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Entidad;
using Datos;

namespace Negocio
{
    public class Ntb_MenuPerfil
    {
        Dtb_MenuPerfil objDatos;

        public List<Etb_MenuPerfil> N_ListarMenuPerfil(Etb_MenuPerfil ent)
        {
            objDatos = new Dtb_MenuPerfil();
            return objDatos.D_ListarMenuPerfil(ent);
        }
    }
}

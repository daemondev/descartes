using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Entidad;
using Datos;

namespace Negocio
{
    public class Ntb_Perfil
    {
        Dtb_Perfil objSede;
        public List<Etb_Perfil> N_MantPerfil()
        {
            objSede = new Dtb_Perfil();
            return objSede.D_MantPerfil();
        }
    }
}

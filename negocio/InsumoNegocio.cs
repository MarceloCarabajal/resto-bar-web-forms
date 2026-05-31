using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using dominio;

namespace negocio
{
    public class InsumoNegocio
    {
        public List<Insumo> listar()
        {
            List<Insumo> lista = new List<Insumo>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                string consulta = "SELECT Id, Nombre, IdTipoInsumo, Precio, CantidadStock, Activo FROM Insumos WHERE Activo = 1";

                datos.setearConsulta(consulta);
                datos.ejecutarLectura();


                while (datos.Lector.Read())
                {
                    Insumo aux = new Insumo();

                    
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.IdTipoInsumo = (int)datos.Lector["IdTipoInsumo"];
                    aux.Precio = (decimal)datos.Lector["Precio"];
                    aux.CantidadStock = (int)datos.Lector["CantidadStock"];
                    aux.Activo = (bool)datos.Lector["Activo"];


                    aux.Tipo = "Insumo";

                    lista.Add(aux);
                }

                return lista;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

                datos.cerrarConexion();
            }
        }

    }
}

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
                datos.setearProcedimiento("sp_listar_insumos");
                datos.setearParametro("@SoloActivos", true);
                datos.setearParametro("@ConStock", false);
                datos.ejecutarLectura();


                while (datos.Lector.Read())
                {
                    Insumo aux = new Insumo();

                    
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Tipo = new TipoInsumo();
                    aux.Tipo.Id = (int)datos.Lector["IdTipoInsumo"];
                    aux.Tipo.Nombre = (string)datos.Lector["Tipo"];
                    aux.Precio = (decimal)datos.Lector["Precio"];
                    aux.CantidadStock = (int)datos.Lector["CantidadStock"];
                    aux.Activo = (bool)datos.Lector["Activo"];

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

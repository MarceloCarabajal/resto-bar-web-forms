using System;
using System.Collections.Generic;
using dominio;

namespace negocio
{
    public class InsumoNegocio
    {
        public List<Insumo> listar(bool soloActivos = false, bool conStock = false)
        {
            List<Insumo> lista = new List<Insumo>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("sp_listar_insumos");
                datos.setearParametro("@SoloActivos", soloActivos);
                datos.setearParametro("@ConStock", conStock);
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

        public Insumo obtener(int id)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("sp_obtener_insumo");
                datos.setearParametro("@Id", id);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
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

                    return aux;
                }

                return null;
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

        public int agregar(Insumo insumo)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("sp_agregar_insumo");
                datos.setearParametro("@Nombre", insumo.Nombre);
                datos.setearParametro("@IdTipoInsumo", insumo.Tipo.Id);
                datos.setearParametro("@Precio", insumo.Precio);
                datos.setearParametro("@CantidadStock", insumo.CantidadStock);

                return datos.ejecutarAccionScalar();
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

        public void modificar(Insumo insumo)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("sp_modificar_insumo");
                datos.setearParametro("@Id", insumo.Id);
                datos.setearParametro("@Nombre", insumo.Nombre);
                datos.setearParametro("@IdTipoInsumo", insumo.Tipo.Id);
                datos.setearParametro("@Precio", insumo.Precio);
                datos.setearParametro("@CantidadStock", insumo.CantidadStock);
                datos.ejecutarAccion();
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

        public void inactivar(int id)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("sp_inactivar_insumo");
                datos.setearParametro("@Id", id);
                datos.ejecutarAccion();
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

        public void activar(int id)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("sp_activar_insumo");
                datos.setearParametro("@Id", id);
                datos.ejecutarAccion();
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

        public List<TipoInsumo> listarTipos()
        {
            List<TipoInsumo> lista = new List<TipoInsumo>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("sp_listar_tipos_insumo");
                datos.setearParametro("@SoloActivos", true);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    TipoInsumo aux = new TipoInsumo();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
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

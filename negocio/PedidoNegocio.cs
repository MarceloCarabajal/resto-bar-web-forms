using System;
using System.Collections.Generic;
using dominio;

namespace negocio
{
    public class PedidoNegocio
    {
        public int abrir(int idMesa, int idMesero)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("sp_abrir_pedido");
                datos.setearParametro("@IdMesa", idMesa);
                datos.setearParametro("@IdMesero", idMesero);

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

        public Pedido obtener(int idPedido)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"SELECT p.Id, p.IdMesa, m.Numero AS NumeroMesa, p.IdMesero,
                                              u.Nombre + ' ' + u.Apellido AS Mesero,
                                              p.FechaApertura, p.FechaCierre, p.Estado, p.Total
                                       FROM Pedidos p
                                       INNER JOIN Mesas m ON m.Id = p.IdMesa
                                       INNER JOIN Usuarios u ON u.Id = p.IdMesero
                                       WHERE p.Id = @IdPedido");
                datos.setearParametro("@IdPedido", idPedido);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    Pedido aux = new Pedido();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.IdMesa = (int)datos.Lector["IdMesa"];
                    aux.NumeroMesa = (int)datos.Lector["NumeroMesa"];
                    aux.IdMesero = (int)datos.Lector["IdMesero"];
                    aux.Mesero = (string)datos.Lector["Mesero"];
                    aux.FechaApertura = (DateTime)datos.Lector["FechaApertura"];
                    if (datos.Lector["FechaCierre"] != DBNull.Value)
                        aux.FechaCierre = (DateTime)datos.Lector["FechaCierre"];
                    aux.Estado = (string)datos.Lector["Estado"];
                    aux.Total = (decimal)datos.Lector["Total"];

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

        public void agregarItem(int idPedido, int idInsumo, int cantidad)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("sp_agregar_detalle_pedido");
                datos.setearParametro("@IdPedido", idPedido);
                datos.setearParametro("@IdInsumo", idInsumo);
                datos.setearParametro("@Cantidad", cantidad);
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

        public void eliminarItem(int idPedido, int idItemPedido)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"SET XACT_ABORT ON;

                                       BEGIN TRY
                                           BEGIN TRANSACTION;

                                           IF NOT EXISTS (SELECT 1 FROM Pedidos WHERE Id = @IdPedido AND Estado = N'Abierto')
                                           BEGIN
                                               RAISERROR(N'El pedido no existe o no esta abierto.', 16, 1);
                                               ROLLBACK TRANSACTION;
                                               RETURN;
                                           END

                                           DECLARE @IdInsumo INT;
                                           DECLARE @Cantidad INT;

                                           SELECT @IdInsumo = IdInsumo, @Cantidad = Cantidad
                                           FROM PedidoDetalle
                                           WHERE Id = @IdItemPedido AND IdPedido = @IdPedido;

                                           IF @IdInsumo IS NULL
                                           BEGIN
                                               RAISERROR(N'El item no existe en este pedido.', 16, 1);
                                               ROLLBACK TRANSACTION;
                                               RETURN;
                                           END

                                           DELETE FROM PedidoDetalle
                                           WHERE Id = @IdItemPedido AND IdPedido = @IdPedido;

                                           UPDATE Insumos
                                           SET CantidadStock = CantidadStock + @Cantidad
                                           WHERE Id = @IdInsumo;

                                           UPDATE Pedidos
                                           SET Total = (
                                               SELECT ISNULL(SUM(d.Cantidad * d.PrecioUnitario), 0)
                                               FROM PedidoDetalle d
                                               WHERE d.IdPedido = @IdPedido
                                           )
                                           WHERE Id = @IdPedido;

                                           COMMIT TRANSACTION;
                                       END TRY
                                       BEGIN CATCH
                                           IF @@TRANCOUNT > 0
                                               ROLLBACK TRANSACTION;
                                           THROW;
                                       END CATCH");
                datos.setearParametro("@IdPedido", idPedido);
                datos.setearParametro("@IdItemPedido", idItemPedido);
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

        public void cerrar(int idPedido)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("sp_cerrar_pedido");
                datos.setearParametro("@IdPedido", idPedido);
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

        public List<ItemPedido> listarDetalle(int idPedido)
        {
            List<ItemPedido> lista = new List<ItemPedido>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("sp_listar_detalle_pedido");
                datos.setearParametro("@IdPedido", idPedido);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    ItemPedido aux = new ItemPedido();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Insumo = new Insumo();
                    aux.Insumo.Id = (int)datos.Lector["IdInsumo"];
                    aux.Insumo.Nombre = (string)datos.Lector["Insumo"];
                    aux.Cantidad = (int)datos.Lector["Cantidad"];
                    aux.PrecioUnitario = (decimal)datos.Lector["PrecioUnitario"];
                    aux.Subtotal = (decimal)datos.Lector["Subtotal"];

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

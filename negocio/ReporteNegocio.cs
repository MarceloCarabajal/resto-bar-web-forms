using System;
using System.Collections.Generic;
using dominio;

namespace negocio
{
    public class ReporteNegocio
    {
        public List<ReportePorMesa> listarPorMesa(DateTime fecha)
        {
            List<ReportePorMesa> lista = new List<ReportePorMesa>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("sp_reporte_pedidos_por_mesa");
                datos.setearParametro("@Fecha", fecha.Date);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    ReportePorMesa aux = new ReportePorMesa();
                    aux.NumeroMesa = (int)datos.Lector["NumeroMesa"];
                    aux.CantidadPedidos = (int)datos.Lector["CantidadPedidos"];
                    aux.TotalVendido = (decimal)datos.Lector["TotalVendido"];

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

        public List<ReportePorMesero> listarPorMesero(DateTime fecha)
        {
            List<ReportePorMesero> lista = new List<ReportePorMesero>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("sp_reporte_pedidos_por_mesero");
                datos.setearParametro("@Fecha", fecha.Date);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    ReportePorMesero aux = new ReportePorMesero();
                    aux.Mesero = (string)datos.Lector["Mesero"];
                    aux.CantidadPedidos = (int)datos.Lector["CantidadPedidos"];
                    aux.TotalVendido = (decimal)datos.Lector["TotalVendido"];

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
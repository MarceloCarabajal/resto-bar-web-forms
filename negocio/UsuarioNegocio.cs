using dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace negocio
{
    public class UsuarioNegocio
    {
        public List<Usuario> listar(bool soloActivos = true)
        {
            List<Usuario> lista = new List<Usuario>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("sp_listar_usuarios");
                datos.setearParametro("@SoloActivos", soloActivos);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Usuario aux = new Usuario();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.UserName = (string)datos.Lector["UserName"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
                    aux.Activo = (bool)datos.Lector["Activo"];


                    aux.Rol = new Rol();
                    aux.Rol.Id = (int)datos.Lector["IdRol"];
                    aux.Rol.Nombre = (string)datos.Lector["RolNombre"];

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


        public Usuario obtener(int id)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("sp_obtener_usuario");
                datos.setearParametro("@Id", id);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    Usuario aux = new Usuario();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.UserName = (string)datos.Lector["UserName"];
                    aux.Clave = (string)datos.Lector["Clave"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
                    aux.Activo = (bool)datos.Lector["Activo"];

                    aux.Rol = new Rol();
                    aux.Rol.Id = (int)datos.Lector["IdRol"];
                    aux.Rol.Nombre = (string)datos.Lector["RolNombre"];

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


        public List<Rol> listarRoles()
        {
            List<Rol> lista = new List<Rol>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("sp_listar_roles");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Rol aux = new Rol();
                    aux.Id = (int)datos.Lector["Id"];
                   aux.Nombre = (string)datos.Lector["Nombre"];
                  

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


        public int agregar(Usuario nuevo)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("sp_agregar_usuario");
                datos.setearParametro("@UserName", nuevo.UserName);
                datos.setearParametro("@Clave", nuevo.Clave);
                datos.setearParametro("@Nombre", nuevo.Nombre);
                datos.setearParametro("@Apellido", nuevo.Apellido);
               


                if (nuevo.Rol != null)
                {
                    datos.setearParametro("@IdRol", nuevo.Rol.Id);
                }
                else
                {
                   
                    datos.setearParametro("@IdRol", 2);
                }

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


        public void modificar(Usuario user)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("sp_modificar_usuario");
                datos.setearParametro("@Id", user.Id);
                datos.setearParametro("@UserName", user.UserName);
                datos.setearParametro("@Clave", user.Clave);
                datos.setearParametro("@Nombre", user.Nombre);
                datos.setearParametro("@Apellido", user.Apellido);

                if (user.Rol != null)
                {
                    datos.setearParametro("@IdRol", user.Rol.Id);
                }
                else
                {

                    datos.setearParametro("@IdRol", 1);
                }

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
                datos.setearProcedimiento("sp_inactivar_usuario");
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
                datos.setearProcedimiento("sp_activar_usuario");
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


        public Usuario login(string userName, string clave)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearProcedimiento("sp_login");
                datos.setearParametro("@UserName", userName);
                datos.setearParametro("@Clave", clave);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    Usuario aux = new Usuario();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.UserName = (string)datos.Lector["UserName"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
                    aux.Activo = (bool)datos.Lector["Activo"];

                    aux.Rol = new Rol();
                    aux.Rol.Id = (int)datos.Lector["IdRol"];
                    aux.Rol.Nombre = (string)datos.Lector["RolNombre"];

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


    }

}


using System;
using System.Configuration;
using System.Data.SqlClient;

namespace negocio
{
    /// <summary>
    /// Helper de acceso a datos
    /// La cadena se lee de appSettings["cadenaConexion"] en Web.config del sitio web.
    /// </summary>
    public class AccesoDatos
    {
        private SqlConnection conexion;
        private SqlCommand comando;
        private SqlDataReader lector;

        public SqlDataReader Lector => lector;

        public AccesoDatos()
        {
            conexion = new SqlConnection(ConfigurationManager.AppSettings["cadenaConexion"]);
            comando = new SqlCommand();
        }

        public void setearConsulta(string consulta)
        {
            comando.CommandType = System.Data.CommandType.Text;
            comando.CommandText = consulta;
        }

        public void setearProcedimiento(string sp)
        {
            comando.CommandType = System.Data.CommandType.StoredProcedure;
            comando.CommandText = sp;
        }

        public void ejecutarLectura()
        {
            comando.Connection = conexion;
            conexion.Open();
            lector = comando.ExecuteReader();
        }

        public void ejecutarAccion()
        {
            comando.Connection = conexion;
            conexion.Open();
            comando.ExecuteNonQuery();
        }

        public int ejecutarAccionScalar()
        {
            comando.Connection = conexion;
            conexion.Open();
            object resultado = comando.ExecuteScalar();
            return int.Parse(resultado.ToString());
        }

        public void setearParametro(string nombre, object valor)
        {
            comando.Parameters.AddWithValue(nombre, valor);
        }

        public void cerrarConexion()
        {
            if (lector != null)
                lector.Close();
            if (conexion.State == System.Data.ConnectionState.Open)
                conexion.Close();
        }
    }
}

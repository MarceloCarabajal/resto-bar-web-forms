using System.ComponentModel;

namespace dominio
{
    public class Usuario
    {
        public int Id { get; set; }
        public string UserName { get; set; }
        public string Clave { get; set; }
        [DisplayName("Nombre")]
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public int IdRol { get; set; }
        public string RolNombre { get; set; }
        public bool Activo { get; set; }

        public bool EsGerente => RolNombre == "Gerente";
        public bool EsMesero => RolNombre == "Mesero";
    }
}

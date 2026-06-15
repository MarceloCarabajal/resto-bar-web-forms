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
        public Rol Rol { get; set; }
        public bool Activo { get; set; }

        public bool EsGerente => Rol != null && Rol.Nombre == "Gerente";
        public bool EsMesero => Rol != null && Rol.Nombre == "Mesero";
    }
}

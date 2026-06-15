using System.ComponentModel;

namespace dominio
{
    public class Insumo
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
        public TipoInsumo Tipo { get; set; }
        public decimal Precio { get; set; }
        [DisplayName("Stock")]
        public int CantidadStock { get; set; }
        public bool Activo { get; set; }
    }
}

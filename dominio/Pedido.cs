using System;

namespace dominio
{
    public class Pedido
    {
        public int Id { get; set; }
        public int IdMesa { get; set; }
        public int NumeroMesa { get; set; }
        public int IdMesero { get; set; }
        public string Mesero { get; set; }
        public DateTime FechaApertura { get; set; }
        public DateTime? FechaCierre { get; set; }
        public string Estado { get; set; }
        public decimal Total { get; set; }
    }
}

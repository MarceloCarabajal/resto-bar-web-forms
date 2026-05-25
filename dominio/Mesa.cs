namespace dominio
{
    public class Mesa
    {
        public int Id { get; set; }
        public int Numero { get; set; }
        public bool Activo { get; set; }
        public string EstadoMesa { get; set; }
        public int? IdPedidoAbierto { get; set; }
        public int IdMesero { get; set; }
        public string Mesero { get; set; }
    }
}

namespace dominio
{
    public class ItemPedido
    {
        public int Id { get; set; }
        public Insumo Insumo { get; set; }
        public int Cantidad { get; set; }
        public decimal PrecioUnitario { get; set; }
        public decimal Subtotal { get; set; }
    }
}

namespace dominio
{
    /// <summary>
    /// Id + Descripcion para DropDownList (tipos de insumo, meseros, etc.).
    /// Mismo patrón que el curso (Elemento en Pokedex).
    /// </summary>
    public class Elemento
    {
        public int Id { get; set; }
        public string Descripcion { get; set; }
    }
}

using System;
using System.Web.UI;
using dominio;
using negocio;

namespace resto_bar_web
{
    public partial class MesaForm : Page
    {
        private int? IdMesa
        {
            get
            {
                int id;
                if (int.TryParse(Request.QueryString["id"], out id))
                    return id;

                return null;
            }
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            UnobtrusiveValidationMode = System.Web.UI.UnobtrusiveValidationMode.None;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                litTitulo.Text = IdMesa.HasValue ? "Editar mesa" : "Agregar mesa";

                if (IdMesa.HasValue)
                    cargarMesa(IdMesa.Value);
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            try
            {
                Mesa mesa = new Mesa();
                mesa.Numero = int.Parse(txtNumero.Text.Trim());

                MesaNegocio negocioMesa = new MesaNegocio();

                if (IdMesa.HasValue)
                {
                    mesa.Id = IdMesa.Value;
                    negocioMesa.modificar(mesa);
                }
                else
                {
                    negocioMesa.agregar(mesa);
                }

                Response.Redirect("MesasLista.aspx", false);
            }
            catch (Exception ex)
            {
                mostrarError(ex.Message);
            }
        }

        private void cargarMesa(int id)
        {
            try
            {
                MesaNegocio negocioMesa = new MesaNegocio();
                Mesa mesa = negocioMesa.obtener(id);

                if (mesa == null)
                {
                    mostrarError("No se encontro la mesa solicitada.");
                    btnGuardar.Enabled = false;
                    return;
                }

                txtNumero.Text = mesa.Numero.ToString();
            }
            catch (Exception ex)
            {
                mostrarError(ex.Message);
                btnGuardar.Enabled = false;
            }
        }

        private void mostrarError(string mensaje)
        {
            pnlMensaje.Visible = true;
            litMensaje.Text = Server.HtmlEncode(mensaje);
        }
    }
}

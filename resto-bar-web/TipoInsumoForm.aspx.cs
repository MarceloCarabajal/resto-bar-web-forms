using System;
using System.Web.UI;
using dominio;
using negocio;

namespace resto_bar_web
{
    public partial class TipoInsumoForm : Page
    {
        private int? IdTipo
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
                litTitulo.Text = IdTipo.HasValue ? "Editar tipo de insumo" : "Agregar tipo de insumo";

                if (IdTipo.HasValue)
                    cargarTipo(IdTipo.Value);
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            try
            {
                TipoInsumo tipo = new TipoInsumo();
                tipo.Nombre = txtNombre.Text.Trim();

                TipoInsumoNegocio negocioTipo = new TipoInsumoNegocio();

                if (IdTipo.HasValue)
                {
                    tipo.Id = IdTipo.Value;
                    negocioTipo.modificar(tipo);
                }
                else
                {
                    negocioTipo.agregar(tipo);
                }

                Response.Redirect("TiposInsumoLista.aspx", false);
            }
            catch (Exception ex)
            {
                mostrarError(ex.Message);
            }
        }

        private void cargarTipo(int id)
        {
            try
            {
                TipoInsumoNegocio negocioTipo = new TipoInsumoNegocio();
                TipoInsumo tipo = negocioTipo.obtener(id);

                if (tipo == null)
                {
                    mostrarError("No se encontro el tipo de insumo solicitado.");
                    btnGuardar.Enabled = false;
                    return;
                }

                txtNombre.Text = tipo.Nombre;
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

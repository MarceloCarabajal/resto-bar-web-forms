using System;
using System.Web.UI;
using negocio;

namespace resto_bar_web
{
    public partial class Reportes : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtFecha.Text = DateTime.Today.ToString("yyyy-MM-dd");
                cargarReportes(DateTime.Today);
            }
        }

        protected void btnConsultar_Click(object sender, EventArgs e)
        {
            try
            {
                DateTime fecha = DateTime.Parse(txtFecha.Text);
                cargarReportes(fecha);
            }
            catch (Exception ex)
            {
                mostrarError(ex.Message);
            }
        }

        private void cargarReportes(DateTime fecha)
        {
            try
            {
                pnlMensaje.Visible = false;

                ReporteNegocio negocioReporte = new ReporteNegocio();

                dgvPorMesa.DataSource = negocioReporte.listarPorMesa(fecha);
                dgvPorMesa.DataBind();

                dgvPorMesero.DataSource = negocioReporte.listarPorMesero(fecha);
                dgvPorMesero.DataBind();
            }
            catch (Exception ex)
            {
                mostrarError(ex.Message);
            }
        }

        private void mostrarError(string mensaje)
        {
            pnlMensaje.Visible = true;
            litMensaje.Text = Server.HtmlEncode(mensaje);
        }
    }
}
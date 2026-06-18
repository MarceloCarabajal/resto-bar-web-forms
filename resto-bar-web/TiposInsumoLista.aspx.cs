using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using negocio;

namespace resto_bar_web
{
    public partial class TiposInsumoLista : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                cargarTipos();
        }

        protected void dgvTiposInsumo_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "InactivarTipo" && e.CommandName != "ActivarTipo")
                return;

            try
            {
                int id = int.Parse(e.CommandArgument.ToString());
                TipoInsumoNegocio negocioTipo = new TipoInsumoNegocio();

                if (e.CommandName == "InactivarTipo")
                    negocioTipo.inactivar(id);
                else
                    negocioTipo.activar(id);

                Response.Redirect("TiposInsumoLista.aspx", false);
            }
            catch (Exception ex)
            {
                mostrarError(ex.Message);
                cargarTipos();
            }
        }

        private void cargarTipos()
        {
            try
            {
                TipoInsumoNegocio negocioTipo = new TipoInsumoNegocio();
                dgvTiposInsumo.DataSource = negocioTipo.listar(false);
                dgvTiposInsumo.DataBind();
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

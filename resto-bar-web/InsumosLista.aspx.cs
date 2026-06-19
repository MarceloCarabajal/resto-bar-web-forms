using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using negocio;

namespace resto_bar_web
{
    public partial class InsumosLista : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                cargarInsumos();
        }

        protected void dgvInsumos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "InactivarInsumo" && e.CommandName != "ActivarInsumo")
                return;

            try
            {
                int id = int.Parse(e.CommandArgument.ToString());
                InsumoNegocio negocioInsumo = new InsumoNegocio();

                if (e.CommandName == "InactivarInsumo")
                    negocioInsumo.inactivar(id);
                else
                    negocioInsumo.activar(id);

                Response.Redirect("InsumosLista.aspx", false);
            }
            catch (Exception ex)
            {
                mostrarError(ex.Message);
                cargarInsumos();
            }
        }

        private void cargarInsumos()
        {
            try
            {
                InsumoNegocio negocioInsumo = new InsumoNegocio();
                dgvInsumos.DataSource = negocioInsumo.listar(false);
                dgvInsumos.DataBind();
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

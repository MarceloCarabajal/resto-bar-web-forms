using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using negocio;

namespace resto_bar_web
{
    public partial class MesasLista : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                cargarMesas();
        }

        protected void dgvMesas_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "InactivarMesa" && e.CommandName != "ActivarMesa")
                return;

            try
            {
                int id = int.Parse(e.CommandArgument.ToString());
                MesaNegocio negocioMesa = new MesaNegocio();

                if (e.CommandName == "InactivarMesa")
                    negocioMesa.inactivar(id);
                else
                    negocioMesa.activar(id);

                Response.Redirect("MesasLista.aspx", false);
            }
            catch (Exception ex)
            {
                mostrarError(ex.Message);
                cargarMesas();
            }
        }

        private void cargarMesas()
        {
            try
            {
                MesaNegocio negocioMesa = new MesaNegocio();
                dgvMesas.DataSource = negocioMesa.listar(false);
                dgvMesas.DataBind();
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

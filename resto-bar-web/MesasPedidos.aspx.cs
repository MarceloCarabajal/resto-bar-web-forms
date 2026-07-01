using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using dominio;
using negocio;

namespace resto_bar_web
{
    public partial class MesasPedidos : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                cargarMesas();
        }

        protected void dgvMesas_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "AbrirPedido")
                return;

            try
            {
                string[] valores = e.CommandArgument.ToString().Split('|');
                int idMesa = int.Parse(valores[0]);
                int idMesero = int.Parse(valores[1]);

                PedidoNegocio negocioPedido = new PedidoNegocio();
                int idPedido = negocioPedido.abrir(idMesa, idMesero);

                Response.Redirect("PedidoDetalle.aspx?id=" + idPedido, false);
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
                pnlMensaje.Visible = false;

                MesaNegocio negocioMesa = new MesaNegocio();
                dgvMesas.DataSource = negocioMesa.listarAsignadas(obtenerIdMeseroFiltro());
                dgvMesas.DataBind();
            }
            catch (Exception ex)
            {
                mostrarError(ex.Message);
            }
        }

        private int? obtenerIdMeseroFiltro()
        {
            Usuario usuario = Session["usuario"] as Usuario;
            if (usuario != null && usuario.EsMesero)
                return usuario.Id;

            if (Session["Rol"] != null && Session["Rol"].ToString() == "Mesero" && Session["IdUsuario"] != null)
            {
                int idUsuario;
                if (int.TryParse(Session["IdUsuario"].ToString(), out idUsuario))
                    return idUsuario;
            }

            return null;
        }

        private void mostrarError(string mensaje)
        {
            pnlMensaje.Visible = true;
            litMensaje.Text = Server.HtmlEncode(mensaje);
        }
    }
}

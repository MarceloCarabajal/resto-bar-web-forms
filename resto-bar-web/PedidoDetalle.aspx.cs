using System;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;
using dominio;
using negocio;

namespace resto_bar_web
{
    public partial class PedidoDetalle : Page
    {
        private int? IdPedido
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
                cargarInsumos();
                cargarPedido();
            }
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid || !IdPedido.HasValue)
                return;

            try
            {
                PedidoNegocio negocioPedido = new PedidoNegocio();
                negocioPedido.agregarItem(IdPedido.Value, int.Parse(ddlInsumo.SelectedValue), int.Parse(txtCantidad.Text.Trim()));

                cargarInsumos();
                limpiarCargaItem();
                mostrarExito("Item agregado correctamente.");
                cargarPedido();
            }
            catch (Exception ex)
            {
                mostrarError(ex.Message);
                cargarPedido();
            }
        }

        protected void btnCerrar_Click(object sender, EventArgs e)
        {
            if (!IdPedido.HasValue)
                return;

            try
            {
                PedidoNegocio negocioPedido = new PedidoNegocio();
                negocioPedido.cerrar(IdPedido.Value);

                Response.Redirect("MesasPedidos.aspx", false);
            }
            catch (Exception ex)
            {
                mostrarError(ex.Message);
                cargarPedido();
            }
        }

        protected void dgvDetalle_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "EliminarItem" || !IdPedido.HasValue)
                return;

            try
            {
                int idItemPedido = int.Parse(e.CommandArgument.ToString());

                PedidoNegocio negocioPedido = new PedidoNegocio();
                negocioPedido.eliminarItem(IdPedido.Value, idItemPedido);

                cargarInsumos();
                limpiarCargaItem();
                mostrarExito("Item eliminado correctamente.");
                cargarPedido();
            }
            catch (Exception ex)
            {
                mostrarError(ex.Message);
                cargarPedido();
            }
        }

        private void cargarInsumos()
        {
            try
            {
                InsumoNegocio negocioInsumo = new InsumoNegocio();
                ddlInsumo.Items.Clear();
                ddlInsumo.DataSource = negocioInsumo.listar(true, true);
                ddlInsumo.DataTextField = "Nombre";
                ddlInsumo.DataValueField = "Id";
                ddlInsumo.DataBind();
                ddlInsumo.Items.Insert(0, new ListItem("Seleccione un insumo", "0"));
                seleccionarInsumoPorDefecto();
            }
            catch (Exception ex)
            {
                mostrarError(ex.Message);
                btnAgregar.Enabled = false;
            }
        }

        private void cargarPedido()
        {
            try
            {
                if (!IdPedido.HasValue)
                {
                    mostrarError("No se indico un pedido valido.");
                    pnlCargaItem.Visible = false;
                    btnCerrar.Enabled = false;
                    return;
                }

                PedidoNegocio negocioPedido = new PedidoNegocio();
                Pedido pedido = negocioPedido.obtener(IdPedido.Value);

                if (pedido == null)
                {
                    mostrarError("No se encontro el pedido solicitado.");
                    pnlCargaItem.Visible = false;
                    btnCerrar.Enabled = false;
                    return;
                }

                pedido.Items = negocioPedido.listarDetalle(IdPedido.Value);
                dgvDetalle.DataSource = pedido.Items;
                dgvDetalle.DataBind();

                litTitulo.Text = "Pedido #" + pedido.Id + " - Mesa " + pedido.NumeroMesa;
                litResumen.Text = "Mesero: " + Server.HtmlEncode(pedido.Mesero) + " | Estado: " + Server.HtmlEncode(pedido.Estado);
                litTotal.Text = pedido.Total.ToString("C", CultureInfo.CurrentCulture);

                bool abierto = pedido.Estado == "Abierto";
                pnlCargaItem.Visible = abierto;
                btnCerrar.Visible = abierto;
                if (dgvDetalle.Columns.Count > 4)
                    dgvDetalle.Columns[4].Visible = abierto;
            }
            catch (Exception ex)
            {
                mostrarError(ex.Message);
            }
        }

        private void limpiarCargaItem()
        {
            txtCantidad.Text = string.Empty;
            seleccionarInsumoPorDefecto();
        }

        private void seleccionarInsumoPorDefecto()
        {
            ListItem itemDefault = ddlInsumo.Items.FindByValue("0");
            if (itemDefault != null)
                ddlInsumo.SelectedValue = "0";
        }

        private void mostrarError(string mensaje)
        {
            pnlExito.Visible = false;
            pnlMensaje.Visible = true;
            litMensaje.Text = Server.HtmlEncode(mensaje);
        }

        private void mostrarExito(string mensaje)
        {
            pnlMensaje.Visible = false;
            pnlExito.Visible = true;
            litExito.Text = Server.HtmlEncode(mensaje);
        }
    }
}

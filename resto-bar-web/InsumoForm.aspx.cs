using System;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;
using dominio;
using negocio;

namespace resto_bar_web
{
    public partial class InsumoForm : Page
    {
        private int? IdInsumo
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
                litTitulo.Text = IdInsumo.HasValue ? "Editar insumo" : "Agregar insumo";
                cargarTipos();

                if (IdInsumo.HasValue)
                    cargarInsumo(IdInsumo.Value);
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            try
            {
                Insumo insumo = new Insumo();
                insumo.Nombre = txtNombre.Text.Trim();
                insumo.Tipo = new TipoInsumo();
                insumo.Tipo.Id = int.Parse(ddlTipo.SelectedValue);
                insumo.Precio = decimal.Parse(txtPrecio.Text.Trim(), NumberStyles.Number, CultureInfo.CurrentCulture);
                insumo.CantidadStock = int.Parse(txtStock.Text.Trim());

                InsumoNegocio negocioInsumo = new InsumoNegocio();

                if (IdInsumo.HasValue)
                {
                    insumo.Id = IdInsumo.Value;
                    negocioInsumo.modificar(insumo);
                }
                else
                {
                    negocioInsumo.agregar(insumo);
                }

                Response.Redirect("InsumosLista.aspx", false);
            }
            catch (Exception ex)
            {
                mostrarError(ex.Message);
            }
        }

        private void cargarTipos()
        {
            try
            {
                InsumoNegocio negocioInsumo = new InsumoNegocio();
                ddlTipo.DataSource = negocioInsumo.listarTipos();
                ddlTipo.DataTextField = "Nombre";
                ddlTipo.DataValueField = "Id";
                ddlTipo.DataBind();
                ddlTipo.Items.Insert(0, new ListItem("Seleccione...", ""));
            }
            catch (Exception ex)
            {
                mostrarError(ex.Message);
                btnGuardar.Enabled = false;
            }
        }

        private void cargarInsumo(int id)
        {
            try
            {
                InsumoNegocio negocioInsumo = new InsumoNegocio();
                Insumo insumo = negocioInsumo.obtener(id);

                if (insumo == null)
                {
                    mostrarError("No se encontro el insumo solicitado.");
                    btnGuardar.Enabled = false;
                    return;
                }

                txtNombre.Text = insumo.Nombre;

                ListItem tipoItem = ddlTipo.Items.FindByValue(insumo.Tipo.Id.ToString());
                if (tipoItem == null)
                    ddlTipo.Items.Add(new ListItem(insumo.Tipo.Nombre, insumo.Tipo.Id.ToString()));

                ddlTipo.SelectedValue = insumo.Tipo.Id.ToString();
                txtPrecio.Text = insumo.Precio.ToString(CultureInfo.CurrentCulture);
                txtStock.Text = insumo.CantidadStock.ToString();
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

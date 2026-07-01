using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using dominio;
using negocio;

namespace resto_bar_web
{
    public partial class MesasAsignacion : Page
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            UnobtrusiveValidationMode = System.Web.UI.UnobtrusiveValidationMode.None;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargarMesas();
                cargarMeseros();
                cargarAsignadas();
            }
        }

        protected void btnAsignar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            try
            {
                int idMesa = int.Parse(ddlMesa.SelectedValue);
                int idMesero = int.Parse(ddlMesero.SelectedValue);

                MesaNegocio negocioMesa = new MesaNegocio();
                negocioMesa.asignarMesero(idMesa, idMesero);

                mostrarExito("Mesa asignada correctamente.");
                cargarAsignadas();
            }
            catch (Exception ex)
            {
                mostrarError(ex.Message);
                cargarAsignadas();
            }
        }

        private void cargarMesas()
        {
            MesaNegocio negocioMesa = new MesaNegocio();
            ddlMesa.Items.Clear();
            ddlMesa.Items.Add(new ListItem("Seleccione una mesa", "0"));

            foreach (Mesa mesa in negocioMesa.listar(true))
            {
                ddlMesa.Items.Add(new ListItem("Mesa " + mesa.Numero, mesa.Id.ToString()));
            }
        }

        private void cargarMeseros()
        {
            MesaNegocio negocioMesa = new MesaNegocio();
            ddlMesero.Items.Clear();
            ddlMesero.Items.Add(new ListItem("Seleccione un mesero", "0"));

            foreach (Usuario mesero in negocioMesa.listarMeseros())
            {
                ddlMesero.Items.Add(new ListItem(mesero.Apellido + ", " + mesero.Nombre, mesero.Id.ToString()));
            }
        }

        private void cargarAsignadas()
        {
            try
            {
                MesaNegocio negocioMesa = new MesaNegocio();
                dgvAsignadas.DataSource = negocioMesa.listarAsignadas();
                dgvAsignadas.DataBind();
            }
            catch (Exception ex)
            {
                mostrarError(ex.Message);
            }
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

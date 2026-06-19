using dominio;
using negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace resto_bar_web
{
    public partial class UsuarioForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
                
                if (Request.QueryString["id"] != null)
                {
                    int id = int.Parse(Request.QueryString["id"]);
                    UsuarioNegocio negocio = new UsuarioNegocio();
                    Usuario seleccionado = negocio.obtener(id);

                    txtUserName.Text = seleccionado.UserName;
                    txtNombre.Text = seleccionado.Nombre;
                    txtApellido.Text = seleccionado.Apellido;
                }
            }

        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(txtUserName.Text) ||
            string.IsNullOrEmpty(txtClave.Text) ||
            string.IsNullOrEmpty(txtNombre.Text) ||
            string.IsNullOrEmpty(txtApellido.Text))
                {
                    lblMensaje.Text = "Todos los campos son obligatorios.";
                    return;
                }

                
                if (txtUserName == null) throw new Exception("Error: El campo Usuario no está conectado.");
                if (txtClave == null) throw new Exception("Error: El campo Clave no está conectado.");

                
                Usuario nuevo = new Usuario();
                nuevo.UserName = txtUserName.Text;
                nuevo.Clave = txtClave.Text;
                nuevo.Nombre = txtNombre.Text;
                nuevo.Apellido = txtApellido.Text;

                UsuarioNegocio negocio = new UsuarioNegocio();
                if (negocio == null) throw new Exception("Error: No se pudo crear el objeto UsuarioNegocio.");

                negocio.agregar(nuevo);
                Response.Redirect("UsuarioLista.aspx", false);
            }
            catch (Exception ex)
            {

                lblMensaje.Text = "Error en: " + ex.TargetSite.Name + ". Detalle: " + ex.Message;
               
            }
        }
    }
}
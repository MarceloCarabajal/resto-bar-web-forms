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
                UsuarioNegocio negocio = new UsuarioNegocio();
                ddlRol.DataSource = negocio.listarRoles();
                 
                 ddlRol.DataValueField = "Id";
                 ddlRol.DataTextField = "Nombre";
                 ddlRol.DataBind();
                 ddlRol.Items.Insert(0, new ListItem("Seleccione un rol", "0"));

                if (Request.QueryString["id"] != null)
                {
                    int id = int.Parse(Request.QueryString["id"]);
                    hfIdUsuario.Value = id.ToString();

                   negocio = new UsuarioNegocio();
                    Usuario seleccionado = negocio.obtener(id);

                    txtUserName.Text = seleccionado.UserName;
                    txtNombre.Text = seleccionado.Nombre;
                    txtApellido.Text = seleccionado.Apellido;

                    if (seleccionado.Rol != null)
                    {
                        ddlRol.SelectedValue = seleccionado.Rol.Id.ToString();
                    }
                }
            }

        }

        protected void Page_Init(object sender, EventArgs e)
        {
            UnobtrusiveValidationMode = System.Web.UI.UnobtrusiveValidationMode.None;
        }




        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            Page.Validate("vgUsuario");
            if (!Page.IsValid) return;


            try
            {

                Usuario nuevo = new Usuario();

               
                int id = 0;

                int.TryParse(hfIdUsuario.Value, out id);
                nuevo.Id = id;


                nuevo.UserName = txtUserName.Text;
                nuevo.Clave = txtClave.Text;
                nuevo.Nombre = txtNombre.Text;
                nuevo.Apellido = txtApellido.Text;

                
                nuevo.Rol = new Rol();
                nuevo.Rol.Id = int.Parse(ddlRol.SelectedValue);



                UsuarioNegocio negocio = new UsuarioNegocio();


                if (nuevo.Id != 0)
                {

                    negocio.modificar(nuevo);
                }
                else
                {

                    negocio.agregar(nuevo);
                }


                Response.Redirect("UsuarioLista.aspx", false);
            }
            catch (Exception ex)
            {

                lblMensaje.Text = "Error al guardar: " + ex.Message;
            }

        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
           
            Response.Redirect("UsuarioLista.aspx", false);
        }
        
    }
}
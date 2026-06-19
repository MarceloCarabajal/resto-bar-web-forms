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
    public partial class UsuarioLista : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
                cargarUsuarios();
               
            }
        }

        private void cargarUsuarios()
        {
            UsuarioNegocio negocio = new UsuarioNegocio();
            dgvUsuarios.DataSource = negocio.listar();
            dgvUsuarios.DataBind();

        }

        protected void btnAgregar_Click(object sender , EventArgs e)
        {
            Response.Redirect("UsuarioForm.aspx", false);
        }

        protected void dgvUsuarios_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Modificar")
            {
               
                string id = e.CommandArgument.ToString();

               
                Response.Redirect("UsuarioForm.aspx?id=" + id);
            }

            else if (e.CommandName == "Inactivar")
            {
                int id = int.Parse(e.CommandArgument.ToString());
                UsuarioNegocio negocio = new UsuarioNegocio();

                
                negocio.inactivar(id);

                
                cargarUsuarios();
            }

        }

    }
}
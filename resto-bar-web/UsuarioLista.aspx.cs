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
            try
            {
              

                UsuarioNegocio negocio = new UsuarioNegocio();
                List<Usuario> lista = negocio.listar(false);

                dgvUsuarios.DataSource = lista;
                dgvUsuarios.DataBind();
            }
            catch (Exception ex)
            {
               
                Response.Write("Error al cargar: " + ex.Message);
            }
            
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

             if (e.CommandName == "Activar" || e.CommandName == "Inactivar")
            {
                int id = int.Parse(e.CommandArgument.ToString());

                UsuarioNegocio negocio = new UsuarioNegocio();

              
                if (e.CommandName == "Activar")
                {
                    negocio.activar(id); 
                }
                else 
                {
                    negocio.inactivar(id);
                }


                Response.Redirect("UsuarioLista.aspx", false);
        
            }

        }

    }
}
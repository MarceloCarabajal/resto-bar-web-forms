using dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace resto_bar_web
{
    public partial class MasterPage : System.Web.UI.MasterPage
    {
    protected void Page_Load(object sender, EventArgs e)
        {
            
            string paginaActual = System.IO.Path.GetFileName(Request.Url.AbsolutePath);

            
            if (Session["usuario"] == null && paginaActual != "Login.aspx")
            {
                Response.Redirect("Login.aspx");
                Response.End();
            }

            
            OcultarTodosLosMenus();

          
            if (Session["usuario"] != null)
            {
                Usuario user = (Usuario)Session["usuario"];
                string rol = Session["Rol"]?.ToString();
                lblUsuarioLogueado.Text = user.Nombre + " (" + rol + ")";

              
                if (rol == "Gerente")
                {
                    MostrarMenusGerente();
                }
                else if (rol == "Mesero")
                {
                    
                    if (paginaActual == "UsuarioForm.aspx" || paginaActual == "UsuarioLista.aspx" || paginaActual == "InsumoForm.aspx" || paginaActual == "Reportes.aspx" || paginaActual == "InsumosLista.aspx" || paginaActual == "TiposInsumoForm.aspx")
                
                    {
                        Response.Redirect("Default.aspx");
                        Response.End();
                    }
                    MostrarMenusMesero();
                }
            }
        }
           
        

      
        private void OcultarTodosLosMenus()
        {
            menuUsuarios.Visible = false;
            menuInsumos.Visible = false;
            menuTipos.Visible = false;
            menuMesas.Visible = false;
            menuAsignacion.Visible = false;
            menuReportes.Visible = false;
            menuInicio.Visible = false;
            menuMesasPedidos.Visible = false;
            menuLogin.Visible = false;
        }

        private void MostrarMenusGerente()
        {
            menuInsumos.Visible = true; 
            menuTipos.Visible = true; 
            menuUsuarios.Visible = true;
            menuMesas.Visible = true; 
            menuAsignacion.Visible = true;
            menuReportes.Visible = true;
            menuInicio.Visible = true; 
            menuLogin.Visible = true;
        }

        private void MostrarMenusMesero()
        {
            menuMesas.Visible = true;
            menuAsignacion.Visible = true;
            menuMesasPedidos.Visible = true; 
            menuLogin.Visible = true;
        }

        protected void lnkCerrarSesion_Click(object sender, EventArgs e)
        {

            Session.Clear();
            Session.Abandon();


            Response.Redirect("Login.aspx");
        }



    }
}































    
















    

    

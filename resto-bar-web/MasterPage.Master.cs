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

            if (Session["usuario"] == null)
            {
                LnkCerrarSesion.Visible = false;
            }
            else
            {
                LnkCerrarSesion.Visible = true;
            }

            OcultarTodosLosMenus();

          
            if (Session["usuario"] != null)
            {
                Usuario user = (Usuario)Session["usuario"];
                string rol = Session["Rol"]?.ToString();
                lblUsuarioLogueado.Text = user.Nombre + " (" + rol + ")";

                menuLogin.Visible = false;

                if (rol == "Gerente")
                {
                    MostrarMenusGerente();
                }
                else if (rol == "Mesero")
                {

                    List<string> paginasProhibidas = new List<string> {
                   "UsuarioForm.aspx", "UsuarioLista.aspx", "InsumoForm.aspx",
                   "Reportes.aspx", "InsumosLista.aspx", "TipoInsumoForm.aspx",
                   "MesaForm.aspx", "MesasLista.aspx","TiposInsumoLista.aspx","MesasAsignacion.aspx","Default.aspx"
                  };

                    if (paginasProhibidas.Any(p => paginaActual.Equals(p, StringComparison.OrdinalIgnoreCase)))
                    {
                        Response.Redirect("MesasPedidos.aspx");
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
         
        }

        private void MostrarMenusMesero()
        {
           
            menuAsignacion.Visible = false;
            menuMesasPedidos.Visible = true; 
        
        }

        protected void lnkCerrarSesion_Click(object sender, EventArgs e)
        {

            Session.Clear();
            Session.Abandon();


            Response.Redirect("Login.aspx");
        }



    }
}































    
















    

    

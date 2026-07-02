using dominio;
using negocio;
using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace resto_bar_web
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }


        protected void btnIngresar_Click(object sender, EventArgs e)
        {
            try
            {
                UsuarioNegocio negocio = new UsuarioNegocio();
                Usuario usuario = negocio.login(txtUsuario.Text, txtClave.Text);

                if (usuario != null)
                {
                    Session["usuario"] = usuario;
                    Session["IdUsuario"] = usuario.Id;
                    Session["Rol"] = usuario.Rol.Nombre;

                    if (usuario.Rol.Nombre == "Gerente")
                    {
                        Response.Redirect("~/InsumosLista.aspx");
                    }
                    else
                    {
                        Response.Redirect("~/MesasPedidos.aspx");
                    }
                }
                else
                {
                    string script = "setTimeout(function() { " +
                    "   var txtMensaje = document.getElementById('confirmacionModalMensaje'); " +
                    "   var txtTitulo = document.getElementById('confirmacionModalTitulo'); " +
                    "   if(txtMensaje) txtMensaje.textContent = 'Usuario, contraseña incorrectos o cuenta inactiva.'; " +
                    "   if(txtTitulo) txtTitulo.textContent = 'Error de Ingreso'; " +
                    "   var modalElemento = document.getElementById('confirmacionModal'); " +
                    "   if(modalElemento) { " +
                    "       var miModal = bootstrap.Modal.getOrCreateInstance(modalElemento); " +
                    "       miModal.show(); " +
                    "   } " +
                    "}, 100);"; 

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "PopErrorModal", script, true);
                }
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());


                string mensajeError = "Ocurrió un error en el sistema: " + ex.Message.Replace("'", "\\'").Replace("\r", "").Replace("\n", "");


                string scriptCatch = "setTimeout(function() { " +
                                     "   var txtMensaje = document.getElementById('confirmacionModalMensaje'); " +
                                     "   var txtTitulo = document.getElementById('confirmacionModalTitulo'); " +
                                     "   if(txtMensaje) txtMensaje.textContent = '" + mensajeError + "'; " +
                                     "   if(txtTitulo) txtTitulo.textContent = 'Error del Sistema'; " +
                                     "   var modalElemento = document.getElementById('confirmacionModal'); " +
                                     "   if(modalElemento) { " +
                                     "       var miModal = bootstrap.Modal.getOrCreateInstance(modalElemento); " +
                                     "       miModal.show(); " +
                                     "   } " +
                                     "}, 100);";

                ScriptManager.RegisterStartupScript(this, this.GetType(), "PopErrorCatch", scriptCatch, true);
            }
        }

    }
}

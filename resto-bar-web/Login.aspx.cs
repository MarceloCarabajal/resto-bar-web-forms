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
                        Response.Redirect("~/Default.aspx", false);
                    }
                    else
                    {
                        Response.Redirect("~/MesasPedidos.aspx", false);
                    }
                }
                else
                {

                    txtUsuario.Text = "";
                    txtClave.Text = "";

                    string script = @"
        var modalElemento = document.getElementById('confirmacionModal');
        var modal = new bootstrap.Modal(modalElemento);
        document.getElementById('confirmacionModalMensaje').textContent = 'Usuario o contraseña incorrectos.';
        document.getElementById('confirmacionModalTitulo').textContent = 'Error de Ingreso';
        
        var btnAceptar = document.getElementById('btnConfirmarAccion');
        btnAceptar.onclick = function() { 
            modal.hide(); 
        };
        var btnCancelar = modalElemento.querySelector('.btn-secondary');
        if(btnCancelar) { btnCancelar.onclick = function() { modal.hide(); }; }
        var btnCerrarX = modalElemento.querySelector('.btn-close');
        if(btnCerrarX) { btnCerrarX.onclick = function() { modal.hide(); }; }
        
        modal.show();";

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowError", script, true);

                    return;
                }
            }
            catch (Exception ex)
            {
                txtUsuario.Text = "";
                txtClave.Text = "";
                string script = "var miModal = new bootstrap.Modal(document.getElementById('confirmacionModal')); miModal.show();";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "PopErrorCatch", script, true);
            }
        }


    }
}

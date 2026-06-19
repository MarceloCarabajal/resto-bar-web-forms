using dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace resto_bar_web
{
    public partial class MasterPage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario"] != null)
            {
               
                Usuario user = (Usuario)Session["usuario"];

                if (user.Rol.Nombre == "Gerente")
                {
                    menuUsuarios.Visible = true;
                }
            }

        }
    }
}
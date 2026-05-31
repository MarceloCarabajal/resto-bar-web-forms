using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace resto_bar_web
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {

                    negocio.InsumoNegocio negocioInsumo = new negocio.InsumoNegocio();


                    dgvInsumos.DataSource = negocioInsumo.listar();


                    dgvInsumos.DataBind();
                }
                catch (Exception ex)
                {

                    Session.Add("error", ex.ToString());
                }
            }

        }
    }
}
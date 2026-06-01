using System;
using System.Web.UI;

namespace resto_bar_web
{
    public partial class InsumosLista : Page
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
                    Session["error"] = ex.ToString();
                }
            }
        }
    }
}

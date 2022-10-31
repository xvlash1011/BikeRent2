using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ShopsDefault.UserControls.Products
{
    public partial class cartold : System.Web.UI.UserControl
    {
        public List<ShopsCartItem> ShopsCart
        {
            get
            {
                return Session["cart_items"] as List<ShopsCartItem>;
            }
            set
            {
                Session["cart_items"] = value;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            DataTable cart = Session["cart_items"] as DataTable;
            if (!IsPostBack)
            {
                GridView1.DataSource = cart;
                GridView1.DataBind();
            }
        }


        protected void GridView1_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {
            //Edit Cart
            string id = GridView1.DataKeys[e.NewSelectedIndex].Value.ToString();
            TextBox quantity = GridView1.Rows[e.NewSelectedIndex].Cells[2].FindControl("txtQuantity")
                as TextBox;
            //Duyệt qua Cart và tăng Quantity
            DataTable cart = Session["cart_items"] as DataTable;
            foreach (DataRow dr in cart.Rows)
            {
                //Kiểm tra mã Products phù hợp để gán Quantity khách hàng mua
                if (dr["ID_Product"].ToString() == id)
                {
                    dr["Amount"] = int.Parse(quantity.Text);
                    break;
                }
            }
            //Save lại vào Session
            Session["cart"] = cart;
            //Hiển thị Cart với thông tin mới
            GridView1.DataSource = cart;
            GridView1.DataBind();
        }
        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            //Delete Products khỏi Cart
            string id = GridView1.DataKeys[e.RowIndex].Value.ToString();
            //Duyệt qua Cart và Delete Products phù hợp
            DataTable cart = Session["cart_items"] as DataTable;
            foreach (DataRow dr in cart.Rows)
            {
                //Kiểm tra mã Products phù hợp để tăng Quantity
                if (dr["Amount"].ToString() == id)
                {
                    dr.Delete();
                    break;
                }
            }
            //Save lại vào Session
            Session["cart"] = cart;
            //Hiển thị Cart với thông tin mới
            GridView1.DataSource = cart;
            GridView1.DataBind();
        }
    }
}
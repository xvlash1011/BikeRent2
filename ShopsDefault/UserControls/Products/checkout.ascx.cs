using Librari;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ShopsDefault.UserControls.Products
{
    public partial class checkout : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DataTable dt = Session["cart_items"] as DataTable;

            if (dt == null || dt.Compute("Sum(Total)", "") == null || dt.Compute("Sum(Total)", "").ToString() == "")
            {
                Response.Redirect("/cart.html");
            }
        }

        protected void ds_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            string sql = "SELECT * FROM tbShopsPayments where Hidden = 1";
            e.InputParameters["sSQL"] = sql;
        }

        protected void dsCart_OnLoad(object sender, EventArgs e)
        {
            DataTable cart = Session["cart_items"] as DataTable;
            Repeater3.DataSource = cart;
            Repeater3.DataBind();
        }

        protected string getTotal()
        {
            int count = 0;
            object total;
            DataTable dt = (DataTable)Session["cart_items"];
            if (dt != null)
            {
                total = dt.Compute("Sum(Total)", "");
                if (total == null || total.ToString() == "")
                {
                    count = 0;
                }
                else
                {
                    count = Convert.ToInt32(total.ToString());
                }

            }
            else
            {
                count = 0;
            }
            return count.ToString();
        }

        public static string GenCodeOrder()
        {
            try
            {
                object ob = Cls_ShopsOrdersDetail.getMaxIdAuto();
                if (ob == DBNull.Value)
                    return "0000001";
                else
                    return (Convert.ToInt32(ob)).ToString("0000000");
            }
            catch (Exception ex) { throw ex; }
        }

        private void SendMailInfor(string MailTo)
        {
            string Code = GenCodeOrder();
            DataTable cart = Session["cart_items"] as DataTable;
            double Total = Convert.ToDouble(getTotal());
            string domain = Request.Url.GetLeftPart(UriPartial.Authority);
            string paymentMethod = "Thanh toán tại cửa hàng";
            string str = "<div style='font-size: 14px;'>" +
                "<div>" +
                    "<div>" +
                        "<div>" +
                            "<p>Hi, <b>" + txtFullName.Text + "</b></p>" +
                            "<p>Below is the details of your order</b> .</p>" +
                            "<ul>" +
                                "<li>" +
                                    "<strong>Order number :</strong>" +
                                    "<span> " + Code + "</span>" +
                                "</li>" +
                                "<li>" +
                                    "<strong>Order status :</strong>" +
                                    "<span> Order received </span>" +
                                "</li>" +
                                "<li>" +
                                    "<strong>Order placed at :</strong>" +
                                    "<span> " + DateTime.Now.ToString("dd/MM/yyyy hh:mm") + "</span>" +
                                "</li>" +
                                "<li>" +
                                    "<strong>Payment Method :</strong>" +
                                    "<span> " + paymentMethod + "</span>" +
                                "</li>" +
                            "</ul>" +
                            "<table>" +
                                "<tr style='font-weight: 600;'>" +
                                    "<td style='width: 200px'>Product</td>" +
                                    "<td style='width: 100px; text-align: center'>Quantity</td>" +
                                    "<td style='width: 100px; text-align: center'>Price</td>" +
                                    "<td style='width: 100px; text-align: center'>Total</td>" +
                                "</tr>";
                                foreach (DataRow drCart in cart.Rows)
                                {
                                    str += "<tr class='prd_row'>" +
                                               "<td>" +
                                                   "<a href='#' target='_blank'>" + drCart["ProductName"].ToString() + "</a></td>" +
                                               "<td style='text-align: center'><b>" + drCart["Quantity"].ToString() + "</b></td>" +
                                               "<td style='text-align: center'>" + Convert.ToDouble(drCart["PriceOut"]).ToString("#,0") + " đ</td>" +
                                               "<td style='text-align: center'><b>" + (Convert.ToDouble(drCart["PriceOut"]) * Convert.ToInt32(drCart["Quantity"].ToString())).ToString("#,0") + " ₫</b></td>" +
                                           "</tr>";
                                }
                                str += "<tr>" +
                                   "<td colspan='3' style='padding-top: 5px;padding-bottom: 5px;'>Order total <br /><b>(Delivery fee is not included)</b>" +
                                   "</td>" +
                                   "<td style='padding-top: 5px;padding-bottom: 5px;text-align: center;font-size: 18px;'>" +
                                       "<b style='color: #f53030'>" + Total.ToString("#,0") + " ₫</b>" +
                                   "</td>" +
                               "</tr>" +
                           "</table>" +
                       "</div>" +
                    "</div>" +
                    "<div style='line-height: 24px;' class='_footer_ckout fr_col12'>" +
                       "<b>Thank you for placing your order at " +
                       "<a href='" + domain + "/ez-bikes.html' target='_blank'>EZ Bikes</a>!</b>" +
                    "</div>" +

                    "<div style='line-height: 24px;'>" +
                       "Please contact <b>028.7300.2266</b> for support" +
                    "</div>" +
                    "</div>" +
                    "</div>";


            System.Net.NetworkCredential login_cred = new System.Net.NetworkCredential("dnvknguyen@gmail.com", "dcgnjescmakdsvta");
            System.Net.Mail.MailMessage mail = new System.Net.Mail.MailMessage();
            mail.From = new System.Net.Mail.MailAddress("dnvknguyen@gmail.com");
            mail.To.Add(new System.Net.Mail.MailAddress(MailTo));
            mail.CC.Add(new System.Net.Mail.MailAddress("dnvknguyen@gmail.com"));
            mail.BodyEncoding = System.Text.Encoding.UTF8;
            mail.Subject = "Your bike rental order!";
            mail.Body = str;
            mail.IsBodyHtml = true;
            System.Net.Mail.SmtpClient client = new System.Net.Mail.SmtpClient("smtp.gmail.com", 587);
            client.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;
            client.EnableSsl = true;
            client.UseDefaultCredentials = false;
            client.Credentials = login_cred;
            client.Send(mail);


        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            DataTable dtCart = (DataTable)Session["cart_items"];
            SqlConnection conn = new AccessDB().get_Conn();
            conn.Open();
            SqlTransaction trans = conn.BeginTransaction();
            SqlCommand sqlComm;
            try
            {
                sqlComm = new SqlCommand("st_tbShopsOrdersDetail_Insert", conn, trans);
                sqlComm.CommandType = CommandType.StoredProcedure;

                sqlComm.Parameters.Add("@ID_Payment", SqlDbType.Int).Value = Convert.ToInt32(hdID_Payment.Value);
                sqlComm.Parameters.Add("@ID_User", SqlDbType.Int).Value = 2;
                sqlComm.Parameters.Add("@OrdersName", SqlDbType.NVarChar).Value = txtFullName.Text;
                sqlComm.Parameters.Add("@UserName", SqlDbType.NVarChar).Value = "";
                sqlComm.Parameters.Add("@UserEmail", SqlDbType.NVarChar).Value = txtEmail.Text;
                sqlComm.Parameters.Add("@UserAddress", SqlDbType.NVarChar).Value = txtAddress.Text;
                sqlComm.Parameters.Add("@UserPhone", SqlDbType.NVarChar).Value = txtPhoneNumber.Text;
                sqlComm.Parameters.Add("@Status", SqlDbType.NVarChar).Value = "Not yet";
                sqlComm.Parameters.Add("@DayIn", SqlDbType.DateTime).Value = DateTime.ParseExact(txtDayOff.Text, "dd/MM/yyyy", null);
                sqlComm.Parameters.Add("@DayOut", SqlDbType.DateTime).Value = DateTime.ParseExact(txtDatePick.Text, "dd/MM/yyyy", null);
                sqlComm.Parameters.Add("@Description", SqlDbType.NText).Value = txtDescription.Text;
                sqlComm.Parameters.Add("@AddTime", SqlDbType.DateTime).Value = DateTime.Now;
                sqlComm.Parameters.Add("@EditTime", SqlDbType.DateTime).Value = DateTime.Now;
                sqlComm.Parameters.Add("@Hidden", SqlDbType.Bit).Value = true;

                sqlComm.ExecuteNonQuery();


                if (Session["cart_items"] != null)
                {
                    if (dtCart.Rows.Count > 0)
                    {
                        sqlComm = new SqlCommand("select top 1 * from tbShopsOrdersDetail order by ID_OrderProduct desc", conn, trans);
                        sqlComm.CommandType = CommandType.Text;
                        SqlDataReader dr = sqlComm.ExecuteReader();
                        DataTable dt = new DataTable();
                        dt.Load(dr);
                        foreach (DataRow drCart in dtCart.Rows)
                        {
                            sqlComm = new SqlCommand("st_tbShopsOrders_Insert", conn, trans);
                            sqlComm.CommandType = CommandType.StoredProcedure;
                            sqlComm.Parameters.Add("@ID_OrderProduct", SqlDbType.Int).Value = dt.Rows[0]["ID_OrderProduct"].ToString();
                            Session["OrderCode"] = dt.Rows[0]["ID_OrderProduct"].ToString();
                            sqlComm.Parameters.Add("@ID_Product", SqlDbType.Int).Value = Convert.ToInt32(drCart["ID_Product"].ToString());
                            sqlComm.Parameters.Add("@Amount", SqlDbType.Int).Value = Convert.ToInt32(drCart["Quantity"].ToString());
                            sqlComm.Parameters.Add("@PriceTotal", SqlDbType.Float).Value = Convert.ToDouble(drCart["Total"].ToString());
                            sqlComm.Parameters.Add("@AddTime", SqlDbType.DateTime).Value = DateTime.Now;
                            sqlComm.Parameters.Add("@EditTime", SqlDbType.DateTime).Value = DateTime.Now;
                            sqlComm.Parameters.Add("@Hidden", SqlDbType.Bit).Value = true;

                            sqlComm.ExecuteNonQuery();


                            //sqlComm = new SqlCommand("st_tbShopsProducts_UpdateQuantity", conn, trans);
                            //sqlComm.CommandType = CommandType.StoredProcedure;
                            //sqlComm.Parameters.Add("@ID_Product_find", SqlDbType.Int).Value = Convert.ToInt32(drCart["ID_Product"].ToString());
                            //sqlComm.Parameters.Add("@Amount", SqlDbType.Int).Value = Convert.ToInt32(drCart["Quantity"].ToString());
                            //sqlComm.ExecuteNonQuery();

                        }
                    }
                }
                trans.Commit();
                SendMailInfor(txtEmail.Text);
                string sMessages = "alert('Order has been placed! Please check your email inbox for details!');";
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "", sMessages, true);
                Session["cart_items"] = null;
            }
            catch (SqlException ex)
            {
                trans.Rollback();

            }
            finally
            {
                conn.Close();
            }
        }


        //protected void btnCheckout_Click(object sender, EventArgs e)
        //{
        //    Cls_ShopsOrdersDetail cls = new Cls_ShopsOrdersDetail();
        //    cls.ID_Payment = Convert.ToInt32(hdID_Payment.Value);
        //    cls.ID_User = 2;
        //    cls.UserName = "";
        //    cls.OrdersName = txtFullName.Text;
        //    cls.UserEmail = txtEmail.Text;
        //    cls.UserAddress = txtAddress.Text;
        //    cls.UserPhone = txtPhoneNumber.Text;
        //    cls.PriceTotal = Convert.ToDouble(getTotal());
        //    cls.Description = txtDescription.Text;
        //    cls.AddTime = Convert.ToDateTime(txtDatePick.Text);
        //    cls.EditTime = Convert.ToDateTime(txtDayOff.Text);
        //    cls.Hidden = true;
        //    if (cls.doInsert() == 1)
        //    {
        //        SendMailInfor(txtEmail.Text);
        //        string sMessages = "alert('Order has been placed! Please check your email inbox for details!');";
        //        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "", sMessages, true);
        //        Session["cart_items"] = null;
        //        //Response.Redirect("/ez-bikes.html");
        //    }
        //    else
        //    {
        //        string sMessages = "alert('An error has occured, your order has not been placed!');";
        //        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "", sMessages, true);
        //    }
        //}
    }
}
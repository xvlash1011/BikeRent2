using Librari;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ShopsDefault.UserControls.Contact
{
    public partial class main : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void resetForm()
        {
            txtContactName.Text = "";
            txtFullName.Text = "";
            txtEmail.Text = "";
            txtPhone.Text = "";
            txtDetail.Text = "";
        }

        private void SendMailInfor()
        {
            System.Net.NetworkCredential login_cred = new System.Net.NetworkCredential("dnvknguyen@gmail.com", "dcgnjescmakdsvta");
            System.Net.Mail.MailMessage mail = new System.Net.Mail.MailMessage();
            mail.From = new System.Net.Mail.MailAddress("dnvknguyen@gmail.com");
            mail.To.Add(new System.Net.Mail.MailAddress(txtEmail.Text));
            mail.CC.Add(new System.Net.Mail.MailAddress("dnvknguyen@gmail.com"));
            mail.BodyEncoding = System.Text.Encoding.UTF8;
            mail.Subject = "Information Received";
            mail.Body = "<b>Your message: </b>" + txtDetail.Text;
            mail.IsBodyHtml = true;
            System.Net.Mail.SmtpClient client = new System.Net.Mail.SmtpClient("smtp.gmail.com", 587);
            client.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;
            client.EnableSsl = true;
            client.UseDefaultCredentials = false;
            client.Credentials = login_cred;
            client.Send(mail);


        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Cls_Contact cls = new Cls_Contact();

            cls.ContactName = txtContactName.Text.Trim();
            cls.FullName = txtFullName.Text.Trim();
            cls.Email = txtEmail.Text.Trim();
            cls.Phone = txtPhone.Text.Trim();
            cls.Description = txtDetail.Text.Trim();
            cls.AddTime = DateTime.Now;
            cls.EditTime = DateTime.Now;
            cls.Hidden = true;
            if (cls.doInsert() == 1)
            {
                string sMessages = "alert('Your information has been received!');";
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "", sMessages, true);
                SendMailInfor();
                resetForm();
            }
            else
            {
                string sMessages = "alert('An error has occurred, we have not received your information!');";
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "", sMessages, true);
            }
        }
    }
}
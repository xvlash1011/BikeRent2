﻿using Librari;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ShopsDefault.AdminTools.UserControls.Products.Products
{
    public partial class payment : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.BindData();
            }
        }

        private void BindData()
        {
            grv.DataSource = Cls_ShopsPayments.getDataTable_My();
            grv.DataBind();
        }

        protected void grv_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.TableSection = TableRowSection.TableHeader;
            }
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string getName = e.Row.Cells[1].Text;
                LinkButton lnk = (LinkButton)e.Row.FindControl("lnkDelete");
                lnk.Attributes.Add("onclick", "return confirm('Delete " + getName + "?')");
            }
        }

        protected void grv_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grv.PageIndex = e.NewPageIndex;
            BindData();
        }

        protected void RefreshText()
        {
            txtPaymentName.Text = "";
            txtDetail.Text = "";
            cbHidden.Checked = false;
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            btnSave.Text = "Save";
            RefreshText();
            popup.Show();
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            btnSave.Text = "Update";
            GridViewRow row = (GridViewRow)((LinkButton)sender).Parent.Parent;
            var ID_find = Convert.ToInt32(row.Cells[0].Text);
            Cls_ShopsPayments cls = Cls_ShopsPayments.getOject_Key(ID_find);
            txtID_Payment.Text = ID_find.ToString();
            txtPaymentName.Text = cls.PaymentName.ToString();
            txtDetail.Text = cls.Description.ToString();
            Console.WriteLine(cls.Hidden.ToString());
            if (cls.Hidden == true)
            {
                cbHidden.Checked = true;
            }
            else
            {
                cbHidden.Checked = false;
            }

            popup.Show();
        }

        protected void grv_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int ID = Convert.ToInt32(grv.DataKeys[e.RowIndex].Values[0]);
            Cls_ShopsPayments cls = new Cls_ShopsPayments();
            cls.ID_Payment_find = ID;

            if (cls.doDelete() == 1)
            {
                string sMessages = "alert('Deleted');";
                ScriptManager.RegisterStartupScript(UpdatePanel1, UpdatePanel1.GetType(), "", sMessages, true);
            }
            else
            {
                string sMessages = "alert('An error has occurred!');";
                ScriptManager.RegisterStartupScript(UpdatePanel1, UpdatePanel1.GetType(), "", sMessages, true);
            }
            BindData();
        }


        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (btnSave.Text == "Save")
            {
                Cls_ShopsPayments cls = new Cls_ShopsPayments();
                cls.PaymentName = txtPaymentName.Text.Trim();
                cls.Description = txtDetail.Text.Trim();
                cls.AddTime = DateTime.Now;
                cls.EditTime = DateTime.Now;

                if (cbHidden.Checked)
                {
                    cls.Hidden = true;
                }
                else
                {
                    cls.Hidden = false;
                }
                if (cls.doInsert() == 1)
                {
                    string sMessages = "alert('Successfully added!');";
                    ScriptManager.RegisterStartupScript(UpdatePanel1, UpdatePanel1.GetType(), "", sMessages, true);
                }
                else
                {
                    string sMessages = "alert('An error has occurred!');";
                    ScriptManager.RegisterStartupScript(UpdatePanel1, UpdatePanel1.GetType(), "", sMessages, true);
                }
            }
            else if (btnSave.Text == "Update")
            {
                Cls_ShopsPayments cls = new Cls_ShopsPayments();
                cls.ID_Payment_find = Convert.ToInt32(txtID_Payment.Text.Trim());
                cls.PaymentName = txtPaymentName.Text.Trim();
                cls.Description = txtDetail.Text.Trim();
                cls.EditTime = DateTime.Now;

                if (cbHidden.Checked)
                {
                    cls.Hidden = true;
                }
                else
                {
                    cls.Hidden = false;
                }
                if (cls.doUpdate() == 1)
                {
                    string sMessages = "alert('Successfully edited!');";
                    ScriptManager.RegisterStartupScript(UpdatePanel1, UpdatePanel1.GetType(), "", sMessages, true);
                }
                else
                {
                    string sMessages = "alert('An error has occurred!');";
                    ScriptManager.RegisterStartupScript(UpdatePanel1, UpdatePanel1.GetType(), "", sMessages, true);
                }
            }
            BindData();
        }
    }
}
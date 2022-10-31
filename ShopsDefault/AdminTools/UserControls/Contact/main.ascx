<%@ Control Language="C#" AutoEventWireup="true"  CodeBehind="main.ascx.cs" Inherits="ShopsDefault.AdminTools.UserControls.Contact.main" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

<ul class="breadcrumb">
    <li><a href="/AdminTools/Dashboard.html">Dashboard</a></li>
    <li>Articles Category</li>
</ul>
<div class="container-fluid">
    <div class="block-default">
        <div class="block-header">
            <i class="icon-bubble"></i>Messages from customers
        </div>
        <div class="block-body">
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="grv" runat="server" AutoGenerateColumns="False" AllowPaging="True" DataKeyNames="ID_Contact" OnRowDeleting="grv_RowDeleting" OnRowDataBound="grv_OnRowDataBound" OnPageIndexChanging="grv_PageIndexChanging" CssClass="table table-default">
                        <PagerStyle CssClass="pagination" />
                        <Columns>
                            <asp:BoundField DataField="ID_Contact" HeaderText="ID" HtmlEncode="true" />
                            <asp:BoundField DataField="ContactName" HeaderText="Title" HtmlEncode="true" />
                            <asp:BoundField DataField="FullName" HeaderText="Name" HtmlEncode="true" />
                            <asp:BoundField DataField="Phone" HeaderText="Phone number" HtmlEncode="true" />
                            <asp:BoundField DataField="Email" HeaderText="Email Address" HtmlEncode="true" />
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkEdit" runat="server" OnClick="btnEdit_Click" CssClass="btn btn-info"><i class="icon-pencil"></i> Details</asp:LinkButton>
                                    <asp:LinkButton ID="lnkDelete" runat="server" CausesValidation="false" CommandName="Delete" CssClass="btn btn-danger"><i class="icon-trash"></i> Delete</asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>

                    <asp:Panel ID="pnlAddEdit" runat="server" CssClass="modalPopup" Style="display: none">
                        <div class="popup-body">
                            <div class="card">
                                <div class="card-header">
                                    <i class="icon-note"></i>Details Contact Us
                                </div>
                                <div class="card-body scrollbar-y-custom">
                                    <div class="row">
                                        <div class="col-6">
                                            <div class="form-group">
                                                <label for="company">Title</label>
                                                <asp:TextBox ID="txtContactName" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                            </div>
                                            <div class="form-group">
                                                <label for="company">Name</label>
                                                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-6">
                                            <div class="form-group">
                                                <label for="country">Phone number</label>
                                                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                            </div>
                                            <div class="form-group">
                                                <label for="country">Email Address</label>
                                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="country">Details</label>
                                        <CKEditor:CKEditorControl ID="txtDetail" Language="Vi" BasePath="~/ckeditor" runat="server"></CKEditor:CKEditorControl>
                                    </div>
                                    <div class="form-actions">
                                        <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-secondary">Close</asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                    <asp:LinkButton ID="lnkFake" runat="server"></asp:LinkButton>
                    <cc1:ModalPopupExtender ID="popup" runat="server" DropShadow="false"
                        PopupControlID="pnlAddEdit" TargetControlID="lnkFake"
                        BackgroundCssClass="modalBackground">
                    </cc1:ModalPopupExtender>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="grv" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</div>

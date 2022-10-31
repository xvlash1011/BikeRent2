<%@ Control Language="C#" AutoEventWireup="true"  CodeBehind="main.ascx.cs" Inherits="ShopsDefault.AdminTools.UserControls.Products.Products.main" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

<script type="text/javascript" language="javascript">
    function FcOut() {
        $('#<%= txtProductName.ClientID %>').focusout(function () {
            var str = $('#<%= txtProductName.ClientID %>').val();
            $('#<%= txtTitleWeb.ClientID %>').val(str);
            $('#<%= txtLinkSEO.ClientID %>').val(locdau(str));
        });
    }
    function getLinkImage() {
        $('#<%= fuImage.ClientID %>').change(function () {
            var file = $('#<%= fuImage.ClientID %>')[0].files[0]
            $('#<%= txtImage.ClientID %>').val('/images/UploadImages/product/' + file.name);
        });
    }

    $(document).ready(function () {
        FcOut();
        getLinkImage();
    });
</script>

<style>
    select.form-control option:nth-child(2) {
        display: none;
    }
</style>

<ul class="breadcrumb">
    <li><a href="/AdminTools/Dashboard.html">Dashboard</a></li>
    <li>Products</li>
</ul>


<div class="container-fluid">
    <div class="block-default">
        <div class="block-header">
            <i class="icon-bag"></i>Products
        </div>
        <div class="block-body">
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="btn-groups">
                        <asp:LinkButton ID="btnAdd" runat="server" OnClick="btnAdd_Click" CssClass="btn btn-success add-new"><i class="icon-plus"></i> Add</asp:LinkButton>
                    </div>
                    <asp:GridView ID="grv" runat="server" AutoGenerateColumns="False" AllowPaging="True" OnRowDataBound="grv_OnRowDataBound" DataKeyNames="ID_Product" OnRowDeleting="grv_RowDeleting" OnPageIndexChanging="grv_PageIndexChanging" CssClass="table table-default">
                        <PagerStyle CssClass="pagination" />
                        <Columns>
                            <asp:BoundField DataField="ID_Product" HeaderText="ID" HtmlEncode="true" />
                            <asp:BoundField DataField="ProductName" HeaderText="Name" HtmlEncode="true" />
                            <asp:BoundField DataField="CatalogName" HeaderText="Category" HtmlEncode="true" />
                            <asp:BoundField DataField="ProductCode" HeaderText="Code" HtmlEncode="true" />
                            <asp:BoundField DataField="PriceOut" HeaderText="Price" HtmlEncode="true" />
                            <asp:BoundField DataField="Color" HeaderText="Color" HtmlEncode="true" />
                            <asp:BoundField DataField="Amount" HeaderText="Quantity" HtmlEncode="true" />
                            <asp:BoundField DataField="Weight" HeaderText="Speed" HtmlEncode="true" />
                            <asp:TemplateField HeaderText="Status" SortExpression="Hidden">
                                <ItemTemplate><%# (Boolean.Parse(Eval("Hidden").ToString())) ? "Active" : "Not Active" %></ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkEdit" runat="server" OnClick="btnEdit_Click" CssClass="btn btn-info"><i class="icon-pencil"></i> Edit</asp:LinkButton>
                                    <asp:LinkButton ID="lnkDelete" runat="server" CausesValidation="false" CommandName="Delete" CssClass="btn btn-danger"><i class="icon-trash"></i> Delete </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>

                    <asp:Panel ID="pnlAddEdit" runat="server" CssClass="modalPopup" Style="display: none">
                        <script type="text/javascript" language="javascript">
                            var prm = Sys.WebForms.PageRequestManager.getInstance();

                            prm.add_endRequest(function () {
                                FcOut();
                                getLinkImage();
                            });
                        </script>
                        <div class="popup-body">
                            <div class="card">
                                <div class="card-header">
                                    <i class="icon-note"></i>Add product
                                </div>
                                <div class="card-body scrollbar-y-custom">
                                    <div class="form-group d-none">
                                        <label for="company">ID Products</label>
                                        <asp:TextBox ID="txtID_Product" runat="server" placeholder="ID Products" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                    </div>
                                    <div class="row">
                                        <div class="col-6">
                                            <div class="form-group">
                                                <label for="company">Products Category</label>
                                                <asp:SqlDataSource ID="ds" runat="server" EnableCaching="false"></asp:SqlDataSource>
                                                <asp:DropDownList ID="txtID_Catalog" runat="server" DataSourceID="ds" DataTextField="CatalogName" DataValueField="ID_Catalog" AppendDataBoundItems="true" CssClass="form-control">
                                                    <asp:ListItem Text="Choose Category" Value="0" Selected="true" />
                                                </asp:DropDownList>
                                            </div>
                                            <div class="form-group">
                                                <label for="company">Product</label>
                                                <asp:TextBox ID="txtProductName" runat="server" placeholder="Name" CssClass="form-control"></asp:TextBox>
                                            </div>
                                            <div class="form-group">
                                                <label for="company">Code</label>
                                                <asp:TextBox ID="txtProductCode" runat="server" placeholder="Code" CssClass="form-control"></asp:TextBox>
                                            </div>
                                            <div class="form-group">
                                                <label for="company">Price</label>
                                                <asp:TextBox ID="txtPriceOut" runat="server" placeholder="Price" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-6">                                            
                                            <div class="form-group">
                                                <label for="company">Quantity</label>
                                                <asp:TextBox ID="txtAmount" runat="server" placeholder="Quantity" CssClass="form-control"></asp:TextBox>
                                            </div>
                                            <div class="form-group">
                                                <label for="company">Color</label>
                                                <asp:TextBox ID="txtColor" runat="server" placeholder="Color" CssClass="form-control"></asp:TextBox>
                                            </div>
                                            <div class="form-group">
                                                <label for="company">Speed</label>
                                                <asp:TextBox ID="txtWeight" runat="server" placeholder="Speed" CssClass="form-control"></asp:TextBox>
                                            </div>
                                            <div class="form-group">
                                                <label for="company">Summary</label>
                                                <asp:TextBox ID="txtSummaryContent" runat="server" placeholder="Description" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="company">Images</label>
                                        <div class="position-relative">
                                            <asp:TextBox ID="txtImage" runat="server" placeholder=" Image URL" CssClass="form-control"></asp:TextBox>
                                            <asp:FileUpload ID="fuImage" runat="server" CssClass="form-control btn-fu" accept=".png,.jpg,.jpeg,.gif" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="street">Details</label>
                                        <div class="form-control custom-editor">
                                            <CKEditor:CKEditorControl ID="txtDetail" Language="Vi" BasePath="~/ckeditor" runat="server"></CKEditor:CKEditorControl>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="ContentMain_ctl00_cbHidden">Active</label>
                                        <asp:CheckBox ID="cbHidden" runat="server" Style="margin-left: 8px;"></asp:CheckBox>
                                    </div>
                                    <div class="form-group">
                                        <label for="company">Title</label>
                                        <asp:TextBox ID="txtTitleWeb" runat="server" placeholder=" Title" CssClass="form-control"></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label for="country">URL</label>
                                        <asp:TextBox ID="txtLinkSEO" runat="server" placeholder=" URL" CssClass="form-control"></asp:TextBox>
                                    </div>

                                    <div class="form-actions">
                                        <asp:LinkButton ID="btnSave" runat="server" OnClick="btnSave_Click" CssClass="btn btn-primary">Save</asp:LinkButton>
                                        <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-secondary">Cancel</asp:LinkButton>
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
                    <asp:AsyncPostBackTrigger ControlID="btnSave" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</div>

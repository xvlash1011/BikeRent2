<%@ Control Language="C#" AutoEventWireup="true"  CodeBehind="order.ascx.cs" Inherits="ShopsDefault.AdminTools.UserControls.Products.Products.order" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

<ul class="breadcrumb">
    <li><a href="/AdminTools/Dashboard.html">Dashboard</a></li>
    <li>Đơn hàng</li>
</ul>


<div class="container-fluid">
    <div class="block-default">
        <div class="block-header">
            <i class="icon-note"></i>Orders
        </div>
        <div class="block-body">
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="grv" runat="server" AutoGenerateColumns="False" AllowPaging="True" OnRowDataBound="grv_OnRowDataBound" DataKeyNames="ID_OrderProduct" OnRowUpdating="grv_RowUpdating" OnPageIndexChanging="grv_PageIndexChanging" CssClass="table table-default">
                        <PagerStyle CssClass="pagination" />
                        <Columns>
                            <asp:BoundField DataField="ID_OrderProduct" HeaderText="ID" HtmlEncode="true" />
                            <asp:BoundField DataField="OrdersName" HeaderText="Name" HtmlEncode="true" />
                            <asp:BoundField DataField="Status" HeaderText="Status" HtmlEncode="true" />
                            <asp:BoundField DataField="UserPhone" HeaderText="Phone number" HtmlEncode="true" />
                            <asp:BoundField DataField="PaymentName" HeaderText="Tên HTTT" HtmlEncode="true" />
                            <asp:BoundField DataField="DayOut" HeaderText="Ngày đặt" HtmlEncode="true" />
                            <asp:BoundField DataField="DayIn" HeaderText="Return date" HtmlEncode="true" />
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkEdit" runat="server" OnClick="btnEdit_Click" CssClass="btn btn-info"><i class="icon-pencil"></i> Details</asp:LinkButton>
                                    <asp:LinkButton ID="lnkUpdate" runat="server" CausesValidation="false" CommandName="Update" CssClass="btn btn-danger"><i class="icon-ban"></i> Cancel đơn</asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>

                    <asp:Panel ID="pnlAddEdit" runat="server" CssClass="modalPopup" Style="display: none">
                        <div class="popup-body">
                            <div class="card">
                                <div class="card-header">
                                    <i class="icon-note"></i>Order details
                                </div>
                                <div class="card-body scrollbar-y-custom">
                                    <div class="form-group d-none">
                                        <label for="company">Order ID</label>
                                        <asp:TextBox ID="txtID_OrderProduct" runat="server" ReadOnly="true" CssClass="form-control"></asp:TextBox>
                                    </div>
                                    <ul class="nav nav-tabs" role="tablist">
                                        <li class="nav-item">
                                            <a class="nav-link active" data-toggle="tab" href="#customer-info">Customer information</a>
                                        </li>

                                        <li class="nav-item">
                                            <a class="nav-link" data-toggle="tab" href="#order-details">Order details</a>
                                        </li>
                                    </ul>
                                    <div class="tab-content">
                                        <div id="customer-info" class="tab-pane active">
                                            <div class="row">
                                                <div class="col-4">
                                                    <div class="form-group">
                                                        <label for="company">Name</label>
                                                        <asp:TextBox ID="txtOrderName" runat="server" ReadOnly="true" CssClass="form-control"></asp:TextBox>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="company">Address</label>
                                                        <asp:TextBox ID="txtAddress" runat="server" ReadOnly="true" CssClass="form-control"></asp:TextBox>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="company">Phone number</label>
                                                        <asp:TextBox ID="txtPhone" runat="server" ReadOnly="true" CssClass="form-control"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="col-4">
                                                    <div class="form-group">
                                                        <label for="company">Ngày đặt</label>
                                                        <asp:TextBox ID="txtDayOut" runat="server" ReadOnly="true" TextMode="DateTime" CssClass="form-control"></asp:TextBox>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="company">Return date</label>
                                                        <asp:TextBox ID="txtDayIn" runat="server" ReadOnly="true" TextMode="DateTime" CssClass="form-control"></asp:TextBox>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="company">Email Address</label>
                                                        <asp:TextBox ID="txtEmail" runat="server" ReadOnly="true" CssClass="form-control"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="col-4">
                                                    <div class="form-group">
                                                        <label for="company">Payment Methods</label>
                                                        <asp:TextBox ID="txtPayment" runat="server" ReadOnly="true" CssClass="form-control"></asp:TextBox>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="company">Status</label>
                                                        <asp:TextBox ID="txtStatus" runat="server" ReadOnly="true" CssClass="form-control"></asp:TextBox>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="street">Notes</label>
                                                        <asp:TextBox ID="txtDetail" runat="server" ReadOnly="true" TextMode="DateTime" CssClass="form-control"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div id="order-details" class="tab-pane fade">
                                            <div class="row">
                                                <div class="col-12">
                                                    <asp:GridView ID="grvDetail" runat="server" AutoGenerateColumns="False" AllowPaging="True" DataKeyNames="ID_Product" CssClass="table table-default">
                                                        <Columns>
                                                            <asp:BoundField DataField="ID_Product" HeaderText="ID" HtmlEncode="true" />
                                                            <asp:BoundField DataField="ProductCode" HeaderText="Product code" HtmlEncode="true" />
                                                            <asp:BoundField DataField="ProductName" HeaderText="Tên xe" HtmlEncode="true" />
                                                            <asp:BoundField DataField="Amount" HeaderText="Quantity" HtmlEncode="true" />
                                                            <asp:BoundField DataField="PriceOut" HeaderText="Price" HtmlEncode="true" />
                                                            <asp:BoundField DataField="PriceTotal" HeaderText="Total" HtmlEncode="true" />
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-actions">
                                        <asp:LinkButton ID="btnUpdateStatus" runat="server" OnClick="btnUpdateStatus_Click" CssClass="btn btn-success" Text="Deliver"></asp:LinkButton>
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
                    <asp:AsyncPostBackTrigger ControlID="btnUpdateStatus" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</div>

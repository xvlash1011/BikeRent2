<%@ Control Language="C#" AutoEventWireup="true"  CodeBehind="cart.ascx.cs" Inherits="ShopsDefault.UserControls.Products.cart" %>

<div class="prd-cart section">
    <div class="block-header">Cart</div>
    <div class="container">
        <asp:Label runat="server" ID="lblEmpty" CssClass="text-empty"></asp:Label>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" OnInit="UpdatePanel1_Init">
            <ContentTemplate>
                <%--<div runat="server" id="checkCart"></div>--%>
                <div class="row">
                    <div class="col-8">
                        <div class="table-cart">
                            <asp:GridView ID="grv" runat="server" AutoGenerateColumns="false" OnRowDataBound="grv_RowDataBound" DataKeyNames="ID_Product" OnRowDeleting="grv_RowDeleting" OnRowUpdating="grv_RowUpdating">
                                <Columns>
                                    <asp:BoundField DataField="ID_Product" HeaderText="ID" HtmlEncode="true" />

                                    <asp:BoundField DataField="ProductName" HeaderText="Product" HtmlEncode="true" />

                                    <asp:TemplateField HeaderText="Quantity">
                                        <ItemTemplate>
                                            <div class="prd-amount">
                                                <span class="btn-amount btn_decrement"><i class="fa fa-minus"></i></span><asp:TextBox ID="txtQuantity" runat="server" class="addtocart_quantity" type="text" Text='<%# Eval("Quantity") %>'></asp:TextBox><span class="btn-amount btn_increment"><i class="fa fa-plus"></i></span>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Price">
                                        <ItemTemplate>
                                            <div class="prd-price"><%# Utils.getPrice(Eval("PriceOut"))%><sup>đ</sup></div>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Total">
                                        <ItemTemplate>
                                            <div class="prd-total"><%# Utils.getPrice(Eval("Total"))%><sup>đ</sup></div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkUpdate" runat="server" CausesValidation="false" CommandName="Update" ToolTip="Update"><i class="fa fa-refresh"></i></asp:LinkButton>
                                            <asp:LinkButton ID="lnkDelete" runat="server" CausesValidation="false" CommandName="Delete" ToolTip="Delete"><i class="fa fa-trash"></i></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>

                        </div>
                    </div>
                    <div class="col-4">
                        <div class="cart-info">
                            <table>
                                <tr>
                                    <th colspan="2">Cart</th>
                                </tr>
                                <tr>
                                    <td>Total:</td>
                                    <td><%= Utils.getPrice(getTotal()) %><sup>đ</sup></td>
                                </tr>
                                <tr>
                                    <td><a href="/products.html" class="btn-default">Browse</a></td>
                                    <td>
                                        <a href="/checkout.html" class="btn-default">Checkout</a></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </ContentTemplate>

            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="grv" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
</div>

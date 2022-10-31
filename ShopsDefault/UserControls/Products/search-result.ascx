﻿<%@ Control Language="C#" AutoEventWireup="true"  CodeBehind="search-result.ascx.cs" Inherits="ShopsDefault.UserControls.Products.search_result" %>
<div class="prd-default search-result">
    <div class="section-1">
        <div class="block-header">Search Results</div>
        <div class="container">
            <asp:ObjectDataSource ID="ds" runat="server" OnSelecting="ds_Selecting" SelectMethod="GetDataTable_SQL_pro" TypeName="Librari.Cls_ShopsProducts" />
            <asp:Repeater ID="Repeater4" runat="server" DataSourceID="ds">
                <ItemTemplate>
                    <div class="item">
                        <asp:Label ID="lblID_Product" runat="server" Text='<%# Eval("ID_Product")%>' CssClass="d-none"></asp:Label>
                        <div class="image col-3">
                            <a href="<%# Utils.getAHrefURL("product", Eval("linkSEOCatalog"),Eval("LinkSEO"), Eval("ID_Product"))%>">
                                <img src="<%# Eval("Image")%>" />
                            </a>
                        </div>
                        <div class="content col-6">
                            <a href="<%# Utils.getAHrefURL("product", Eval("linkSEOCatalog"),Eval("LinkSEO"), Eval("ID_Product"))%>">
                                <h3 class="title"><%# Eval("ProductName")%></h3>
                            </a>
                            <div><%# Utils.subString(Convert.ToString(Eval("Description")), 120)%></div>
                            <ul>
                                <li><span>Color:</span> <%# Eval("Color")%></li>
                                <li><span>Speed:</span> <%# Eval("Weight")%> km/h</li>
                                <li><span>Quantity:</span> <%# Eval("SoLuongCon")%></li>
                            </ul>
                        </div>
                        <div class="action col-3">
                            <h5>Price</h5>
                            <h4><%# Utils.getPrice(Eval("PriceOut"))%><sup>VNĐ</sup><span>/Ngày</span></h4>
                            <div>
                                <asp:LinkButton ID="btnAddToCart" runat="server" CommandArgument='<%# Eval("ID_Product")%>' OnClick="btnAddToCart_Click" CausesValidation="false" Text="Add to cart" UseSubmitBehavior="false" CssClass="btn-default add-to-cart" />
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <asp:ObjectDataSource ID="dss" runat="server" OnSelecting="dss_Selecting" SelectMethod="GetDataTable_SQL_pro" TypeName="Librari.Cls_ShopsProducts" />
            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="dss">
                <ItemTemplate>
                    <div class="item">
                        <asp:Label ID="lblID_Product" runat="server" Text='<%# Eval("ID_Product")%>' CssClass="d-none"></asp:Label>
                        <div class="image col-3">
                            <a href="<%# Utils.getAHrefURL("product", Eval("linkSEOCatalog"),Eval("LinkSEO"), Eval("ID_Product"))%>">
                                <img src="<%# Eval("Image")%>" />
                            </a>
                        </div>
                        <div class="content col-6">
                            <a href="<%# Utils.getAHrefURL("product", Eval("linkSEOCatalog"),Eval("LinkSEO"), Eval("ID_Product"))%>">
                                <h3 class="title"><%# Eval("ProductName")%></h3>
                            </a>
                            <div><%# Utils.subString(Convert.ToString(Eval("Description")), 120)%></div>
                            <ul>
                                <li><span>Color:</span> <%# Eval("Color")%></li>
                                <li><span>Speed:</span> <%# Eval("Weight")%> km/h</li>
                                <li><span>Quantity:</span> <%# Eval("Amount")%></li>
                            </ul>
                        </div>
                        <div class="action col-3">
                            <h5>Price</h5>
                            <h4><%# Utils.getPrice(Eval("PriceOut"))%><sup>VNĐ</sup><span>/Ngày</span></h4>
                            <div>
                                <asp:LinkButton ID="btnAddToCart" runat="server" CommandArgument='<%# Eval("ID_Product")%>' OnClick="btnAddToCart_Click" CausesValidation="false" Text="Add to cart" UseSubmitBehavior="false" CssClass="btn-default add-to-cart" />
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</div>

﻿<%@ Control Language="C#" AutoEventWireup="true"  CodeBehind="main.ascx.cs" Inherits="ShopsDefault.UserControls.Products.main" %>
<div class="prd-default">
    <asp:ObjectDataSource ID="dsCatalog" runat="server" OnSelecting="ds_Catalogs_Selecting" SelectMethod="GetDataTable_SQL_pro" TypeName="Librari.Cls_ShopsCatalogs" />
    <asp:Repeater ID="Repeater3" runat="server" DataSourceID="dsCatalog">
        <ItemTemplate>
            <div class="section-1">
                <div class="block-header"><%# Eval("CatalogName")%></div>
                <div class="container">
                    <div class="row">
                        <asp:Repeater ID="Repeater4" runat="server" DataSource='<%# getPrdSelecting(Eval("ID_Catalog"))%>'>
                            <ItemTemplate>
                                <div class="col-lg-4">
                                    <div class="item">
                                        <asp:Label ID="lblID_Product" runat="server" Text='<%# Eval("ID_Product")%>' CssClass="d-none"></asp:Label>
                                        <div class="image">
                                            <a href="<%# Utils.getAHrefURL("product", Eval("linkSEOCatalog"),Eval("LinkSEO"), Eval("ID_Product"))%>">
                                                <img src="<%# Eval("Image")%>" />
                                            </a>
                                        </div>
                                        <div class="content">
                                            <a href="<%# Utils.getAHrefURL("product", Eval("linkSEOCatalog"),Eval("LinkSEO"), Eval("ID_Product"))%>">
                                                <h3 class="title"><%# Eval("ProductName")%></h3>
                                            </a>
                                            <h4><%# Utils.getPrice(Eval("PriceOut"))%><sup>VNĐ</sup><span>/Date</span></h4>
                                            <ul>
                                                <li><i class="fa fa-motorcycle"></i><%# Eval("Color")%></li>
                                                <li><i class="fa fa-dashboard"></i><%# Eval("Weight")%> km/h</li>
                                            </ul>
                                            <div class="action">
                                                <asp:LinkButton ID="btnAddToCart" runat="server" CommandArgument='<%# Eval("ID_Product")%>' OnClick="btnAddToCart_Click" CausesValidation="false" Text="Add to cart" UseSubmitBehavior="false" CssClass="btn-default add-to-cart" />
                                                <a href="<%# Utils.getAHrefURL("product", Eval("linkSEOCatalog"),Eval("LinkSEO"), Eval("ID_Product"))%>" class="btn-default">Details</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</div>

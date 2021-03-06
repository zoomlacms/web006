﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PVManager.aspx.cs" Inherits="ZoomLaCMS.Manage.Shop.PVManager" MasterPageFile="~/Manage/I/Index.master" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
    <title>提成管理</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<%=Call.SetBread( new Bread[] {
new Bread("ProductManage.aspx","商城管理"),
new Bread("OrderList.aspx","订单管理"),
new Bread(){url="", text="提成管理"}
}) %>
<div class="list_choice table-responsive-md">
    <ZL:ExGridView ID="EGV" runat="server" AutoGenerateColumns="false" OnPageIndexChanging="EGV_PageIndexChanging" PageSize="10" AllowPaging="True" AllowSorting="True" CssClass="table table-striped table-bordered table-hover list_choice" EnableTheming="False" EmptyDataText="没有内容">
        <Columns>
           <%-- <asp:TemplateField>
                <ItemTemplate>
                    <input type="checkbox" name="idchk" />
                </ItemTemplate>
            </asp:TemplateField>--%>
            <asp:TemplateField HeaderText="订单号">
                <ItemTemplate>
                     <a href='Orderlistinfo.aspx?id=<%#Eval("ID") %>'><%#Eval("OrderNo") %></a>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Reuser" HeaderText="客户名称" />
            <asp:BoundField DataField="AddTime" HeaderText="下单时间" />
            <asp:TemplateField HeaderText="实际金额">
                <ItemTemplate>
                   <%#Eval("Ordersamount","{0:f2}") %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="订单状态">
                <ItemTemplate>
                    <%#GetOrderStatu() %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="付款状态">
                <ItemTemplate>
                    <%#GetPayStatu() %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="PVs" HeaderText="可获得PV值" />
        </Columns>
    </ZL:ExGridView>
	<div class="sysBtline">
	<asp:Button ID="Unit_Btn" CssClass="btn btn-info" runat="server" Text="确定分成" OnClientClick="return confirm('确定要分成吗?');" OnClick="Unit_Btn_Click" />
	</div>
   </div>     
</asp:Content>

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TopApply.aspx.cs" Inherits="ZoomLaCMS.Extend.TopApply" MasterPageFile="~/Manage/I/Index.Master" %>
<asp:Content runat="server" ContentPlaceHolderID="head"><title>置顶审核</title></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <div id="BreadDiv" class="container-fluid mysite">
        <div class="row">
            <ol id="BreadNav" class="breadcrumb fixed-top w-100">
                <li class="breadcrumb-item"><a href='<%=CustomerPageAction.customPath2 %>Main.aspx'>工作台</a></li>
                <li class="breadcrumb-item"><a href='<%=Request.RawUrl %>'>置顶申请</a></li>
            </ol>
        </div>
    </div>
<div class="list_choice table-responsive-md">
<ZL:ExGridView ID="EGV" runat="server" AutoGenerateColumns="False" PageSize="10" IsHoldState="false" 
    OnPageIndexChanging="EGV_PageIndexChanging" AllowPaging="True" AllowSorting="True" OnRowCommand="EGV_RowCommand" OnRowDataBound="EGV_RowDataBound"
    CssClass="table table-striped table-bordered" EnableTheming="False" EnableModelValidation="True" EmptyDataText="数据为空">
    <Columns>
        <asp:TemplateField ItemStyle-CssClass="w1rem">
            <ItemTemplate>
                <input type="checkbox" name="idchk" value="<%#Eval("ID") %>" />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField HeaderText="ID" DataField="ID" ItemStyle-CssClass="td_s" />
        <asp:TemplateField HeaderText="标题">
            <ItemTemplate>
                <%#Eval("Title") %>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="用户">
            <ItemTemplate>
               <a href="javascript:;" onclick="user.showuinfo('<%#Eval("UserID") %>');"> <%#Eval("UserName") %></a>
            </ItemTemplate>
        </asp:TemplateField> 
        <asp:TemplateField HeaderText="状态">
            <ItemTemplate>
                <%#ShowZStatus() %>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="CDate" DataFormatString="{0:yyyy年MM月dd日}" HeaderText="创建时间" ItemStyle-CssClass="td_l"/>
        <asp:TemplateField HeaderText="操作" ItemStyle-CssClass="td_l">
            <ItemTemplate>
                <asp:LinkButton runat="server"  CommandName="audit" CommandArgument='<%#Eval("ID") %>'  class="btn btn-info btn-sm">审核</asp:LinkButton>
                <asp:LinkButton runat="server"  CommandName="reject" CommandArgument='<%#Eval("ID") %>' class="btn btn-info btn-sm">拒绝</asp:LinkButton>
                <asp:LinkButton runat="server"  CommandName="del2" CommandArgument='<%#Eval("ID") %>'  class="btn btn-danger btn-sm">删除</asp:LinkButton>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</ZL:ExGridView>
</div>
<div style="margin-top:5px;">
    <asp:Button runat="server" class="btn btn-info" ID="BatAudit_Btn" Text="批量审核" OnClick="BatAudit_Btn_Click" OnClientClick="return confirm('确定要审核吗');" />
    <asp:Button runat="server" class="btn btn-info" ID="BatReject_Btn" Text="批量拒绝" OnClick="BatReject_Btn_Click" OnClientClick="return confirm('确定要拒绝吗');" />
</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">

</asp:Content>
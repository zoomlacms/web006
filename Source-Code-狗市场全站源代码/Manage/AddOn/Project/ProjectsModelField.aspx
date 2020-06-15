<%@ Page Language="C#" MasterPageFile="~/Manage/I/Index.master" AutoEventWireup="true" CodeBehind="ProjectsModelField.aspx.cs" Inherits="ZoomLaCMS.Manage.AddOn.Project.ProjectsModelField" %>
<asp:Content ContentPlaceHolderID="head" runat="Server"><title>字段列表</title></asp:Content>
<asp:Content ContentPlaceHolderID="Content" runat="Server">
<%=Call.SetBread(new Bread[] {
		new Bread("/{manage}/Main.aspx","工作台"),
        new Bread("Projects.aspx","项目管理"),
        new Bread() {url="", text="字段列表<a href='../../Content/Model/AddModelField.aspx?ModelType=10&ModelID=1'> [添加字段]</a>",addon="" }},
		Call.GetHelp(46)
		)
    %>
	<div class="container-fluid pr-0">
	<div class="row sysRow list_choice table-responsive-md">
<table class="table table-striped table-bordered table-hover">
	<tr>
		<th scope="col"><strong>字段名</strong></th>
		<th scope="col"><strong>字段别名</strong></th>
		<th scope="col"><strong>字段类型</strong></th>
		<th scope="col"><strong>字段级别</strong></th>
		<th scope="col"><strong>是否必填</strong></th>
		<th scope="col"><strong>排序</strong></th>
		<th scope="col"><strong>操作</strong></th>
	</tr>
	<asp:Repeater ID="RepSystemModel" runat="server">
		<ItemTemplate>
			<tr>
				<td><%#Eval("FieldName")%></td>
				<td><%#Eval("FieldAlias")%></td>
				<td><%# Eval("FieldType", "{0}")%></td>
				<td><font color="#339900">系统</font></td>
				<td><%# GetStyleTrue(Eval("IsNotNull", "{0}"))%></td>
				<td></td>
				<td></td>
			</tr>
		</ItemTemplate>
	</asp:Repeater>
	<asp:Repeater ID="RepModelField" runat="server" OnItemCommand="Repeater1_ItemCommand">
		<ItemTemplate>
			<tr>
				<td><%#Eval("ShowList", "{0}") == "False" ? "<font color=#999999>" : ""%><%#Eval("FieldName")%><%#Eval("ShowList", "{0}") == "False" ? "</font>" : ""%></td>
				<td><%#Eval("FieldAlias")%></td>
				<td><%# Eval("FieldType", "{0}")%></td>
				<td>自定义</td>
				<td><%# GetStyleTrue(Eval("IsNotNull", "{0}"))%></td>
				<td>
					<asp:LinkButton ID="LinkButton2" runat="server" CommandName="UpMove" CommandArgument='<%# Eval("FieldID") %>'>上移</asp:LinkButton>
					|
					<asp:LinkButton ID="LinkButton3" runat="server" CommandName="DownMove" CommandArgument='<%# Eval("FieldID") %>'>下移</asp:LinkButton></td>
				<td>
					<asp:LinkButton ID="LinkButton1" runat="server" CommandName="Delete" CommandArgument='<%# Eval("FieldID") %>' OnClientClick="return confirm('确定删除此字段吗?\r\n\r\n删除字段后需要重新生成静态Html代码')"><i class="fa fa-trash-o" title="删除"></i></asp:LinkButton>
                    <a href="../Content/Model/AddModelField.aspx?FieldID=<%# Eval("FieldID") %>&ModelType=10&ModelID=-1"><i class="fa fa-pencil" title="修改"></i>修改</a> 
				</td>
			</tr>
		</ItemTemplate>
	</asp:Repeater>
</table>
</div></div>

</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
</asp:Content>
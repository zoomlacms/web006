﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Restore.aspx.cs" Inherits="ZoomLaCMS.Manage.Design.Addon.Restore" MasterPageFile="~/Manage/I/Index.master" %>
<asp:Content runat="server" ContentPlaceHolderID="head"><title>加载动力版</title></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
        <%=Call.SetBread(new Bread[] {
		new Bread("/{manage}/Main.aspx","工作台"),
        new Bread("/{manage}/Config/DatalistProfile.aspx","扩展功能"),						
        new Bread("/{manage}/Template/LabelManage.aspx","标签管理"),						
        new Bread() {url="/{manage}/Design/Addon/Restore.aspx", text="加载动力版",addon="" }}
		)
    %>
	<div class="list_choice">
<div class="card m50rem_50 mb-2" style="margin:0 auto;">
    <div class="card-header"><i class="fa fa-futbol-o fa-spin"></i>加载动力版</div>
    <div class="card-body">
         <asp:TextBox runat="server" ID="TlpFile_T" CssClass="form-control" placeholder="动力备份文件路径,示例:C:\File\Site.Tlp" />
            <asp:RequiredFieldValidator runat="server" ID="R1" ControlToValidate="TlpFile_T" ForeColor="Red" ErrorMessage="文件路径不能为空"/>
    </div>
    <div class="card-footer">
        <asp:Button runat="server" ID="Restore_Btn" Text="开始恢复" OnClick="Restore_Btn_Click" CssClass="btn btn-info" />
    </div>
</div>
<div class="alert alert-danger">
    <ul>
        <li>恢复时会清除内容|节点和所有附加表[ZL_C_**]的数据,并对一些配置进行修改</li>
    </ul>
</div>
<div class="alert alert-info">
    <ul>
        <li>该功能仅用于私有化布署动力版站点,请确保备份文件来自 <span class="rd_red">动力版-->用户中心-->全站下载</span></li>
    </ul>
</div>
 <%--   <div runat="server">
        <asp:Button runat="server" ID="DelAll_Btn" Text="删除为测试环境" OnClick="DelAll_Btn_Click" />
    </div>--%>
</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">

</asp:Content>

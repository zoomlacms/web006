﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="ZoomLaCMS.Manage.WeiXin.home" MasterPageFile="~/Manage/I/index.master" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
    <title>移动微信管理平台</title>
    <style>
        body { FILTER: progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#99CCFF,endColorStr=#fff); /*IE 6 7 8*/ 
		background: -ms-linear-gradient(top, #99CCFF, #fff) no-repeat; /* IE 10 */ 
		background: -webkit-gradient(linear, 0% 0%, 0% 100%,from(#99CCFF), to(#fff)) no-repeat; /*谷歌*/ }
		.wxapp_box {margin: auto;max-width: 100%;padding-top: 100px;}
		.wxapp {height: 150px;}
		.wxapp a {display: block;text-align: center;color: #333;}
		.wxapp a i {margin-bottom: 5px;padding: 10px;width: 80px;height: 80px;max-width: 100%;background: #31b0d5;border-radius: 10px;font-size: 4em;color: #fff;box-shadow: 0 0 3px 1px rgba(49, 163, 255, 0.4);}
    </style>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <%=Call.SetBread(new Bread[] {
        new Bread("/{manage}/I/Main.aspx","工作台"),
        new Bread("/{manage}/WeiXin/Home.aspx","网站配置"),
        new Bread() {url="", text="微信应用",addon= "" }}
        )
    %>
	<div class="container">
    <div id="MainApp" class="wxapp_box list_choice row">
        <div class="wxapp col-6 col-sm-3 col-lg-2 col-xl-2">
            <a href="WxAppManage.aspx"><i class="fa fa-globe center-block"></i><div>欢迎语</div></a>
        </div>
        <div class="wxapp col-6 col-sm-3 col-lg-2 col-xl-2">
            <a href="WxAppManage.aspx"><i class="fa fa-comments-o center-block" style="background: #73B9FF;"></i><div>自动回复</div></a>
        </div>
        <div class="wxapp col-6 col-sm-3 col-lg-2 col-xl-2">
            <a href="WxAppManage.aspx"><i class="fa fa-newspaper-o center-block" style="background: #FFC926;"></i><div>素材管理</div></a>
        </div>
        <div class="wxapp col-6 col-sm-3 col-lg-2 col-xl-2">
            <a href="Msg/MsgTlpList.aspx?appid=<%:Mid %>"><i class="fa fa-rss center-block" style="background: #0085B2;"></i><div>高级群发</div></a>
        </div>
        <div class="wxapp col-6 col-sm-3 col-lg-2 col-xl-2">
            <a href="WxAppManage.aspx"><i class="fa fa-book center-block" style="background: #00D9D9;"></i><div>菜单配置</div></a>
        </div>
        <div class="wxapp col-6 col-sm-3 col-lg-2 col-xl-2">
            <a href="WxConfig.aspx"><i class="fa fa-cog center-block" style="background: #FF4DFF;"></i><div>微信配置</div></a>
        </div>
        <div class="wxapp col-6 col-sm-3 col-lg-2 col-xl-2">
            <a href="WxAppManage.aspx"><i class="fa fa-users center-block" style="background: #686859;"></i><div>粉丝管理</div></a>
        </div>
        <div class="wxapp col-6 col-sm-3 col-lg-2 col-xl-2">
            <a href="LuckDraw/Default.aspx"><i class="fa fa-history center-block" style="background: #ff006e;"></i><div>刮刮卡</div></a>
        </div>
        <div class="wxapp col-6 col-sm-3 col-lg-2 col-xl-2">
            <a href="LuckDraw/Default.aspx"><i class="fa fa-futbol-o center-block" style="background: #ff006e;"></i><div>大转盘</div></a>
        </div>
        <div class="wxapp col-6 col-sm-3 col-lg-2 col-xl-2">
            <a href="/Admin/Template/TemplateSetOfficial.aspx"><i class="fa fa-cloud center-block" style="background: #ff006e;"></i><div>模板云</div></a>
        </div>
        <div class="wxapp col-6 col-sm-3 col-lg-2 col-xl-2">
            <a href="http://app.z01.com/" target="_blank" class="wxapp_a"><i class="fa fa-mobile center-block" style="background: #ff6a00;"></i><div>微场景</div></a>
        </div>
        <div class="wxapp col-6 col-sm-3 col-lg-2 col-xl-2">
            <a href="http://www.z01.com/mtv" target="_blank" class="wxapp_a"><i class="fa fa-film center-block" style="background: #ff6a00;"></i><div>云视频</div></a>
        </div>
        <div class="wxapp col-6 col-sm-3 col-lg-2 col-xl-2">
            <a href="/Admin/Sentiment/Default.aspx"><i class="fa fa-dashboard center-block" style="background: #00D9A3;"></i><div>舆情监测</div></a>
        </div>
        <div class="wxapp col-6 col-sm-3 col-lg-2 col-xl-2">
            <a href="/Admin/Content/ECharts/AddChart.aspx"><i class="fa fa-line-chart center-block" style="background: #ff006e;"></i><div>智能图表</div></a>
        </div>
        <div class="wxapp col-6 col-sm-3 col-lg-2 col-xl-2">
            <a href="http://www.z01.com/other/2400.shtml" target="_blank" class="wxapp_a"><i class="fa fa-language center-block" style="background: #00698C;"></i><div>智能采集</div></a>
        </div>
    </div>
	</div>
</asp:Content>

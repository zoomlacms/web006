<%@ WebHandler Language="C#" Class="API" %>

using System;
using System.Web;
using System.Data;
using ZoomLa.BLL;
using ZoomLa.BLL.API;
using ZoomLa.Model;
using ZoomLa.SQLDAL;
using ZoomLa.BLL.CreateJS;
using System.Data.SqlClient;
using System.Collections.Generic;

public class API :API_Base,IHttpHandler {
    B_User buser = new B_User();
    public void ProcessRequest (HttpContext context) {
        retMod.retcode = M_APIResult.Failed;
        M_UserInfo mu = buser.GetLogin();
        //retMod.callback = CallBack;//暂不开放JsonP
        try
        {
            switch (Action)
            {
                case "dog_top"://用户置顶自己的内容,置不限制
                    {
                        B_CodeModel codeBll = new B_CodeModel("ZL_Ex_TopApply");
                        DataTable codeDT = codeBll.SelStruct();
                        string ids = Req("ids");
                        if (string.IsNullOrEmpty(ids)) { throw new Exception("未指定内容"); }
                        SafeSC.CheckIDSEx(ids);
                        List<SqlParameter> sp = new List<SqlParameter>();
                        sp.Add(new SqlParameter("uname", mu.UserName));
                        string where = "GeneralID IN (" + ids + ") AND Inputer=@uname";
                        DataTable dogDT = DBCenter.Sel("ZL_CommonModel",where,"",sp);
                        foreach (DataRow dr in dogDT.Rows)
                        {
                            int top = DataConvert.CLng(dr["IsTop"]);
                            if (top != 0) { continue; }
                            //写入申请
                            DataRow codeMod = codeDT.NewRow();
                            codeMod["UserID"] = mu.UserID;
                            codeMod["UserName"] = mu.UserName;
                            codeMod["Gid"] = dr["GeneralID"];
                            codeMod["Title"] = dr["Title"];
                            codeMod["CDate"] = DateTime.Now;
                            codeMod["ZStatus"] = 0;
                            codeBll.Insert(codeMod);
                        }
                        DBCenter.UpdateSQL("ZL_CommonModel","IsTop=-1",where,sp);
                        retMod.retcode = M_APIResult.Success;
                    }
                    break;
                case "dog_untop":
                    {
                        string ids = Req("ids");
                        if (string.IsNullOrEmpty(ids)) { throw new Exception("未指定内容"); }
                        SafeSC.CheckIDSEx(ids);
                        List<SqlParameter> sp = new List<SqlParameter>();
                        sp.Add(new SqlParameter("uname", mu.UserName));
                        string where = "GeneralID IN (" + ids + ") AND Inputer=@uname";
                        DBCenter.UpdateSQL("ZL_CommonModel", "IsTop=0", where, sp);
                        retMod.retcode = M_APIResult.Success;
                    }
                    break;
                case "dog_update"://刷新狗狗信息,不同的会员组刷新的间隔时间不同
                    {
                        string ids = Req("ids");
                        if (string.IsNullOrEmpty(ids)) { throw new Exception("未指定信息"); }
                        SafeSC.CheckIDSEx(ids);
                        //有效期内的信息可每12小时可手动刷新一次
                        string where = " GeneralID IN (" + ids + ") AND SuccessFulUserID=" + mu.UserID;
                        if (mu.GroupID == 1)
                        {
                            where += " AND DATEDIFF(hour,UpDateTime,getdate())>=12";
                            DBCenter.UpdateSQL("ZL_CommonModel", "UpDateTime=getdate()", where);
                        }
                        else//有效期内的信息每6小时可刷新一次
                        {
                            where += " AND DATEDIFF(hour,UpDateTime,getdate())>=6";
                            DBCenter.UpdateSQL("ZL_CommonModel", "UpDateTime=getdate()", where);
                        }
                        retMod.retcode = M_APIResult.Success;

                    }
                    break;
                case "cate_check":
                    {
                        //[泰迪犬]品种本月您已发布过了，别重复哦！
                        //普通会员每月、每品种限发1条，限发10个品种,40个附件  
                        //高级会员每月、每品种限发1条，不限品种，限传230个附件
                        //超级会员每月、每品种限发1条，不限品种、限传280个附件
                        //至尊会员设计为有广告位需求的会员
                        int gid = mu.GroupID;
                        string lei = Req("lei");
                        List<SqlParameter> sp = new List<SqlParameter>() {
                            new SqlParameter("stime",DateTime.Now.ToString("yyyy/MM/01 00:00:00"))
                        };
                        string fields = "A.GeneralID,B.ggpz,B.lei2";
                        string where = "A.ModelID=50 AND A.[Status] IN(0,99) AND A.SuccessfulUserID=" + mu.UserID + " AND CreateTime>=@stime";
                        //已发狗狗数量
                        DataTable dogDT = DBCenter.JoinQuery(fields, "ZL_CommonModel", "ZL_C_dog", "A.ItemID=B.ID", where, "GeneralID DESC", sp.ToArray());
                        //已发狗分类
                        DataTable cateDT = dogDT.DefaultView.ToTable(true, "lei2");

                        dogDT.DefaultView.RowFilter = "lei2='" + lei + "'";
                        DataTable existDT = dogDT.DefaultView.ToTable();
                        if (existDT.Rows.Count > 0)
                        {
                            retMod.retmsg = "[" + lei + "]品种本月您已发布过了，别重复哦！";
                            RepToClient(retMod);
                            return;
                        }
                        if (gid < 1) { retMod.retmsg = "用户组不正确"; }
                        else if (gid == 1)
                        {
                            if (dogDT.Rows.Count > 10)
                            {
                                retMod.retmsg = "当月所发数量已达到限制";
                            }
                            else if (cateDT.Rows.Count > 10)
                            {
                                retMod.retmsg = "当月所发品类已达到限制";
                            }
                            else
                            {
                                retMod.retcode = M_APIResult.Success;
                            }
                        }
                        else
                        {
                            retMod.retcode = M_APIResult.Success;
                        }
                    }
                    break;
                case "reg_mobile_chk":
                    {
                        string mobile = Req("mobile");
                        if (string.IsNullOrEmpty(mobile))
                        {
                            retMod.retmsg = "手机号码不能为空";
                        }
                        else if (!RegexHelper.IsMobilPhone(mobile))
                        {
                            retMod.retmsg = "手机号码格式不正确";
                        }
                        else
                        {
                            bool flag = DBCenter.IsExist("ZL_UserBase", "Mobile=@mobile",
                                              new List<SqlParameter>() { new SqlParameter("mobile", mobile) });
                            if (flag) { retMod.retmsg = "手机号码已存在"; }
                            else { retMod.retcode = M_APIResult.Success; }
                        }
                    }
                    break;
                default:
                    {
                        retMod.retmsg = "[" + Action + "]接口不存在";
                    }
                    break;
            }
        }
        catch (Exception ex) { retMod.retmsg = ex.Message; }
        RepToClient(retMod);
    }
    private string GetComByExpComp(string compName)
    {
        if (string.IsNullOrEmpty(compName)) { return ""; }
        switch (compName.Trim())
        {
            case "顺丰快递":
            case "顺丰速递": return "shunfeng";
            case "中通速递": return "zhongtong";
            case "申通快递": return "shentong";
            case "圆通速递": return "yuantong";
            case "韵达快递":
            case "韵达快运": return "yunda";
            case "百世汇通": return "huitongkuaidi";
            case "天天快递": return "tiantian";
            case "宅急送": return "zhaijisong";
            case "全峰快递": return "quanfengkuaidi";
            case "E邮宝":
            case "EMS": return "ems";
            case "UPS": return "ups";
            case "德邦物流": return "debangwuliu";
            case "华宇物流": return "tiandihuayu";
            case "如风达快递": return "rufengda";
            case "安能物流": return "annengwuliu";
            default: return "";
        }
    }
    private string GetImgFromStr(string proimg)
    {
        if (string.IsNullOrEmpty(proimg) || proimg.Equals("[]")) { return ""; }
        proimg = proimg.TrimStart('[').TrimEnd(']').Replace("\"", "");
        string[] imgArr = proimg.Split(",".ToCharArray(), StringSplitOptions.RemoveEmptyEntries);
        foreach (string img in imgArr)
        {
            if (!string.IsNullOrEmpty(img)) { return img; }
        }
        return "";
    }

    public bool IsReusable { get { return false; } }

}
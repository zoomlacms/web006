using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ZoomLa.AppCode.Verify;
using ZoomLa.BLL;
using ZoomLa.BLL.Plat;
using ZoomLa.Common;
using ZoomLa.Components;
using ZoomLa.Model;

namespace ZoomLaCMS.Extend
{
    public partial class GetPassword_Email : System.Web.UI.Page
    {
        public string GetPwdUName { get { return DataConverter.CStr(Session["GetPwdUName"]); } set { Session["GetPwdUName"] = value; } }
        B_User buser = new B_User();
        protected void Page_Load(object sender, EventArgs e)
        {
            string emailUrl = B_Plat_Common.GetMailSite("469582963@qq.com");
            function.WriteSuccessMsg("密码重设请求提交成功,<a href='" + emailUrl + "' target='_blank'>请前往邮箱查收</a>!!", emailUrl, 0); return;


            //B_MailManage mailBll = new B_MailManage();
            //if (!VerifyHelper.Check(Request.Form["VCode_Hid"]))
            //{
            //    function.WriteErrMsg("验证码不正确", "/User/GetPassword"); return;
            //}
            //M_UserInfo mu = GetUserByName(Request.Form["TxtUserName"]);
            //if (string.IsNullOrEmpty(mu.Email) || mu.Email.Contains("@random")) { function.WriteErrMsg("用户未设置邮箱,无法通过邮箱找回"); return; }
            ////生成Email验证链接
            //string seturl = function.GetRandomString(12) + "," + DateTime.Now.ToString();
            //mu.seturl = EncryptHelper.AESEncrypt(seturl);
            //buser.UpDateUser(mu);
            ////Email发送
            //string url = SiteConfig.SiteInfo.SiteUrl + "/User/Change/GetPassWord?key=" + mu.seturl + "&uid=" + mu.UserID;
            //string returnurl = "<a href=\"" + url + "\" target=\"_blank\">" + url + "</a>";
            //string content = mailBll.SelByType(B_MailManage.MailType.RetrievePWD);
            //content = new OrderCommon().TlpDeal(content, GetPwdEmailDt(mu.UserName, SiteConfig.SiteInfo.SiteName, returnurl));
            //MailInfo mailInfo = SendMail.GetMailInfo(mu.Email, SiteConfig.SiteInfo.SiteName, SiteConfig.SiteInfo.SiteName + "_找回密码", content);
            //SendMail.Send(mailInfo);
            ////不需要更新步骤,其从邮箱进入地址栏后再更新
            //string emailUrl = B_Plat_Common.GetMailSite(mu.Email);
            //function.WriteSuccessMsg("密码重设请求提交成功,<a href='" + emailUrl + "' target='_blank'>请前往邮箱查收</a>!!", emailUrl, 0); return;
        }
        private M_UserInfo GetUserByName(string uname)
        {
            GetPwdUName = (uname ?? "").Trim();
            if (string.IsNullOrEmpty(GetPwdUName)) { function.WriteErrMsg("用户名不能为空"); return null; }
            M_UserInfo mu = buser.GetUserByName(GetPwdUName);
            if (mu.IsNull) { function.WriteErrMsg("[" + GetPwdUName + "]用户不存在"); return null; }
            return mu;
        }
        private DataTable GetPwdEmailDt(string username, string sitename, string returnurl)
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("UserName");
            dt.Columns.Add("SiteName");
            dt.Columns.Add("ReturnUrl");
            dt.Rows.Add(dt.NewRow());
            dt.Rows[0]["UserName"] = username;
            dt.Rows[0]["SiteName"] = sitename;
            dt.Rows[0]["ReturnUrl"] = returnurl;
            return dt;
        }
    }
}
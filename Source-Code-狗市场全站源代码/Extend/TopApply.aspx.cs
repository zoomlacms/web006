using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ZoomLa.BLL;
using ZoomLa.BLL.CreateJS;
using ZoomLa.Common;
using ZoomLa.SQLDAL;

namespace ZoomLaCMS.Extend
{
    public partial class TopApply : System.Web.UI.Page
    {
        B_CodeModel codeBll = new B_CodeModel("ZL_Ex_TopApply");
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                MyBind();
            }
        }
        private void MyBind()
        {
            EGV.DataSource = codeBll.SelByWhere("ZStatus=0","ID DESC");
            EGV.DataBind();
        }
        protected void EGV_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            EGV.PageIndex = e.NewPageIndex;
            MyBind();
        }
        protected void EGV_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = DataConvert.CLng(e.CommandArgument);
            switch (e.CommandName)
            {
                case "del2":
                    codeBll.DelByIDS(id.ToString());
                    break;
                case "reject":
                    BatReject(id.ToString());
                    break;
                case "audit":
                    BatAudit(id.ToString());
                    break;
                    
            }
            MyBind();
        }
        protected void EGV_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }
        public string ShowZStatus()
        {
            switch (DataConvert.CLng(Eval("ZStatus")))
            {
                case 0:
                    return "未审核";
                case -1:
                    return "<span style='color:red;'>已拒绝</span>";
                case 99:
                    return "<span style='color:green;'>已审核</span>";
                default:
                    return Eval("ZStatus", "");
            }
        }
        private void BatAudit(string ids)
        {
            if (string.IsNullOrEmpty(ids)||ids.Equals("0")) return;
            SafeSC.CheckIDSEx(ids);
            DataTable dt = codeBll.SelByWhere("ID IN (" + ids + ")", "ID DESC");
            foreach (DataRow dr in dt.Rows)
            {
                if (DataConvert.CLng(dr["ZStatus"]) != 0) { continue; }
                string gids = DataConvert.CStr(dr["Gid"]);
                dr["ZStatus"] = 99;
                codeBll.UpdateByID(dr);
                DBCenter.UpdateSQL("ZL_CommonModel", "IsTop=1", "GeneralID IN (" + gids + ")");
            }
            function.WriteSuccessMsg("操作成功");
        }
        private void BatReject(string ids)
        {
            if (string.IsNullOrEmpty(ids) || ids.Equals("0")) return;
            SafeSC.CheckIDSEx(ids);
            DataTable dt = codeBll.SelByWhere("ID IN (" + ids + ")", "ID DESC");
            foreach (DataRow dr in dt.Rows)
            {
                if (DataConvert.CLng(dr["ZStatus"]) != 0) { continue; }
                string gids = DataConvert.CStr(dr["Gid"]);
                dr["ZStatus"] = -1;
                DBCenter.UpdateSQL("ZL_CommonModel", "IsTop=0", "GeneralID IN (" + gids + ")");
                codeBll.UpdateByID(dr);
            }
            function.WriteSuccessMsg("操作成功");
        }
        protected void BatAudit_Btn_Click(object sender, EventArgs e)
        {
            BatAudit(Request.Form["idchk"]);
            MyBind();
        }

        protected void BatReject_Btn_Click(object sender, EventArgs e)
        {
            BatReject(Request.Form["idchk"]);
            MyBind();
        }
    }
}
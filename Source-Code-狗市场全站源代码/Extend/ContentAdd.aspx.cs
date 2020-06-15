using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ZoomLa.BLL;
using ZoomLa.Common;
using ZoomLa.Model;
using ZoomLa.SQLDAL;

namespace ZoomLaCMS.Extend
{
    public partial class ContentAdd : System.Web.UI.Page
    {
        B_Favorite favBll = new B_Favorite();
        B_Content conBll = new B_Content();
        B_Node nodeBll = new B_Node();
        B_Model modBll = new B_Model();
        B_ModelField fieldBll = new B_ModelField();
        B_UserPromotions upBll = new B_UserPromotions();
        B_Comment cmtBll = new B_Comment();
        B_Product proBll = new B_Product();
        B_Stock stockBll = new B_Stock();
        B_Group gpBll = new B_Group();
        B_KeyWord keyBll = new B_KeyWord();
        B_User buser = new B_User();
        public int NodeID
        {
            get
            {
              return DataConvert.CLng(Request["NodeID"]); 
            }
        }
        public int ModelID
        {
            get
            {
                return DataConvert.CLng(Request["ModelID"]);
            }
        }
        public int Mid { get { return DataConverter.CLng(Request.QueryString["ID"]); } }
        protected void Page_Load(object sender, EventArgs e)
        {
            M_UserInfo mu = buser.GetLogin();
            M_CommonData CData = new M_CommonData();
            if (Mid > 0)
            {
                CData = conBll.GetCommonData(Mid);
                if (!CData.Inputer.Equals(mu.UserName)) { function.WriteErrMsg("你无权修改该内容"); return; }
            }
            else
            {
                CData.NodeID = NodeID;
                CData.ModelID = ModelID;
                CData.TableName = modBll.SelReturnModel(CData.ModelID).TableName;
            }
            M_Node nodeMod = nodeBll.SelReturnModel(CData.NodeID);
            DataTable dt = fieldBll.SelByModelID(CData.ModelID, false);
            Call commonCall = new Call();
            DataTable table;
            try
            {
                table = commonCall.GetDTFromPage(dt, this,ViewState);
            }
            catch (Exception ex)
            {
                function.WriteErrMsg(ex.Message); return;
            }
            CData.Title = Request.Form["title"];
            CData.Subtitle = Request["Subtitle"];
            CData.PYtitle = Request["PYtitle"];
            CData.TagKey = Request.Form["tabinput"];
            CData.Status = nodeMod.SiteContentAudit;
            //存省份信息
            CData.PdfLink = DataConvert.CStr(Request.Form["txt_diqu"]).Split(',')[0];
            string parentTree = "";
            CData.TitleStyle = Request.Form["TitleStyle"];
            if (!string.IsNullOrEmpty(Request.Form["txt_ggzt"]))
            {
                string ggzt = Request.Form["txt_ggzt"];
                DataTable ggztDT = JsonConvert.DeserializeObject<DataTable>(ggzt);
                CData.TopImg = DataConvert.CStr(ggztDT.Rows[0]["url"]);//首页图片
            }
            if (!string.IsNullOrEmpty(Request.Form["topimg_hid"]))
            {
                CData.TopImg = Request.Form["topimg_hid"];
            }
            if (Mid > 0)//修改内容
            {
                conBll.UpdateContent(table, CData);
            }
            else
            {
                CData.FirstNodeID = nodeBll.SelFirstNodeID(CData.NodeID, ref parentTree);
                CData.ParentTree = parentTree;
                CData.Inputer = mu.UserName;
                CData.SuccessfulUserID = mu.UserID;
                CData.GeneralID = conBll.AddContent(table, CData);//插入信息给两个表，主表和从表:CData-主表的模型，table-从表
            }
            function.WriteSuccessMsg("操作成功!", "/User/Content/MyContent?NodeID=" + CData.NodeID); return;
        }
    }
}
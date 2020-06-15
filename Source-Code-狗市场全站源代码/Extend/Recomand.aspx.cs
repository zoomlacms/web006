using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ZoomLa.BLL;
using ZoomLa.Common;
using ZoomLa.Components;
using ZoomLa.Model;
using ZoomLa.SQLDAL;

public partial class Extend_Recomand : System.Web.UI.Page
{
    B_Ask askBll = new B_Ask();
    B_GuestAnswer ansBll = new B_GuestAnswer();
    B_AskCommon askComBll = new B_AskCommon();
    B_User buser = new B_User();
    //推荐为满意回答
    public int Mid { get { return DataConvert.CLng(Request["ID"]); } }
    protected void Page_Load(object sender, EventArgs e)
    {
        M_GuestAnswer ansMod = ansBll.SelReturnModel(DataConverter.CLng(Request["aid"]));
        M_UserInfo ansUser = buser.SelReturnModel(ansMod.UserId);//回答人用户模型
        if (ansMod == null) { function.WriteErrMsg("回答不存在"); }
        M_Ask askMod = askBll.SelReturnModel(Mid);
        if (askMod == null) { function.WriteErrMsg("问题不存在"); }
        if (ansMod.QueId != askMod.ID) { function.WriteErrMsg("问题与答案不匹配"); }
        //---------------------------------------
        ansMod.Status = 1;
        DBCenter.UpdateSQL(ansMod.TbName, "[Status]=1", "ID=" + ansMod.ID);
        askMod.Status = 2;      //问题状态设置为已解决
        DBCenter.UpdateSQL(askMod.TbName, "[Status]=2", "ID=" + askMod.ID);

        if (askMod.Score > 0)
        {
            buser.ChangeVirtualMoney(ansMod.UserId, new M_UserExpHis()//悬赏积分
            {
                score = askMod.Score,
                ScoreType = (int)M_UserExpHis.SType.Point,
                detail = ansUser.UserName + "对问题[" + askMod.Qcontent + "]的回答被推荐为满意答案,增加悬赏积分+" + askMod.Score.ToString()
            });
        }
        buser.ChangeVirtualMoney(ansMod.UserId, new M_UserExpHis()//问答积分
        {
            score = GuestConfig.GuestOption.WDOption.WDRecomPoint,
            ScoreType = (int)((M_UserExpHis.SType)(Enum.Parse(typeof(M_UserExpHis.SType), GuestConfig.GuestOption.WDOption.PointType))),
            detail = ansUser.UserName + "对问题[" + askMod.Qcontent + "]的回答被推荐为满意答案,增加问答积分+" + GuestConfig.GuestOption.WDOption.WDRecomPoint
        });
        function.WriteSuccessMsg("推荐成功！", "/Ask/Interactive?ID=" + Mid);
    }
}
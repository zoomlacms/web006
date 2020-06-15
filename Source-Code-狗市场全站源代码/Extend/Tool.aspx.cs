using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ZoomLa.Common;
using ZoomLa.SQLDAL;

public partial class Extend_Tool : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void ToState_Click(object sender, EventArgs e)
    {
        DataTable dt = DBCenter.JoinQuery("A.GeneralID,A.PdfLink,B.Diqu","ZL_CommonModel","ZL_C_Dog","A.ItemID=B.ID","A.ModelID=50");
        foreach (DataRow dr in dt.Rows)
        {
            DBCenter.UpdateSQL("ZL_CommonModel","PdfLink='"+DataConvert.CStr(dr["diqu"]).Split(',')[0] +"'","GeneralID="+dr["GeneralID"]);
        }
        function.WriteErrMsg("处理成功");
    }
}
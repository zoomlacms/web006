using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Security.Cryptography;
using System.Text;
using Newtonsoft.Json;
using ZoomLa.BLL;
using System.Data;
using ZoomLa.SQLDAL;

public partial class Tools_test : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DataTable dt = DBCenter.Sel("ZL_C_Dog");
        foreach (DataRow dr in dt.Rows)
        {
            string lei2 = DataConvert.CStr(dr["lei2"]);
            if (!lei2.Contains("|")) { continue; }
            lei2 = lei2.Split('|')[1];
            DBCenter.UpdateSQL("ZL_C_Dog", "lei2='"+lei2+"'","ID="+dr["ID"]);
        
        }
        


    }
}
﻿using SchoolApp.SchoolAppUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI.WebControls;

namespace SchoolApp.users
{
    public partial class inquiry : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                AppUtility util = new AppUtility();

                List<AppKeyValueParam> lst = new List<AppKeyValueParam>()
                {
                    new AppKeyValueParam()
                    {
                        keyfield="@RequestType",
                        valfield="GetAll"
                    }
                };


                DataTable dt = new DataTable();

                dt = util.getdata("SPEnquiry", lst);

                if (dt.Rows.Count > 0)
                {
                    Repeater1.DataSource = dt;
                    Repeater1.DataBind();
                }
            }
        }
        protected void btnShow_Click(object sender, EventArgs e)
        { 
            var btn = (Button)sender;
            var item = (RepeaterItem)btn.NamingContainer;
            var ddl = (Label)item.FindControl("Label2");
            this.ModalPopupExtender1.Show();
        }
        protected void btnShowPopupAdd_Click(object sender, EventArgs e)
        { 
            this.ModalPopupExtender3.Show();
        }

    }
}
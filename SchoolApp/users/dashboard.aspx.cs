using SchoolApp.SchoolAppUtility;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolApp.users
{
    public partial class dashboard : System.Web.UI.Page
    {
        AppUtility util;
        List<AppKeyValueParam> lst;
        DataTable dt;
        protected bool isAdmin = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindTopBlocks();
                BindInquiry();
                BindEventSection();
            }
            if (Convert.ToString(Session["Role"]).ToLower() == "admin")
                isAdmin = true;
            else
                isAdmin = false;
        }
        protected void BindEventSection()
        {
            try
            {
                util = new AppUtility();
                lst = new List<AppKeyValueParam>();
                lst.Add(new AppKeyValueParam { keyfield = "@ReqType", valfield = "eventdetails" });
                lst.Add(new AppKeyValueParam { keyfield = "@RequestedBy", valfield = Convert.ToString(Session["UEmail"]) });
                dt = new DataTable();
                dt = util.getdata("SPDashboard", lst);
                if (dt.Rows.Count > 0)
                {
                    RepeaterEventDashBoard.DataSource = dt;
                    divEventDetails.Visible = false;
                    lblEventDetails.Text = "";
                }
                else
                {
                    divEventDetails.Visible = true;
                    lblEventDetails.Text = "No record found.";
                }
                RepeaterEventDashBoard.DataBind();
            }
            catch (Exception ex)
            {
                divEventDetails.Visible = true;
                lblEventDetails.Text = "Something went wrong.";
            }
        }
        protected void BindInquiry()
        {
            try
            {
                util = new AppUtility();
                lst = new List<AppKeyValueParam>();
                lst.Add(new AppKeyValueParam { keyfield = "@ReqType", valfield = "dashboard-enquiry" });
                lst.Add(new AppKeyValueParam { keyfield = "@RequestedBy", valfield = Convert.ToString(Session["UEmail"]) });
                dt = new DataTable();
                dt = util.getdata("SPDashboard", lst);
                if (dt.Rows.Count > 0)
                {
                    ReapeterInquiry.DataSource = dt;
                    divInquiry.Visible = false;
                    lblInquiry.Text = "";
                }
                else
                {
                    divInquiry.Visible = true;
                    lblInquiry.Text = "No record found.";
                }
                ReapeterInquiry.DataBind();
            }
            catch (Exception ex)
            {
                divInquiry.Visible = true;
                lblInquiry.Text = "Something went wrong.";
            }
        }

        protected void BindTopBlocks()
        {
            try
            {
                util = new AppUtility();
                lst = new List<AppKeyValueParam>();
                lst.Add(new AppKeyValueParam { keyfield = "@ReqType", valfield = "dashboard-topblocks" });
                lst.Add(new AppKeyValueParam { keyfield = "@RequestedBy", valfield = Convert.ToString(Session["UEmail"]) });
                dt = new DataTable();
                dt = util.getdata("SPDashboard", lst);
                if (dt.Rows.Count > 0)
                {
                    lblTotEvents.Text = Convert.ToString(dt.Rows[0]["TotEvent"]);
                    lblTotUsers.Text = Convert.ToString(dt.Rows[0]["TotUsers"]);
                    lblTotInquiry.Text = Convert.ToString(dt.Rows[0]["TotInquiry"]);
                }
                else
                {
                    lblTotEvents.Text = "0";
                    lblTotUsers.Text = "0";
                    lblTotInquiry.Text = "0";
                } 
            }
            catch (Exception ex)
            {
                lblTotEvents.Text = "0";
                lblTotUsers.Text = "0";
                lblTotInquiry.Text = "0";
            }
        }
    }
}
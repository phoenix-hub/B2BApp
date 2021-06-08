using SchoolApp.SchoolAppUtility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Web.UI.DataVisualization.Charting;
using System.Drawing;

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
                BindPieChart();
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

                if (dt != null)
                {
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
                if (dt != null)
                {
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
                if (dt != null)
                {
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


        protected void BindPieChart()
        {

            util = new AppUtility();
            lst = new List<AppKeyValueParam>();
            lst.Add(new AppKeyValueParam { keyfield = "@ReqType", valfield = "dashboardchart" });
            lst.Add(new AppKeyValueParam { keyfield = "@RequestedBy", valfield = Convert.ToString(Session["UEmail"]) });
            dt = new DataTable();
            dt = util.getdata("SPDashboard", lst);


            Chart1.Series["Series1"].XValueMember = "EMType";
            Chart1.Series["Series1"].YValueMembers = "Events";
            Chart1.DataSource = dt;

            Chart1.DataBind();

            string[] XPointMember = new string[dt.Rows.Count];
            int[] YPointMember = new Int32[dt.Rows.Count];

            for (int count = 0; count < dt.Rows.Count; count++)
            {
                //storing Values for X axis  
                XPointMember[count] = dt.Rows[count]["EMType"].ToString();
                //storing values for Y Axis  
                YPointMember[count] = Convert.ToInt32(dt.Rows[count]["Events"]);
            }
            //binding chart control  
            Chart1.Series[0].Points.DataBindXY(XPointMember, YPointMember);

            //Setting width of line  
            Chart1.Series[0].BorderWidth = 10;
            //setting Chart type   
            Chart1.Series[0].ChartType = SeriesChartType.Pie;


            foreach (Series charts in Chart1.Series)
            {
                foreach (DataPoint point in charts.Points)
                {
                    switch (point.AxisLabel)
                    {
                        case "Q1": point.Color = Color.RoyalBlue; break;
                        case "Q2": point.Color = Color.SaddleBrown; break;
                        case "Q3": point.Color = Color.SpringGreen; break;
                    }
                    point.Label = string.Format("{0:0} - {1}", point.YValues[0], point.AxisLabel);

                }
            }

            this.Chart1.Legends.Add("Legend1");
            this.Chart1.Titles.Add("Events Chart");

            this.Chart1.Legends[0].Enabled = true;
            this.Chart1.Legends[0].Docking = System.Web.UI.DataVisualization.Charting.Docking.Bottom;
            this.Chart1.Legends[0].Alignment = System.Drawing.StringAlignment.Center;
            foreach (int yvalues in YPointMember)
            {
                this.Chart1.Series[0].LegendText = "#VALX (" + yvalues + ")";
            }
        }

    }
}
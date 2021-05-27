using SchoolApp.SchoolAppUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolApp.users
{
    public partial class attendee : System.Web.UI.Page
    {
        AppUtility util = new AppUtility();
        string assignId = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                    assignId = Convert.ToString(Request.QueryString["id"]);

                CallBindGrid();
            }
        }
        protected void CallBindGrid()
        {
            if (Request.QueryString["id"] != null)
                assignId = Convert.ToString(Request.QueryString["id"]);

            List<AppKeyValueParam> lst = new List<AppKeyValueParam>()
                {
                    new AppKeyValueParam()
                    {
                        keyfield="@RequestType",
                        valfield="GetAll"
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@EAAddedBy",
                        valfield= Convert.ToString(Session["UEmail"])
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@EMID",
                        valfield= assignId
                    }
                };
            BindData(lst);
        }

        protected void Search_ServerClick(object sender, EventArgs e)
        {
            try
            {
                if (Request.QueryString["id"] != null)
                    assignId = Convert.ToString(Request.QueryString["id"]);

                List<AppKeyValueParam> lst = new List<AppKeyValueParam>()
                {
                    new AppKeyValueParam()
                    {
                        keyfield="@RequestType",
                        valfield="GetAll"
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@EAAddedBy",
                        valfield= Convert.ToString(Session["UEmail"])
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@EAName",
                        valfield= txtSearch.Text.Trim()
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@EMID",
                        valfield= assignId
                    }
                };
                BindData(lst);
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
                errordiv.Visible = true;
            }
        }
        protected void BindData(List<AppKeyValueParam> lst)
        {
            try
            {
                if (Request.QueryString["id"] != null)
                    assignId = Convert.ToString(Request.QueryString["id"]);

                AppUtility util = new AppUtility();

                DataTable dt = new DataTable();

                dt = util.getdata("SPAttendee", lst);

                if (dt.Rows.Count > 0)
                {
                    lblError.Text = "";
                    errordiv.Visible = false;

                    Repeater1.DataSource = dt;
                    Repeater1.DataBind();
                }
                else
                {
                    Repeater1.DataSource = null;
                    Repeater1.DataBind();

                    lblError.Text = "No Record found.";
                    errordiv.Attributes.Remove("class");
                    errordiv.Attributes.Add("class", "alert alert-primary");
                    errordiv.Visible = true;
                }
            }
            catch (Exception)
            {
                throw;
            }
        }
       
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                foreach (RepeaterItem liItem in Repeater1.Items)
                {
                    CheckBox chkCheck = liItem.FindControl("chkCheck") as CheckBox;
                    if (chkCheck.Checked)
                    {
                        string lblEAID = Convert.ToString((liItem.FindControl("Label2") as Label).Text);


                        List<AppKeyValueParam> lst = new List<AppKeyValueParam>()
                            {
                            new AppKeyValueParam()
                            {
                                keyfield="@RequestType",
                                valfield="delete"
                            },
                            new AppKeyValueParam()
                            {
                                keyfield="@EAID",
                                valfield=lblEAID
                            }
                        };
                        util.save("SPAttendee", lst);
                    }
                }  

                if (Request.QueryString["id"] != null)
                    assignId = Convert.ToString(Request.QueryString["id"]);

                CallBindGrid(); 
                
                lblError.Text = "Selected rows deleted!!!";
                errordiv.Attributes.Remove("class");
                errordiv.Attributes.Add("class", "alert alert-danger");
                errordiv.Visible = true;
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
                errordiv.Visible = true;
            }
        }
    }
}
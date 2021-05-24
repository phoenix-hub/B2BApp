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
    public partial class users : System.Web.UI.MasterPage
    {
        AppUtility util;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UEmail"] == null)
            {
                Response.Redirect("~/login");
            }
            if (!IsPostBack)
            {
                string _userrole = Convert.ToString(Session["Role"]);
                if (!string.IsNullOrEmpty(_userrole))
                { 
                    string _strIsActive = Convert.ToString(Request.QueryString["isactive"]);
                    ActiveLink(_strIsActive, _userrole);
                }
                else { Response.Redirect("~/login"); }
                BindUser();
            }
        }

        private void ActiveLink(string _strIsActive, string _role)
        {
            try
            {
                if (string.IsNullOrEmpty(_strIsActive))
                {
                    _strIsActive = "dashboard";
                }
                HyperLink lnkdashboard = (HyperLink)this.FindControl("lnkdashboard");
                HyperLink lnkevents = (HyperLink)this.FindControl("lnkevents");
                HyperLink lnkattendee = (HyperLink)this.FindControl("lnkattendee");
                HyperLink lnkassignevent = (HyperLink)this.FindControl("lnkassignevent");
                HyperLink lnkinquiry = (HyperLink)this.FindControl("lnkinquiry");
                HyperLink lnkusers = (HyperLink)this.FindControl("lnkusers");
                //HyperLink lnkpasswordreset = (HyperLink)this.FindControl("lnkresetpassword");

                SetActiveLink(ref lnkdashboard, _strIsActive);
                SetActiveLink(ref lnkevents, _strIsActive);
                SetActiveLink(ref lnkinquiry, _strIsActive);
                //SetActiveLink(ref lnkpasswordreset, _strIsActive);

                if (_role.ToLower().Equals( "admin"))
                {
                    lnkattendee.Visible = false;
                    lnkassignevent.Visible = false;
                    lnkusers.Visible = true;
                    SetActiveLink(ref lnkusers, _strIsActive);
                    SetActiveLink(ref lnkattendee, _strIsActive);
                    //SetActiveLink(ref lnkassignevent, _strIsActive);
                }
                else
                {
                    lnkusers.Visible = false;
                    lnkattendee.Visible = false;
                    lnkassignevent.Visible = false;
                }
            }
            catch (Exception ex)
            {
                //throw;
            }
        }
        protected void SetActiveLink(ref HyperLink links, string isactive)
        {
            if (links.NavigateUrl.Contains(isactive))
            {
                links.Attributes.Remove("class");
                links.Attributes.Add("class", "nav-item nav-link active");
            }
            else
            {
                links.Attributes.Remove("class");
                links.Attributes.Add("class", "nav-item nav-link");
            }
        }

        private void BindUser()
        {
            try
            {
                util = new AppUtility();

                List<AppKeyValueParam> lst = new List<AppKeyValueParam>()
                {
                    new AppKeyValueParam()
                    {
                        keyfield="@UEmail",
                        valfield=Session["UEmail"].ToString()
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@RequestType",
                        valfield="GetMyMailId"
                    }
                };


                DataTable dt = new DataTable();

                dt = util.getdata("SPUser", lst);
                if (dt.Rows.Count > 0)
                {
                    lblName.Text = dt.Rows[0]["UCPName"].ToString();
                    lblEmail.Text = dt.Rows[0]["UEmail"].ToString();
                    lblLoginName.Text = string.Format("<spam style='color: white;'>Welcome :</spam> <spam style='color: white;font-weight: 900; font-style: oblique; '>{0}</spam>", Convert.ToString(dt.Rows[0]["UCPName"]));
                }
            }
            catch (Exception ex)
            {
                //lblError.Text = ex.Message;
                //errordiv.Visible = true;
            }
            finally
            {
                GC.Collect();
            }
        }

        protected void btnLogOut_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Session.Remove("username");
            Session.Remove("name");
            Session.Remove("role");
            Response.Redirect("~/Login.aspx");
        }
    }
}
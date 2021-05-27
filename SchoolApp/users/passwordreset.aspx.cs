using SchoolApp.SchoolAppUtility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolApp.users
{
    public partial class passwordreset : System.Web.UI.Page
    {
        AppUtility util = new AppUtility();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (string.IsNullOrEmpty(Convert.ToString(Session["UEmail"])))
                {
                    Response.Redirect("../login.aspx");
                }
                txtEmail.Text = Convert.ToString(Session["UEmail"]);
            }
        }

        protected void Save_ServerClick(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(txtCurrPassword.Text))
                {
                    throw new Exception("Please enter Current Password.");
                }
                if (!MatchPassword())
                {
                    throw new Exception("Current password does not matched with existing password. Please contact to admin or try again later.");
                }
                if (string.IsNullOrEmpty(txtNewPassword.Text))
                {
                    throw new Exception("Please enter New Password.");
                }
                if (string.IsNullOrEmpty(txtConfirmPassword.Text))
                {
                    throw new Exception("Please enter Confirm Password.");
                }
                if (txtConfirmPassword.Text.Trim() != txtNewPassword.Text.Trim())
                {
                    throw new Exception("New password and confirm password does not matched.");
                }
                List<AppKeyValueParam> prmList = new List<AppKeyValueParam>()
                {
                    new AppKeyValueParam()
                    {
                        keyfield = "@RequestType",
                        valfield = "passwordreset"
                    },
                    new AppKeyValueParam()
                    {
                        keyfield = "@UEmail",
                        valfield = Convert.ToString(Session["UEmail"])
                    },
                    new AppKeyValueParam()
                    {
                        keyfield = "@UPwd",
                        valfield = txtNewPassword.Text.Trim()
                    },
                    new AppKeyValueParam()
                    {
                        keyfield = "@UMdBy",
                        valfield = Convert.ToString(Session["UEmail"])
                    }
                };
                int affectedRows = util.save("SPUser", prmList);

                if (affectedRows > 0)
                {
                    lblError.Text = "Password reset successfully.";
                    errordiv.Attributes.Remove("class");
                    errordiv.Attributes.Add("class", "alert alert-success");
                    errordiv.Visible = true;
                }
                else
                {
                    lblError.Text = "Something went wrong. Please contact to admin or try again later.";
                    errordiv.Attributes.Remove("class");
                    errordiv.Attributes.Add("class", "alert alert-danger");
                    errordiv.Visible = true;
                }
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
                errordiv.Visible = true;
            }
        }

        protected bool MatchPassword()
        {
            string getvalue = string.Empty;
            bool isMatched = false;
            try
            {
                List<AppKeyValueParam> prmList = new List<AppKeyValueParam>()
                {
                    new AppKeyValueParam()
                    {
                        keyfield = "@RequestType",
                        valfield = "GetMyPWD"
                    },
                    new AppKeyValueParam()
                    {
                        keyfield = "@UEmail",
                        valfield = Convert.ToString(Session["UEmail"])
                    }
                };
                getvalue = util.GetScalerValue("SPUser", prmList);

                if (getvalue == txtCurrPassword.Text.Trim())
                {
                    isMatched = true;
                }
                else
                {
                    isMatched = false;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return isMatched;
        }
    }
}
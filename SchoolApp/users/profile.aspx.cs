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
    public partial class profile : System.Web.UI.Page
    {
        public string _userUEmail;
        public string _userrole;
        AppUtility util;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                _userUEmail = Convert.ToString(Session["UEmail"]);
                BindUser(_userUEmail);

                _userrole = Convert.ToString(Session["Role"]);
                if (!string.IsNullOrEmpty(_userrole))
                {
                    if (_userrole.ToLower().Equals("user"))
                    {
                        //divbtn.Visible = false;
                        DisablePageControls(false, _userrole);
                    }
                }
            }
        }
        public void DisablePageControls(bool status, string _role)
        {
            txtUCName.ReadOnly = status;
            txtUCPName.ReadOnly = status;
            txtUMobile.ReadOnly = status;
            txtUPhone.ReadOnly = status;
            txtUOffAdd.ReadOnly = status;
            txtUCity.ReadOnly = status;
            fileUTlicns.Enabled = status == true ? false : true;
            txtUEmail.ReadOnly = status == true ? false : true;
            drpURole.Enabled = false;

            //if (_role == "admin") { drpURole.Enabled = status == true ? false : true; }
            //else { drpURole.Enabled = status; }
        }
        protected void BindUser(string _userUEmail)
        {
            try
            {
                util = new AppUtility();

                List<AppKeyValueParam> lst = new List<AppKeyValueParam>()
                {
                    new AppKeyValueParam()
                    {
                        keyfield="@UEmail",
                        valfield=_userUEmail
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@RequestType",
                        valfield="GetOne"
                    }
                };

                DataTable dt = new DataTable();

                dt = util.getdata("SPUser", lst);
                if (dt.Rows.Count > 0)
                {
                    txtUCName.Text = dt.Rows[0]["UCName"].ToString();
                    txtUCPName.Text = dt.Rows[0]["UCPName"].ToString();
                    txtUPhone.Text = dt.Rows[0]["UPhone"].ToString();
                    txtUMobile.Text = dt.Rows[0]["UMobile"].ToString();
                    txtUCity.Text = dt.Rows[0]["UCity"].ToString();
                    txtUOffAdd.Text = dt.Rows[0]["UOffAdd"].ToString();
                    txtUEmail.Text = dt.Rows[0]["UEmail"].ToString();
                    //txtUTlicns.Text = dt.Rows[0]["UTlicns"].ToString();
                    drpURole.Items.FindByValue(dt.Rows[0]["URole"].ToString().ToLower()).Selected = true;
                }
            }
            catch (Exception ex)
            {

            }
            finally
            {
                GC.Collect();
            }
        }

        protected void Cancel_ServerClick(object sender, EventArgs e)
        {
            
        }

        protected void Save_ServerClick(object sender, EventArgs e)
        {
            try
            {
                ValidateForm();

                util = new AppUtility();

                List<AppKeyValueParam> lst = new List<AppKeyValueParam>()
                {
                    new AppKeyValueParam()
                    {
                        keyfield="@UCName",
                        valfield=txtUCName.Text.Trim()
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@UCPName",
                        valfield=txtUCPName.Text.Trim()
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@UPhone",
                        valfield=txtUPhone.Text.Trim()
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@UMobile",
                        valfield=txtUMobile.Text.Trim()
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@UCity",
                        valfield=txtUCity.Text.Trim()
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@UOffAdd",
                        valfield=txtUOffAdd.Text.Trim()
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@UEmail",
                        valfield=txtUEmail.Text.Trim()
                    },
                    //new AppKeyValueParam()
                    //{
                    //    keyfield="@UTlicns",
                    //    valfield=txtUTlicns.Text.Trim()
                    //},
                    new AppKeyValueParam()
                    {
                        keyfield="@UMdBy",
                        valfield=Convert.ToString(Session["UEmail"])
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@RequestType",
                        valfield="Update"
                    }
                };

                int issave = util.save("SPUser", lst);
                if (issave > 0)
                {
                    errordiv.Attributes.Remove("class");
                    errordiv.Attributes.Add("class", "alert alert-success");
                    lblError.Text = "Successfully updated.";
                    errordiv.Visible = true;
                }
                else
                {
                    throw new Exception("Something went wrong. Please try again later or contact to admin.");
                }
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
                errordiv.Visible = true;
            }
            finally
            {
                GC.Collect();
            }
        }
        protected void ValidateForm()
        {
            try
            {
                if (string.IsNullOrEmpty(txtUCName.Text))
                {
                    throw new Exception("Please enter Please enter Company Name.");
                }
                else if (string.IsNullOrEmpty(txtUCPName.Text))
                {
                    throw new Exception("Please enter User Contact Person Name.");
                }
                else if (drpURole.SelectedValue.ToLower() == "select")
                {
                    throw new Exception("Please select User Role.");
                }
                else if (string.IsNullOrEmpty(txtUMobile.Text))
                {
                    throw new Exception("Please enter user company mobile.");
                }
                else if (string.IsNullOrEmpty(txtUPhone.Text))
                {
                    throw new Exception("Please enter user company landline number.");
                }
                else if (string.IsNullOrEmpty(txtUEmail.Text))
                {
                    throw new Exception("Please enter user email.");
                }
                else if (string.IsNullOrEmpty(txtUOffAdd.Text))
                {
                    throw new Exception("Please enter office address.");
                }
                else if (string.IsNullOrEmpty(txtUCity.Text))
                {
                    throw new Exception("Please enter City.");
                }
                //else if (string.IsNullOrEmpty(txtUTlicns.Text))
                //{
                //    throw new Exception("trade license.");
                //}
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}
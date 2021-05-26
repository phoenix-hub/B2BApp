using SchoolApp.SchoolAppUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI.WebControls;

namespace SchoolApp.users
{
    public partial class inquiry : System.Web.UI.Page
    {
        AppUtility util = new AppUtility();
        protected bool isAdmin = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblError.Text = "";
                errordiv.Visible = false;
                BindData();
            }

            if (Convert.ToString(Session["Role"]).ToLower() == "user")
                isAdmin = false;
            else
                isAdmin = true;
        }
        protected void BindData()
        {
            try
            {
                AppUtility util = new AppUtility();

                List<AppKeyValueParam> lst = new List<AppKeyValueParam>()
                {
                    new AppKeyValueParam()
                    {
                        keyfield="@RequestType",
                        valfield="GetAll"
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@User",
                        valfield=Convert.ToString(Session["UEmail"])
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@ColName",
                        valfield=drpFilter.SelectedValue
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@FilterValue",
                        valfield=Convert.ToString(txtSearch.Text.Trim())
                    }
                };


                DataTable dt = new DataTable();

                dt = util.getdata("SPEnquiry", lst);

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
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
                errordiv.Visible = true;
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindData();
        }
        protected void btnRespond_Click(object sender, EventArgs e)
        {
            ClearForm();
            btnUpdate.Text = "Update";
            lblformHeader.Text = "Edit ";
            var btn = (Button)sender;
            var item = (RepeaterItem)btn.NamingContainer;
            var ddl = (Label)item.FindControl("Label2");
            var lblStatus = (Label)item.FindControl("lblStatus");
            var lblRemarks = (Label)item.FindControl("lblRemarks");

            drpStatus.SelectedValue = lblStatus.Text.Trim();
            txtRemarks.Text = lblRemarks.Text.Trim();

            hdnUpdateid.Value = ddl.Text.Trim();

            this.ModalPopupExtender1.Show();
        }
        protected void ClearForm()
        {
            drpStatus.SelectedIndex = -1;
            txtRemarks.Text = "";
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            var btn = (Button)sender;
            var item = (RepeaterItem)btn.NamingContainer;
            var lblId = (Label)item.FindControl("Label2");
            try
            {
                List<AppKeyValueParam> prmList = new List<AppKeyValueParam>()
                {
                    new AppKeyValueParam()
                    {
                        keyfield="@RequestType",
                        valfield="delete"
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@EEID",
                        valfield= lblId.Text.Trim()
                    }
                };

                string result = Operation("SPEnquiry", prmList);

                if (result == "Ok")
                {
                    lblError.Text = "Record Deleted.";
                    errordiv.Attributes.Remove("class");
                    errordiv.Attributes.Add("class", "alert alert-success");
                    errordiv.Visible = true;
                }
                else
                {
                    lblError.Text = "Something went wrong. Please contact to admin.";
                    errordiv.Attributes.Remove("class");
                    errordiv.Attributes.Add("class", "alert alert-danger");
                    errordiv.Visible = true;
                }
                BindData();
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
                errordiv.Attributes.Remove("class");
                errordiv.Attributes.Add("class", "alert alert-danger");
                errordiv.Visible = true;
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                string reqtype = string.Empty;

                if (hdnUpdateid.Value == "0")
                {
                    reqtype = "add";
                }
                else
                {
                    reqtype = "update";
                }

                List<AppKeyValueParam> prmList = new List<AppKeyValueParam>()
                {
                    new AppKeyValueParam()
                    {
                        keyfield="@RequestType",
                        valfield=reqtype
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@EEID",
                        valfield= hdnUpdateid.Value
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@EEstatus",
                        valfield= drpStatus.SelectedValue.Trim()
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@EERemark",
                        valfield= txtRemarks.Text.Trim()
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@User",
                        valfield= Convert.ToString(Session["UEmail"])
                    }
                };

                string result = Operation("SPEnquiry", prmList);

                if (result == "Ok")
                {
                    if (hdnUpdateid.Value == "0")
                    {
                        lblError.Text = "Inquiry Saved.";
                    }
                    else
                    {
                        lblError.Text = "Inquiry Updated.";
                    }
                    errordiv.Attributes.Remove("class");
                    errordiv.Attributes.Add("class", "alert alert-success");
                    errordiv.Visible = true;
                    hdnUpdateid.Value = "0";
                }
                else
                {
                    lblError.Text = "Something went wrong. Please contact to admin.";
                    errordiv.Attributes.Remove("class");
                    errordiv.Attributes.Add("class", "alert alert-danger");
                    errordiv.Visible = true;
                }
                BindData();
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
                errordiv.Attributes.Remove("class");
                errordiv.Attributes.Add("class", "alert alert-danger");
                errordiv.Visible = true;
            }
        }


        protected string Operation(string procName, List<AppKeyValueParam> prmList)
        {
            try
            {
                int resutlCount = util.save(procName, prmList);

                if (resutlCount > 0)
                {
                    return "Ok";
                }
                else
                {
                    return "Wrong";
                }
            }
            catch (Exception ex)
            {
                return ex.ToString();
            }
        }
    }
}
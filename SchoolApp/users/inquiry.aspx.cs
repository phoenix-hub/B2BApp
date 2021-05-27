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

            var lblCompanyName = (Label)item.FindControl("EECname");
            var lblCompanyPName = (Label)item.FindControl("EECPName");
            var lblMobile = (Label)item.FindControl("EECNumber");
            var lblemail = (Label)item.FindControl("EEEmail");
            var lblMessage = (Label)item.FindControl("EEMessage");


            #region Bind Form

            drpStatus.SelectedValue = lblStatus.Text.Trim();
            txtRemarks.Text = lblRemarks.Text.Trim();

            CompanyName.Text = lblCompanyName.Text.Trim();
            CompanyPName.Text = lblCompanyPName.Text.Trim();
            Mobile.Text = lblMobile.Text.Trim();
            Mobile.Text = lblMobile.Text.Trim();
            email.Text = lblemail.Text.Trim();
            Message.Text = lblMessage.Text.Trim();
            #endregion

            CompanyName.ReadOnly = true;
            CompanyPName.ReadOnly = true;
            Mobile.ReadOnly = true;
            email.ReadOnly = true;
            Message.ReadOnly = true;

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
            try
            {
                int affectedRows = 0;

                foreach (RepeaterItem liItem in Repeater1.Items)
                {
                    CheckBox chkCheck = liItem.FindControl("chkCheck") as CheckBox;
                    if (chkCheck.Checked)
                    {
                        affectedRows += affectedRows + 1;

                        string lblEEID = Convert.ToString((liItem.FindControl("Label2") as Label).Text);

                        List<AppKeyValueParam> lst = new List<AppKeyValueParam>()
                            {
                           new AppKeyValueParam()
                                {
                                    keyfield="@RequestType",
                                    valfield="delete"
                                },
                                new AppKeyValueParam()
                                {
                                    keyfield="@EEID",
                                    valfield= lblEEID
                                }
                            };
                        util.save("SPEnquiry", lst);
                    }
                }

                if (affectedRows == 0)
                {
                    throw new Exception("Please select any row to delete.");
                }

                lblError.Text = "Selected rows deleted!!!";
                errordiv.Attributes.Remove("class");
                errordiv.Attributes.Add("class", "alert alert-danger");
                errordiv.Visible = true;

                BindData();
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
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
                    },



                    new AppKeyValueParam()
                    {
                        keyfield="@EECname",
                        valfield= CompanyName.Text.Trim()
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@EECPName",
                        valfield= CompanyPName.Text.Trim()
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@EECNumber",
                        valfield= Mobile.Text.Trim()
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@EEEmail",
                        valfield= email.Text.Trim()
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@EEMessage",
                        valfield= Message.Text.Trim()
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
        protected void OnItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            //if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            //{
            //    RepeaterItem item = e.Item;

            //    //Reference the Controls.
            //    string lblRemarks = (item.FindControl("lblRemarks") as Label).Text;
            //    if (string.IsNullOrEmpty(lblRemarks) || string.IsNullOrWhiteSpace(lblRemarks))
            //    {

            //    }
            //}
        }
        protected void btnClosePanelIcon_Click(object sender, EventArgs e)
        {
            ClearForm();
            ModalPopupExtender1.Hide();
        }


        protected void btnAddInquiry_Click(object sender, EventArgs e)
        {
            ClearForm();
            hdnUpdateid.Value = "0";

            btnUpdate.Text = "Save";
            lblformHeader.Text = "Add ";

            CompanyName.ReadOnly = false;
            CompanyPName.ReadOnly = false;
            Mobile.ReadOnly = false;
            email.ReadOnly = false;
            Message.ReadOnly = false;

            CompanyName.Text = "";
            CompanyPName.Text = "";
            Mobile.Text = "";
            email.Text = "";
            Message.Text = "";

            drpStatus.SelectedValue = "In-Progress";
            txtRemarks.Text = "";
            ModalPopupExtender1.Show();
        }
    }
}
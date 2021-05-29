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
    public partial class forgotpassword : System.Web.UI.Page
    {

        AppUtility util = new AppUtility();
        List<AppKeyValueParam> lst;
        DataTable dt = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Convert.ToString(Session["Role"]).ToLower() == "user")
                    Response.Redirect("dashboard");

                errordiv.Visible = false;
                BindData();
            }
        }
        protected void BindData()
        {
            try
            {
                lst = new List<AppKeyValueParam>();
                lst.Add(new AppKeyValueParam { keyfield = "@RequestType", valfield = "getall" });
                lst.Add(new AppKeyValueParam { keyfield = "@User", valfield = Convert.ToString(Session["UEmail"]) });
                lst.Add(new AppKeyValueParam { keyfield = "@id", valfield = "0" });
                lst.Add(new AppKeyValueParam { keyfield = "@ColName", valfield = drpFilter.SelectedValue });
                lst.Add(new AppKeyValueParam { keyfield = "@FilterValue", valfield = Convert.ToString(txtSearch.Text.Trim()) });

                dt = util.getdata("SpCredentialsResetRequest", lst);

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
        protected void btnEditRow_Click(object sender, EventArgs e)
        {
            ClearForm();
            btnUpdate.Text = "Update";
            lblformHeader.Text = "Edit ";
            var btn = (Button)sender;
            var item = (RepeaterItem)btn.NamingContainer;
            var ddl = (Label)item.FindControl("Label2");
            var lblStatus = (Label)item.FindControl("lblStatus");
            var lblRemarks = (Label)item.FindControl("lblRemarks");
            var lblEmail = (Label)item.FindControl("lblemail");

            #region Bind Form
            hdnUpdateid.Value = ddl.Text.Trim();
            drpStatus.SelectedValue = lblStatus.Text.Trim().ToLower();
            txtEmail.Text = lblEmail.Text.Trim();
            txtRemarks.Text = lblRemarks.Text.Trim();
            #endregion

            txtEmail.ReadOnly = true;

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

                        lst = new List<AppKeyValueParam>();
                        lst.Add(new AppKeyValueParam { keyfield = "@RequestType", valfield = "delete" });
                        lst.Add(new AppKeyValueParam { keyfield = "@id", valfield = lblEEID });

                        util.save("SpCredentialsResetRequest", lst);
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
                if (IsFormValid())
                {
                    lst = new List<AppKeyValueParam>();

                    lst.Add(new AppKeyValueParam { keyfield = "@updatedby", valfield = Convert.ToString(Session["UEmail"]) });
                    reqtype = "update";

                    lst.Add(new AppKeyValueParam { keyfield = "@RequestType", valfield = reqtype });
                    lst.Add(new AppKeyValueParam { keyfield = "@id", valfield = hdnUpdateid.Value });
                    lst.Add(new AppKeyValueParam { keyfield = "@Pwd", valfield = txtPassword.Text.Trim() });
                    lst.Add(new AppKeyValueParam { keyfield = "@status", valfield = drpStatus.SelectedValue.Trim() });
                    lst.Add(new AppKeyValueParam { keyfield = "@remarks", valfield = txtRemarks.Text.Trim() });
                    lst.Add(new AppKeyValueParam { keyfield = "@email", valfield = txtEmail.Text.Trim() });


                    string result = Operation("SpCredentialsResetRequest", lst);

                    if (result == "Ok")
                    {
                        lblError.Text = "Updated.";
                        errordiv.Attributes.Remove("class");
                        errordiv.Attributes.Add("class", "alert alert-success");
                        errordiv.Visible = true;
                        hdnUpdateid.Value = "0";
                    }
                    else
                    {
                        throw new Exception("Something went wrong. Please contact to admin.");
                    }
                }
                BindData();
            }
            catch (Exception ex)
            {
                lblErrorForm.Text = ex.Message;
                errordivForm.Attributes.Remove("class");
                errordivForm.Attributes.Add("class", "alert alert-danger");
                errordivForm.Visible = true;
                this.ModalPopupExtender1.Show();
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
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                RepeaterItem item = e.Item;

                string lblstatus = (item.FindControl("lblstatus") as Label).Text;
                Button btnEditRow = (Button)item.FindControl("btnEditRow");
                if (lblstatus.ToLower() == "done")
                {
                    btnEditRow.Enabled = false;
                    btnEditRow.Attributes.Remove("class");
                    btnEditRow.Attributes.Add("class", "btn btn-light btn-lg disabled");
                }
                else
                {
                    btnEditRow.Enabled = true;
                    btnEditRow.Attributes.Remove("class");
                    btnEditRow.Attributes.Add("class", "btn btn-info");
                }
            }
        }

        protected bool IsFormValid()
        {
            bool isvalid = false;
            try
            {
                if (drpStatus.SelectedIndex == -1)
                {
                    throw new Exception("Please select Status.");
                }
                if (string.IsNullOrEmpty(txtRemarks.Text.Trim()))
                {
                    throw new Exception("Please enter your justification.");
                }
                if (string.IsNullOrEmpty(txtPassword.Text))
                {
                    throw new Exception("Please enter password.");
                }
                if (string.IsNullOrEmpty(txtConfirmPassword.Text))
                {
                    throw new Exception("Please enter Confirm Password.");
                }
                if (!(txtPassword.Text).Equals(txtConfirmPassword.Text))
                {
                    throw new Exception("Password and confirm password does not matched.");
                }

                isvalid = true;
            }
            catch (Exception ex)
            {
                isvalid = false;
                throw ex;
            }
            return isvalid;
        }

        protected void btnClosePanelIcon_Click(object sender, EventArgs e)
        {
            Response.Redirect("forgotpassword?isactive=forgotpassword");
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("forgotpassword?isactive=forgotpassword");
        }

    }
}
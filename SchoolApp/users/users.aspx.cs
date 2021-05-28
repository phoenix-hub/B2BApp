using SchoolApp.SchoolAppUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Web.UI.WebControls;

namespace SchoolApp.users
{
    public partial class users1 : System.Web.UI.Page
    {
        public string _userUEmail;
        public string _userrole;

        protected bool isFileExists = false;
        protected bool isOperationAdd = false;

        AppUtility util = new AppUtility();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ViewState["SortOrder"] = " ASC";
                binddata("UCName", Convert.ToString(ViewState["SortOrder"]));
            }
        }
        protected void btnEdit_Click(object sender, EventArgs e)
        {
            isOperationAdd = false;

            lblformHeader.Text = "Edit";
            Save.InnerText = "Update";
            var btn = (Button)sender;
            var item = (RepeaterItem)btn.NamingContainer;
            var lblUID = (Label)item.FindControl("Label2");
            hdnUpdateid.Value = lblUID.Text.Trim();
            var hdnEmailId = (HiddenField)item.FindControl("hdnEmailId");

            List<AppKeyValueParam> lst = new List<AppKeyValueParam>();

            lst.Add(new AppKeyValueParam { keyfield = "@RequestType", valfield = "GetMyUID" });
            lst.Add(new AppKeyValueParam { keyfield = "@UEmail", valfield = hdnEmailId.Value });
            lst.Add(new AppKeyValueParam { keyfield = "@UID", valfield = lblUID.Text.Trim() });

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

                if (Convert.ToString(Session["UEmail"]).Equals(Convert.ToString(dt.Rows[0]["UEmail"])))
                {
                    txtUEmail.ReadOnly = true;
                }
                else
                {
                    txtUEmail.ReadOnly = false;
                }
                drpURole.SelectedValue = dt.Rows[0]["URole"].ToString().ToLower();
                //drpURole.Items.FindByValue(dt.Rows[0]["URole"].ToString().ToLower()).Selected = true;
                drpURole.Enabled = false;
                if (!string.IsNullOrEmpty(Convert.ToString(dt.Rows[0]["UTlicns"])))
                {
                    isFileExists = true;
                    linkbaner.NavigateUrl = @"~\Content\TradeLicense\" + Convert.ToString(dt.Rows[0]["UTlicns"]);
                }
                else
                {
                    isFileExists = false;
                }
            }
            this.ModalPopupExtender1.Show();
        }

        protected void ClearForm()
        {
            txtUCName.Text = "";
            txtUCPName.Text = "";
            drpURole.SelectedValue = "user";
            txtUMobile.Text = "";
            txtUPhone.Text = "";
            txtUEmail.Text = "";
            txtUOffAdd.Text = "";
            txtUCity.Text = "";
            txtUCity.Text = "";
            txtUCity.Text = "";
        }

        protected void Save_ServerClick(object sender, EventArgs e)
        {
            try
            {
                ValidateForm();

                util = new AppUtility();
                string reqtype = string.Empty;


                string filename = FileUploadLogic(ref fileUTlicns);
                List<AppKeyValueParam> lst = new List<AppKeyValueParam>();

                if (hdnUpdateid.Value == "0")
                {
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

                    lst.Add(new AppKeyValueParam { keyfield = "@UCrBy", valfield = Convert.ToString(Session["UEmail"]) });
                    reqtype = "add";
                }
                else
                {
                    lst.Add(new AppKeyValueParam { keyfield = "@UID", valfield = hdnUpdateid.Value });
                    lst.Add(new AppKeyValueParam { keyfield = "@UMdBy", valfield = Convert.ToString(Session["UEmail"]) });
                    reqtype = "updatetouser";
                }

                lst.Add(new AppKeyValueParam { keyfield = "@UCName", valfield = txtUCName.Text.Trim() });
                lst.Add(new AppKeyValueParam { keyfield = "@UCPName", valfield = txtUCPName.Text.Trim() });
                lst.Add(new AppKeyValueParam { keyfield = "@UPhone", valfield = txtUPhone.Text.Trim() });
                lst.Add(new AppKeyValueParam { keyfield = "@UMobile", valfield = txtUMobile.Text.Trim() });
                lst.Add(new AppKeyValueParam { keyfield = "@UCity", valfield = txtUCity.Text.Trim() });
                lst.Add(new AppKeyValueParam { keyfield = "@UOffAdd", valfield = txtUOffAdd.Text.Trim() });
                lst.Add(new AppKeyValueParam { keyfield = "@UEmail", valfield = txtUEmail.Text.Trim() });
                lst.Add(new AppKeyValueParam { keyfield = "@URole", valfield = drpURole.SelectedValue.Trim().ToLower() });
                lst.Add(new AppKeyValueParam { keyfield = "@UUName", valfield = txtUCPName.Text.Trim() });
                lst.Add(new AppKeyValueParam { keyfield = "@UTlicns", valfield = filename });

                lst.Add(new AppKeyValueParam { keyfield = "@RequestType", valfield = reqtype });

                lst.Add(new AppKeyValueParam { keyfield = "@UPwd", valfield = txtPassword.Text.Trim() });

                int issave = util.save("SPUser", lst);
                if (issave > 0)
                {
                    if (!string.IsNullOrEmpty(filename))
                    {
                        fileUTlicns.SaveAs(Server.MapPath(@"~\Content\TradeLicense\" + filename.ToString()));
                    }

                    this.ModalPopupExtender1.Hide();

                    errordiv.Attributes.Remove("class");
                    errordiv.Attributes.Add("class", "alert alert-success");
                    if (hdnUpdateid.Value == "0")
                    {
                        lblError.Text = "Successfully created.";
                    }
                    else
                    {
                        lblError.Text = "Successfully updated.";
                    }
                    errordiv.Visible = true;
                    ClearForm();

                    ViewState["SortOrder"] = " ASC";
                    binddata("UCName", Convert.ToString(ViewState["SortOrder"]));
                }
                else
                {
                    throw new Exception("Something went wrong. Please try again later or contact to admin.");
                }
            }
            catch (Exception ex)
            {
                lblErrorForm.Text = ex.Message;
                divErrorForm.Visible = true;
                this.ModalPopupExtender1.Show();
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
            }
            catch (Exception)
            {
                throw;
            }
        }

        protected string FileUploadLogic(ref FileUpload _FileUpload1)
        {
            string _fileName = string.Empty;
            try
            {
                if (_FileUpload1.HasFile)
                {
                    FileInfo fi = new FileInfo(_FileUpload1.FileName);

                    // Get file extension   
                    string extn = fi.Extension.ToLower();
                    if (!extn.Equals(".pdf") && !extn.Equals(".jpg") && !extn.Equals(".jpeg") && !extn.Equals(".png"))
                    {
                        throw new Exception("Only PDF, JPG, JPEG, PNG file accepted.");
                    }
                    string strFileName = _FileUpload1.FileName.ToString();
                    string strTimeStamp = DateTime.Now.ToString("yyyyMMddHHmmss");
                    string strExtension = Path.GetExtension(strFileName);

                    strFileName = util.RandomString(6) + "-" + strTimeStamp + strExtension;
                    _fileName = strFileName;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return _fileName;
        }


        protected void binddata(string shortkey, string shortorder)
        {


            List<AppKeyValueParam> lst = new List<AppKeyValueParam>()
                {
                    new AppKeyValueParam()
                    {
                        keyfield="@RequestType",
                        valfield="GetAll"
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@OrderBy",
                        valfield=shortkey
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@ShortOrder",
                        valfield=shortorder
                    }
                };

            DataTable dt = new DataTable();

            dt = util.getdata("SPUser", lst);

            if (dt.Rows.Count > 0)
            {
                Repeater1.DataSource = dt;
                Repeater1.DataBind();
            }
            else
            {
                Repeater1.DataSource = null;
                Repeater1.DataBind();
            }
        }
        void SortData(string SortExpression)
        {
            if (ViewState["SortOrder"] == null)
            {
                ViewState["SortOrder"] = " ASC";
            }
            else if (ViewState["SortOrder"].ToString() == " ASC")
            {
                ViewState["SortOrder"] = " DESC";
            }
            else
            {
                ViewState["SortOrder"] = " ASC";
            }

            binddata(SortExpression, Convert.ToString(ViewState["SortOrder"]));
        }

        protected void SortlnkUCNameClick(object sender, EventArgs e)
        {
            string SortField = "UCName";
            SortData(SortField);
        }

        protected void SortlnkUCPNameClick(object sender, EventArgs e)
        {
            string SortField = "UCPName";
            SortData(SortField);
        }

        protected void SortlnklandlineClick(object sender, EventArgs e)
        {
            string SortField = "UPhone";
            SortData(SortField);
        }

        protected void SortlnkmobileClick(object sender, EventArgs e)
        {
            string SortField = "UMobile";
            SortData(SortField);
        }
        protected void SortlnkemailClick(object sender, EventArgs e)
        {
            string SortField = "UEmail";
            SortData(SortField);
        }
        protected void SortlnkcityClick(object sender, EventArgs e)
        {
            string SortField = "UCity";
            SortData(SortField);
        }

        protected void Filters(string shortkey, string shortorder)
        {
            try
            {
                lblError.Text = "";
                errordiv.Visible = false;

                string colname = drpFilter.SelectedValue;
                string filtervalue = "";
                if (colname != "All" && string.IsNullOrEmpty(txtSearch.Text))
                {
                    throw new Exception("Please enter any value in search box.");
                }
                filtervalue = txtSearch.Text;

                List<AppKeyValueParam> lst = new List<AppKeyValueParam>()
                {
                    new AppKeyValueParam()
                    {
                        keyfield="@RequestType",
                        valfield="GetFiltered"
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@ColName",
                        valfield=colname
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@FilterValue",
                        valfield=filtervalue
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@OrderBy",
                        valfield=shortkey
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@ShortOrder",
                        valfield=shortorder
                    }
                };

                DataTable dt = new DataTable();

                dt = util.getdata("SPUser", lst);

                if (dt.Rows.Count > 0)
                {
                    Repeater1.DataSource = dt;
                    Repeater1.DataBind();
                }
                else
                {
                    Repeater1.DataSource = null;
                    Repeater1.DataBind();
                    lblError.Text = "No Record found.";
                    errordiv.Visible = true;
                }
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
                errordiv.Visible = true;
            }
        }
        protected void Search_ServerClick(object sender, EventArgs e)
        {
            ViewState["SortOrder"] = " ASC";
            Filters("UCName", Convert.ToString(ViewState["SortOrder"]));
        }

        protected void btnShowPopupAdd_Click(object sender, EventArgs e)
        {
            lblformHeader.Text = "New";
            ClearForm();
            drpURole.SelectedValue = "user";
            hdnUpdateid.Value = "0";
            drpURole.Enabled = false;
            Save.InnerText = "Create";
            isOperationAdd = true;
            this.ModalPopupExtender3.Show();
        }
    }
}
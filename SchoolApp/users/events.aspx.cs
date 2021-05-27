using SchoolApp.SchoolAppUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web.UI.WebControls;

namespace SchoolApp.users
{
    public partial class events : System.Web.UI.Page
    {
        AppUtility util = new AppUtility();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ClearForm();
                linkbaner.Visible = false;
                ViewState["SortOrder"] = " ASC";
                binddata("EMName", Convert.ToString(ViewState["SortOrder"]));
            }
        }
        protected void btnShow_Click(object sender, EventArgs e)
        {
            lblformHeader.Text = "Edit";
            Save.Text = "Update";
            var btn = (Button)sender;
            var item = (RepeaterItem)btn.NamingContainer;
            var lblEMId = (Label)item.FindControl("lblEMID");
            hdnEditRowValue.Value = lblEMId.Text;

            #region Bind Controls for edit operations

            List<AppKeyValueParam> lst = new List<AppKeyValueParam>()
                {
                    new AppKeyValueParam()
                    {
                        keyfield="@RequestType",
                        valfield="GetOne"
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@OrderBy",
                        valfield= "EMName"
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@ShortOrder",
                        valfield= " ASC"
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@EMID",
                        valfield=lblEMId.Text
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@UCrBy",
                        valfield= Convert.ToString(Session["UEmail"])
                    }
                };

            DataTable dt = new DataTable();

            dt = util.getdata("SPEvent", lst);

            if (dt.Rows.Count > 0)
            {
                txtEMName.Text = Convert.ToString(dt.Rows[0]["EMName"]);
                drpEMType.SelectedValue = Convert.ToString(dt.Rows[0]["EMType"]);
                txtEMDescription.Text = Convert.ToString(dt.Rows[0]["EMDescription"]);
                txtEMDate.Text = Convert.ToString(dt.Rows[0]["EMDate"]);
                txtEMTime.Text = Convert.ToString(dt.Rows[0]["EMTime"]);
                txtEMMaxCap.Text = Convert.ToString(dt.Rows[0]["EMMaxCap"]);
                txtEMCity.Text = Convert.ToString(dt.Rows[0]["EMCity"]);
                txtEMArea.Text = Convert.ToString(dt.Rows[0]["EMArea"]);
                txtEMLocDesc.Text = Convert.ToString(dt.Rows[0]["EMLocDesc"]);
                txtEMLocLink.Text = Convert.ToString(dt.Rows[0]["EMLocLink"]);
                txtEMCode.Text = Convert.ToString(dt.Rows[0]["EMCode"]);
                txtEMStsID.Text = Convert.ToString(dt.Rows[0]["EMStsID"]);

                string imagBaner = Convert.ToString(dt.Rows[0]["EMCoverImg"]);

                if (!string.IsNullOrEmpty(imagBaner) && !string.IsNullOrWhiteSpace(imagBaner))
                {
                    linkbaner.NavigateUrl = @"~\Content\Banner\" + Convert.ToString(dt.Rows[0]["EMCoverImg"]);
                    linkbaner.Visible = true;
                }
                else
                {
                    linkbaner.Visible = false;
                }
            }

            #endregion

            this.ModalPopupExtender1.Show();
        }
        protected string FileUploadLogic(ref FileUpload _FileUpload1)
        {
            string _fileName = string.Empty;
            try
            {
                string strFileName = _FileUpload1.FileName.ToString();
                string strTimeStamp = DateTime.Now.ToString("yyyyMMddHHmmss");
                string strExtension = Path.GetExtension(strFileName);

                strFileName = util.RandomString(6) + "-" + strTimeStamp + strExtension;
                _fileName = strFileName;
                _FileUpload1.SaveAs(Server.MapPath(@"~\Content\Banner\" + strFileName.ToString()));
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return _fileName;
        }

        protected void Save_ServerClick(object sender, EventArgs e)
        {
            ClearForm();
            lblErrorForm.Text = "";
            errordivForm.Visible = false;
            try
            {
                string _strfileUpload = string.Empty;
                if (fileEMCoverImg.HasFile)
                {
                    _strfileUpload = FileUploadLogic(ref fileEMCoverImg);
                }
                else
                {
                    _strfileUpload = "";
                }
                List<AppKeyValueParam> lst = new List<AppKeyValueParam>()
                {
                    new AppKeyValueParam()
                    {
                        keyfield="@EMName",
                        valfield=txtEMName.Text.Trim()
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@EMType",
                        valfield=drpEMType.SelectedValue
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@EMDescription",
                        valfield=txtEMDescription.Text.Trim()
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@EMDate",
                        valfield=txtEMDate.Text.Trim()
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@EMTime",
                        valfield=txtEMTime.Text.Trim()
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@EMMaxCap",
                        valfield=txtEMMaxCap.Text.Trim()
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@EMCity",
                        valfield=txtEMCity.Text.Trim()
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@EMArea",
                        valfield=txtEMArea.Text.Trim()
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@EMLocDesc",
                        valfield=txtEMLocDesc.Text.Trim()
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@EMLocLink",
                        valfield=txtEMLocLink.Text.Trim()
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@EMCode",
                        valfield=txtEMCode.Text.Trim()
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@EMStsID",
                        valfield=txtEMStsID.Text.Trim()
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@EMCoverImg",
                        valfield=_strfileUpload
                    }
                };

                string cmdtype = string.Empty;
                string operationDoneBy = string.Empty;
                string selectedRowforEdit = string.Empty;
                if (lblformHeader.Text.ToLower() == "new")
                {
                    cmdtype = "add";
                    operationDoneBy = "@UCrBy";
                    selectedRowforEdit = Convert.ToString(0);
                }
                else
                {
                    cmdtype = "update";
                    operationDoneBy = "@EMMdBy";
                    selectedRowforEdit = Convert.ToString(hdnEditRowValue.Value);
                }

                lst.Add(new AppKeyValueParam()
                {
                    keyfield = operationDoneBy,
                    valfield = Convert.ToString(Session["UEmail"])
                });

                lst.Add(new AppKeyValueParam()
                {
                    keyfield = "@EMID",
                    valfield = selectedRowforEdit
                });

                lst.Add(new AppKeyValueParam()
                {
                    keyfield = "@RequestType",
                    valfield = cmdtype
                });

                int int_Result = util.save("SPEvent", lst);

                if (int_Result > 0)
                {
                    if (cmdtype.ToLower() == "add")
                    {
                        lblError.Text = "Event Created.";
                    }
                    else
                    {
                        lblError.Text = "Event Updated.";
                    }
                    ViewState["SortOrder"] = " desc";
                    binddata("EMID", Convert.ToString(ViewState["SortOrder"]));

                    errordiv.Attributes.Remove("class");
                    errordiv.Attributes.Add("class", "alert alert-success");
                    errordiv.Visible = true;
                    errordivForm.Visible = false;

                    ClearForm();
                    this.ModalPopupExtender3.Hide();
                }
                else
                {
                    throw new Exception("Something went wrong. Please try again later or contact to admin.");
                }
            }
            catch (Exception ex)
            {
                lblErrorForm.Text = ex.Message;
                errordivForm.Visible = true;
            }
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
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@UCrBy",
                        valfield= Convert.ToString(Session["UEmail"])
                    }
                };

            DataTable dt = new DataTable();

            dt = util.getdata("SPEvent", lst);

            if (dt.Rows.Count > 0)
            {
                Repeater1.DataSource = dt;
                Repeater1.DataBind();
            }
            else
            {

                lblError.Text = "No Record found.";
                errordiv.Attributes.Remove("class");
                errordiv.Attributes.Add("class", "alert alert-primary");
                errordiv.Visible = true;

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

        protected void SortlnkEMNameClick(object sender, EventArgs e)
        {
            string SortField = "EMName";
            SortData(SortField);
        }

        protected void SortlnkEMTypeClick(object sender, EventArgs e)
        {
            string SortField = "EMType";
            SortData(SortField);
        }

        protected void SortlnkEMDescriptionClick(object sender, EventArgs e)
        {
            string SortField = "EMDescription";
            SortData(SortField);
        }

        protected void SortlnkEMMaxCapClick(object sender, EventArgs e)
        {
            string SortField = "EMMaxCap";
            SortData(SortField);
        }
        protected void SortlnkEMCityClick(object sender, EventArgs e)
        {
            string SortField = "EMCity";
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
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@UCrBy",
                        valfield= Convert.ToString(Session["UEmail"])
                    }
                };

                DataTable dt = new DataTable();

                dt = util.getdata("SPEvent", lst);

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
            Filters("EMName", Convert.ToString(ViewState["SortOrder"]));
        }

        protected void btnShowPopupAdd_Click(object sender, EventArgs e)
        {
            ClearForm();

            Save.Text = "Save";

            lblErrorForm.Text = "";
            errordivForm.Visible = false;
            lblformHeader.Text = "New";
            linkbaner.Visible = false;
            this.ModalPopupExtender3.Show();
        }

        protected void ClearForm()
        {
            txtEMArea.Text = "";
            txtEMCity.Text = "";
            txtEMCode.Text = "";
            txtEMDate.Text = "";
            txtEMDescription.Text = "";
            txtEMLocDesc.Text = "";
            txtEMLocLink.Text = "";
            txtEMMaxCap.Text = "";
            txtEMName.Text = "";
            txtEMStsID.Text = "";
            txtEMTime.Text = "";
            drpEMType.SelectedIndex = -1;
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

                        string lblEMID = Convert.ToString((liItem.FindControl("lblEMID") as Label).Text);


                        List<AppKeyValueParam> lst = new List<AppKeyValueParam>()
                            {
                            new AppKeyValueParam()
                            {
                                keyfield="@RequestType",
                                valfield="Delete"
                            },
                            new AppKeyValueParam()
                            {
                                keyfield="@EMID",
                                valfield=lblEMID
                            }
                        };
                        util.save("SPEvent", lst);
                    }
                }

                if (affectedRows == 0)
                {
                    throw new Exception("Please select any row to delete.");
                }

                ViewState["SortOrder"] = " ASC";
                binddata("EMName", Convert.ToString(ViewState["SortOrder"]));

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

        protected void btnClosePanelIcon_Click(object sender, EventArgs e)
        {
            Response.Redirect("events?isactive=events");
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("events?isactive=events");
        }
    }
}
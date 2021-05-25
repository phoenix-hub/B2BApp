using SchoolApp.SchoolAppUtility;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Common;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolApp.users
{
    public partial class assignevent : System.Web.UI.Page
    {
        AppUtility util = new AppUtility();
        string assignId = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblError.Text = "";
                errordiv.Visible = false;

                if (Request.QueryString["id"] != null)
                    assignId = Convert.ToString(Request.QueryString["id"]);

                BindPage();
            }
        }
        protected void BindPage()
        {
            try
            {
                if (Request.QueryString["id"] != null)
                    assignId = Convert.ToString(Request.QueryString["id"]);

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
                        valfield=assignId
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@UCrBy",
                        valfield=Convert.ToString(Session["UEmail"])
                    }
                };

                DataTable dt = new DataTable();

                dt = util.getdata("SPEvent", lst);

                if (dt.Rows.Count > 0)
                {
                    lblEventName.Text = Convert.ToString(dt.Rows[0]["EMName"]);
                    lblEventCreatedBy.Text = Convert.ToString(dt.Rows[0]["UCrBy"]);
                    lblEventDateTime.Text = Convert.ToString(dt.Rows[0]["EMDate"]) + " " + Convert.ToString(dt.Rows[0]["EMTime"]);
                    lblDescription.Text = Convert.ToString(dt.Rows[0]["EMDescription"]);
                    lblMaxCap.Text = Convert.ToString(dt.Rows[0]["EMMaxCap"]);

                    string imagBaner = Convert.ToString(dt.Rows[0]["EMCoverImg"]);

                    if (!string.IsNullOrEmpty(imagBaner) && !string.IsNullOrWhiteSpace(imagBaner))
                    {
                        imgBaner.ImageUrl = @"~\Content\Banner\" + Convert.ToString(dt.Rows[0]["EMCoverImg"]);
                    }
                    else
                    {
                        imgBaner.ImageUrl = "../Content/Banner/baner-default.jpg";
                    }
                }
                #endregion
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
                errordiv.Visible = true;
            }
        }

        protected void btnSingleAttendee_ServerClick(object sender, EventArgs e)
        {
            try
            {
                #region Bind Controls for edit operations
                assignId = Convert.ToString(Request.QueryString["id"]);
                List<AppKeyValueParam> lst = new List<AppKeyValueParam>()
                {
                    new AppKeyValueParam()
                    {
                        keyfield="@RequestType",
                        valfield="add"
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@EMID",
                        valfield= assignId
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@EACN",
                        valfield= txtCompanyName.Text.Trim()
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@EAName",
                        valfield=txtName.Text.Trim()
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@EAEmail",
                        valfield=txtEmailId.Text.Trim()
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@EAAddedBy",
                        valfield=Convert.ToString(Session["UEmail"])
                    }
                };

                int result = util.save("SPAttendee", lst);
                if (result > 0)
                {
                    clearSingleAttendeeForm();
                    lblError.Text = "Attendee Registered.";
                    errordiv.Attributes.Remove("class");
                    errordiv.Attributes.Add("class", "alert alert-success");
                    errordiv.Visible = true;
                }

                #endregion
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
                errordiv.Visible = true;
            }
        }
        protected void clearSingleAttendeeForm()
        {
            txtName.Text = "";
            txtEmailId.Text = "";
            txtCompanyName.Text = "";
        }


        protected void btnImportAttendeeFromFile_ServerClick(object sender, EventArgs e)
        {
            InsertExcelRecords(ref fileUTlicns);
        }

        #region Import from Excel File 
        public void InsertExcelRecords(ref FileUpload FileUpload1)
        {
            if (FileUpload1.PostedFile != null)
            {
                try
                {
                    if (Request.QueryString["id"] != null)
                        assignId = Convert.ToString(Request.QueryString["id"]);

                    string path = string.Concat(Server.MapPath(@"~/Content/BuldUpload/" + FileUpload1.FileName));
                    FileUpload1.SaveAs(path);
                    // Connection String to Excel Workbook  
                    string excelCS = string.Format("Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0};Extended Properties=Excel 8.0", path);
                    using (OleDbConnection con = new OleDbConnection(excelCS))
                    {
                        con.Open();

                        OleDbCommand com = new OleDbCommand("Select EACN,EAName,EAEmail,'" + assignId + "' as EMID,'" + Convert.ToString(Session["UEmail"]) + "' as EAAddedBy from [Sheet1$]", con);

                        OleDbDataReader dr = com.ExecuteReader();
                        using (SqlConnection sqlcon = util.GetConnection())
                        {
                            sqlcon.Open();
                            using (SqlBulkCopy bulkCopy = new SqlBulkCopy(sqlcon))
                            {
                                bulkCopy.DestinationTableName = "xyzdb.dbo.Attendee";

                                SqlBulkCopyColumnMapping EACN = new SqlBulkCopyColumnMapping("EACN", "EACN");
                                bulkCopy.ColumnMappings.Add(EACN);

                                SqlBulkCopyColumnMapping EAName = new SqlBulkCopyColumnMapping("EAName", "EAName");
                                bulkCopy.ColumnMappings.Add(EAName);

                                SqlBulkCopyColumnMapping EAEmail = new SqlBulkCopyColumnMapping("EAEmail", "EAEmail");
                                bulkCopy.ColumnMappings.Add(EAEmail);

                                SqlBulkCopyColumnMapping EMID = new SqlBulkCopyColumnMapping("EMID", "EMID");
                                bulkCopy.ColumnMappings.Add(EMID);

                                SqlBulkCopyColumnMapping EAAddedBy = new SqlBulkCopyColumnMapping("EAAddedBy", "EAAddedBy");
                                bulkCopy.ColumnMappings.Add(EAAddedBy);

                                // Write from the source to the destination.
                                try
                                {
                                    bulkCopy.WriteToServer(dr);

                                    lblError.Text = "Data Uploaded successfully.";
                                    errordiv.Attributes.Remove("class");
                                    errordiv.Attributes.Add("class", "alert alert-success");
                                    errordiv.Visible = true;
                                }
                                catch (Exception ex)
                                {
                                    throw ex;
                                }
                                finally
                                {

                                }
                            }
                        }
                        dr.Close();
                        dr.Dispose();
                    }
                    Response.Write("Upload Successfull!");
                }
                catch (Exception ex)
                {
                    lblError.Text = ex.Message;
                    errordiv.Visible = true;
                }
            }
        }
        #endregion
    }
}
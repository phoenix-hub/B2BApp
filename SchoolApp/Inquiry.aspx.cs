using SchoolApp.SchoolAppUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolApp
{
    public partial class Inquiry : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            lblError.Text = "";
            errordiv.Visible = false;

            try
            {
                if (string.IsNullOrEmpty(CompanyName.Text.Trim()))
                {
                    throw new Exception("Please enter user company name");
                }
                if (string.IsNullOrEmpty(CompanyPName.Text.Trim()))
                {
                    throw new Exception("Please enter user contact person name.");
                }
                if (string.IsNullOrEmpty(Mobile.Text.Trim()))
                {
                    throw new Exception("Please enter Mobile.");
                }
                if (string.IsNullOrEmpty(email.Text.Trim()))
                {
                    throw new Exception("Please enter email.");
                }
                if (string.IsNullOrEmpty(Message.Text.Trim()))
                {
                    throw new Exception("Please enter Message.");
                }
                AppUtility util = new AppUtility(); 

                List<AppKeyValueParam> lst = new List<AppKeyValueParam>()
                {
                    new AppKeyValueParam()
                    {
                        keyfield="@EECname",
                        valfield=CompanyName.Text.Trim()
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@EECPName",
                        valfield=CompanyPName.Text.Trim()
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@EECNumber",
                        valfield=Mobile.Text.Trim()
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@EEEmail",
                        valfield=email.Text.Trim()
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@EEMessage",
                        valfield=Message.Text.Trim()
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@EEstatus",
                        valfield="In-Progress"
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@RequestType",
                        valfield="Add"
                    }
                }; 

                int effectedRows = util.save("SPEnquiry", lst);

                if (effectedRows > 0)
                {
                    errordiv.Attributes.Remove("class");
                    errordiv.Attributes.Add("class", "alert alert-success");
                    lblError.Text = "Your request has been submitted successfully.";
                    errordiv.Visible = true;
                    resetForm();
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
        public void resetForm()
        {
            CompanyName.Text = "";
            CompanyPName.Text = "";
            Mobile.Text = "";
            email.Text = "";
            Message.Text = "";
        }
    }
}
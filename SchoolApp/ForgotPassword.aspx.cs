using SchoolApp.SchoolAppUtility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolApp
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRecover_Click(object sender, EventArgs e)
        {
            lblError.Text = "";
            errordiv.Visible = false;

            try
            {
                if (string.IsNullOrEmpty(email.Text.Trim()))
                {
                    throw new Exception("Please enter email.");
                }

                AppUtility util = new AppUtility();

                List<AppKeyValueParam> lst = new List<AppKeyValueParam>()
                {
                    new AppKeyValueParam()
                    {
                        keyfield="@email",
                        valfield=email.Text.Trim()
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@RequestType",
                        valfield="Add"
                    }
                };

                 
                int effectedRows = util.save("SpCredentialsResetRequest", lst);

                if (effectedRows > 0)
                {
                    errordiv.Attributes.Remove("class");
                    errordiv.Attributes.Add("class", "alert alert-success");
                    lblError.Text = "Your request has been submitted successfully. Admin will contact you soon.";
                    errordiv.Visible = true;
                    email.Text = "";
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
    }
}
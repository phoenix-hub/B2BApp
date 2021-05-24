using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SchoolApp.SchoolAppUtility;

namespace SchoolApp
{
    public partial class login : System.Web.UI.Page
    {
        string sqlcon = ConfigurationManager.ConnectionStrings["sqlcon"].ToString();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            lblError.Text = "";
            errordiv.Visible = false;


            try
            {
                if (string.IsNullOrEmpty(txtemail.Text.Trim()))
                {
                    throw new Exception("Please enter email id");
                }
                if (string.IsNullOrEmpty(txtpassword.Text.Trim()))
                {
                    throw new Exception("Please enter password.");
                }
                AppUtility util = new AppUtility(); 

                List<AppKeyValueParam> lst = new List<AppKeyValueParam>()
                {
                    new AppKeyValueParam()
                    {
                        keyfield="@UEmail",
                        valfield=txtemail.Text.Trim()
                    },   
                    new AppKeyValueParam()
                    {
                       
                        keyfield="@UPwd",
                        valfield=txtpassword.Text.Trim()
                    },
                    new AppKeyValueParam()
                    {
                        keyfield="@RequestType",
                        valfield="Login"
                    }
                };

               
                DataTable dt = new DataTable();

                dt = util.getdata("SPUser", lst);

                if (dt.Rows.Count > 0)
                {
                    Session["UEmail"] = dt.Rows[0]["UEmail"].ToString();
                    Session["username"] = dt.Rows[0]["UUName"].ToString();
                    Session["name"] = dt.Rows[0]["UCPName"].ToString();
                    Session["role"] = dt.Rows[0]["URole"].ToString();
                    Response.Redirect("users/dashboard");
                }
                else
                {
                    throw new Exception("Email id or password is invalid. Please enter try again with valid credentials.");
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
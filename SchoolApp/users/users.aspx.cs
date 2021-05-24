using SchoolApp.SchoolAppUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI.WebControls;

namespace SchoolApp.users
{
    public partial class users1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ViewState["SortOrder"] = " ASC";
                binddata("UCName", Convert.ToString(ViewState["SortOrder"]));
            }
        }
        protected void btnShow_Click(object sender, EventArgs e)
        {
            lblformHeader.Text = "Edit ";
            var btn = (Button)sender;
            var item = (RepeaterItem)btn.NamingContainer;
            var ddl = (Label)item.FindControl("Label2");
            this.ModalPopupExtender1.Show();
        }

        protected void Save_ServerClick(object sender, EventArgs e)
        {

            lblErrorForm.Text = "";
        }

        protected void binddata(string shortkey, string shortorder)
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

                AppUtility util = new AppUtility();

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
            lblformHeader.Text = "New ";
            this.ModalPopupExtender3.Show();
        }
    }
}
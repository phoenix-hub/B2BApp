using SchoolApp.SchoolAppUtility;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace SchoolApp.utility
{
    public class GetVisualizationData
    {
        AppUtility util;
        public GetVisualizationData()
        {
            util = new AppUtility();
        }
    }
}
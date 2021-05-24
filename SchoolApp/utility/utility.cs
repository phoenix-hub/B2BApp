using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data; 
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Linq; 

namespace SchoolApp.SchoolAppUtility
{
    public class AppKeyValueParam
    {
        public string keyfield { get; set; }
        public string valfield { get; set; }
    }
    public class AppUtility
    {  

        string sqlcon = ConfigurationManager.ConnectionStrings["sqlcon"].ToString();

        public SqlConnection GetConnection()
        {
            return new SqlConnection(ConfigurationManager.ConnectionStrings["sqlcon"].ToString()); 
        }

        private Random random = new Random();
        public string RandomString(int length)
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            return new string(Enumerable.Repeat(chars, length)
            .Select(s => s[random.Next(s.Length)]).ToArray());
        }

        public DataTable getdata(string spname, List<AppKeyValueParam> param)
        {
            try
            {
                using (var con = new SqlConnection(sqlcon))
                {
                    using (var cmd = new SqlCommand(spname, con))
                    {
                        foreach (AppKeyValueParam item in param)
                        {
                            cmd.Parameters.AddWithValue(item.keyfield.Trim(), item.valfield.Trim());
                        }

                        cmd.CommandType = CommandType.StoredProcedure;

                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();

                            con.Open();
                            da.Fill(dt);
                            con.Close();

                            return dt;
                        }
                    }
                }
            }
            catch (Exception)
            {
                return null;
            }
        }
        public int save(string spname, List<AppKeyValueParam> param)
        {
            try
            {
                using (var con = new SqlConnection(sqlcon))
                {
                    using (var cmd = new SqlCommand(spname, con))
                    {
                        foreach (AppKeyValueParam item in param)
                        {
                            cmd.Parameters.AddWithValue(item.keyfield.ToString(), item.valfield.ToString().Trim());
                        }

                        cmd.CommandType = CommandType.StoredProcedure;

                        con.Open();
                        int effectedRows = cmd.ExecuteNonQuery();
                        con.Close();

                        return effectedRows;
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
         
    }
}
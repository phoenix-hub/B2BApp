<%@ Page Title="" Language="C#" MasterPageFile="~/users/users.Master" AutoEventWireup="true" CodeBehind="passwordreset.aspx.cs" Inherits="SchoolApp.users.passwordreset" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="../Scripts/WebForms/Users/users-profile.css" rel="stylesheet" />
    <style>
        .btn-secondary {
            color: #fff !important;
            background-color: #b23cfd !important;
            border-color: #b23cfd !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div class="container rounded bg-white mt-5 mb-5">
        <div class="row" style="margin: 0 0 20px 0; text-transform: capitalize;" runat="server" id="divform">
            <div class="col-md-12 ">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h4 class="text-right">Password Reset</h4>
                </div>


                <div class="row">
                    <div class="col col-10">

                        <div class="form-group row">
                            <label for="inputEmail3" class="col-sm-6 col-form-label">Email</label>
                            <div class="col-sm-6">
                                <input type="email" class="form-control" id="inputEmail3" disabled placeholder="Email">
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="inputPassword3" class="col-sm-6 col-form-label">Current Password</label>
                            <div class="col-sm-6">
                                <input type="password" class="form-control" id="inputPassword3" placeholder="Password">
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="inputPassword3" class="col-sm-6 col-form-label">New Password</label>
                            <div class="col-sm-6">
                                <input type="password" class="form-control" id="inputPassword3" placeholder="Password">
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="inputPassword3" class="col-sm-6 col-form-label">Confirm Password</label>
                            <div class="col-sm-6">
                                <input type="password" class="form-control" id="inputPassword3" placeholder="Password">
                            </div>
                        </div>

                        <div class="mt-5 text-right" runat="server" id="divbtn">
                            <button type="submit" runat="server" id="Cancel" name="submit" class="btn btn-secondary">Cancel</button>
                            <button type="submit" runat="server" validationgroup="formprofile" id="Save" name="submit" class="btn btn-primary">Update</button>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

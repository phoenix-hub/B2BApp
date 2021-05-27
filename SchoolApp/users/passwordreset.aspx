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
                                <asp:TextBox ID="txtEmail" runat="server" ReadOnly="true" class="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="inputPassword3" class="col-sm-6 col-form-label">
                                Current Password
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please enter current password" Style="color: red; font-size: 12px;" ControlToValidate="txtCurrPassword" ValidationGroup="formprofile">*</asp:RequiredFieldValidator>
                            </label>
                            <div class="col-sm-6">
                                <asp:TextBox ID="txtCurrPassword" TextMode="Password" runat="server" class="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="inputPassword3" class="col-sm-6 col-form-label">
                                New Password
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter new password" Style="color: red; font-size: 12px;" ControlToValidate="txtNewPassword" ValidationGroup="formprofile">*</asp:RequiredFieldValidator>
                            </label>
                            <div class="col-sm-6">
                                <asp:TextBox ID="txtNewPassword" TextMode="Password" runat="server" class="form-control"></asp:TextBox>

                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="inputPassword3" class="col-sm-6 col-form-label">
                                Confirm Password
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="formprofile" runat="server" ErrorMessage="Please enter confirm password" Style="color: red; font-size: 12px;" ControlToValidate="txtConfirmPassword">*</asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="CompareValidator1" Style="color: red; font-size: 12px;" ValidationGroup="formprofile" runat="server" ErrorMessage="New password and confirm password does not match. Please try again." ControlToValidate="txtConfirmPassword" ControlToCompare="txtNewPassword">*</asp:CompareValidator>
                            </label>
                            <div class="col-sm-6">
                                <asp:TextBox ID="txtConfirmPassword" TextMode="Password" runat="server" class="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <br />
                        <div class="alert alert-danger" role="alert" runat="server" visible="false" id="errordiv">
                            <asp:Label runat="server" ID="lblError" Text=""></asp:Label>
                        </div>
                        <div class="mt-5 text-right" runat="server" id="divbtn">
                            <button type="submit" runat="server" id="Cancel" name="submit" class="btn btn-secondary">Cancel</button>
                            <button type="submit" runat="server" onserverclick="Save_ServerClick" validationgroup="formprofile" id="Save" name="submit" class="btn btn-primary">Update</button>
                        </div>
                        <asp:ValidationSummary ID="ValidationSummary1" Style="color: red; font-size: 12px;" ValidationGroup="formprofile" runat="server" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

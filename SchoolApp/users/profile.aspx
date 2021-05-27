<%@ Page Title="" Language="C#" MasterPageFile="~/users/users.Master" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="SchoolApp.users.profile" %>

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
                    <h4 class="text-right">Profile Settings</h4>
                </div>

                <div class="row mt-2">
                    <div class="col-md-6">
                        <label class="labels">
                            user company name
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" Display="Dynamic" ControlToValidate="txtUCName" runat="server" ErrorMessage="Please enter Company Name" Style="color: red; text-transform: capitalize;" ValidationGroup="formprofile">*</asp:RequiredFieldValidator>
                        </label>
                        <asp:TextBox ID="txtUCName" runat="server" class="form-control" placeholder="User Company Name"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label class="labels">
                            user contact person name
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator7" Display="Dynamic" ControlToValidate="txtUCPName" runat="server" ErrorMessage="User Contact Person Name" Style="color: red; text-transform: capitalize;" ValidationGroup="formprofile">*</asp:RequiredFieldValidator>
                        </label>
                        <asp:TextBox ID="txtUCPName" runat="server" class="form-control" value="" placeholder="User Contact Person Name"></asp:TextBox>

                    </div>
                </div>

                <div class="row mt-3">
                    <div class="col-md-6">
                        <label class="labels">
                            user role 
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator6" Display="Dynamic" InitialValue="select" ControlToValidate="drpURole" runat="server" ErrorMessage="Select User Role" Style="color: red; text-transform: capitalize;" ValidationGroup="formprofile">*</asp:RequiredFieldValidator>
                        </label>
                        <asp:DropDownList ID="drpURole" runat="server" CssClass="form-control">
                            <asp:ListItem Value="select">Select</asp:ListItem>
                            <asp:ListItem Value="user">User</asp:ListItem>
                            <asp:ListItem Value="admin">Admin</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-6">
                        <label class="labels">
                            user company mobile
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator9" Display="Dynamic" ControlToValidate="txtUMobile" runat="server" ErrorMessage="user company mobile" Style="color: red; text-transform: capitalize;" ValidationGroup="formprofile">*</asp:RequiredFieldValidator></label>
                        <asp:TextBox ID="txtUMobile" runat="server" class="form-control" placeholder="User Company Mobile"></asp:TextBox>
                    </div>
                </div>


                <div class="row mt-3">
                    <div class="col-md-6">
                        <label class="labels">
                            user company landline number
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator5" Display="Dynamic" ControlToValidate="txtUPhone" runat="server" ErrorMessage="user company landline number" Style="color: red; text-transform: capitalize;" ValidationGroup="formprofile">*</asp:RequiredFieldValidator></label>
                        <asp:TextBox ID="txtUPhone" runat="server" class="form-control" placeholder="User Company Landline Number"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label class="labels">
                            user email
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator10" Display="Dynamic" ControlToValidate="txtUEmail" runat="server" ErrorMessage="user email" Style="color: red; text-transform: capitalize;" ValidationGroup="formprofile">*</asp:RequiredFieldValidator></label>
                        <asp:TextBox ID="txtUEmail" ReadOnly="true" runat="server" class="form-control" placeholder="user email"></asp:TextBox>
                    </div>
                </div>

                <div class="row mt-3">
                    <div class="col-md-12">
                        <label class="labels">
                            office address
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator4" Display="Dynamic" ControlToValidate="txtUOffAdd" runat="server" ErrorMessage="office address" Style="color: red; text-transform: capitalize;" ValidationGroup="formprofile">*</asp:RequiredFieldValidator></label>

                        <asp:TextBox ID="txtUOffAdd" runat="server" TextMode="MultiLine" class="form-control" placeholder="office address"></asp:TextBox>
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-md-6">
                        <label class="labels">
                            city
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator3" Display="Dynamic" ControlToValidate="txtUCity" runat="server" ErrorMessage="city" Style="color: red; text-transform: capitalize;" ValidationGroup="formprofile">*</asp:RequiredFieldValidator></label>
                        <asp:TextBox ID="txtUCity" runat="server" class="form-control" placeholder="city"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label class="labels">
                            trade license
                        </label>
                        <asp:FileUpload ID="fileUTlicns" runat="server" class="form-control-file" />
                    </div>
                </div>
                <br />
                <div class="alert alert-danger" role="alert" runat="server" visible="false" id="errordiv">
                    <asp:Label runat="server" ID="lblError" Text=""></asp:Label>
                </div>
                <div class="mt-5 text-right" runat="server" id="divbtn">
                    <button type="submit" runat="server" onserverclick="Cancel_ServerClick" id="Cancel" name="submit" class="btn btn-secondary">Cancel</button>
                    <button type="submit" runat="server" validationgroup="formprofile" onserverclick="Save_ServerClick" id="Save" name="submit" class="btn btn-primary">Update</button>
                </div>
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="formprofile" Style="color: red; text-transform: capitalize;" />
            </div>
        </div>
    </div>
</asp:Content>

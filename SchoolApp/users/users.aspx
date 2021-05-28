<%@ Page Title="" Language="C#" MasterPageFile="~/users/users.Master" AutoEventWireup="true" CodeBehind="users.aspx.cs" Inherits="SchoolApp.users.users1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="../Scripts/WebForms/Users/users-profile.css" rel="stylesheet" />
    <style>
        .btn-secondary {
            color: #fff !important;
            background-color: #b23cfd !important;
            border-color: #b23cfd !important;
        }

        .modalBackground {
            background-color: Gray;
            filter: alpha(opacity=80);
            opacity: 0.8;
            z-index: 10000;
        }

        .btng {
            white-space: initial;
            color: blue;
            border: none;
            text-decoration: none;
            display: inline-block;
            cursor: pointer;
            background-color: transparent;
        }

        .table {
            font-size: 14px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <asp:Button ID="btnShowPopup" ValidationGroup="x" runat="server" Style="display: none" />
    <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="btnShowPopup" PopupControlID="pnlpopup"
        CancelControlID="btnCancel" BackgroundCssClass="modalBackground">
    </cc1:ModalPopupExtender>

    <div class="container rounded bg-white mt-5 mb-5">
        <div class="row" style="margin: 0 0 20px 0; text-transform: capitalize;" runat="server" id="divform">
            <div class="col-md-12 ">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h4 class="text-right">Registered Users</h4>
                </div>

                <div class="form-inline">


                    <div class="form-group mb-2">

                        <asp:DropDownList ID="drpFilter" runat="server" class="form-control">
                            <asp:ListItem Value="All">All</asp:ListItem>
                            <asp:ListItem Value="UCName">company name</asp:ListItem>
                            <asp:ListItem Value="UCPName">contact name</asp:ListItem>
                            <asp:ListItem Value="UPhone">landline</asp:ListItem>
                            <asp:ListItem Value="UMobile">mobile</asp:ListItem>
                            <asp:ListItem Value="UEmail">email</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group mx-sm-3 mb-2">
                        <asp:TextBox ID="txtSearch" runat="server" class="form-control" placeholder="Enter filter values"></asp:TextBox>
                    </div>
                    <button type="submit" onserverclick="Search_ServerClick" runat="server" class="btn btn-primary mb-2">Search</button>
                    <div class="form-group mx-sm-3 mb-2 float-right">
                        <asp:Button ID="btnShowPopupAdd" runat="server" OnClick="btnShowPopupAdd_Click" Text="Add User" class="btn btn-success" />


                        <asp:Button ID="Button1" ValidationGroup="x" runat="server" Style="display: none" />
                        <cc1:ModalPopupExtender ID="ModalPopupExtender3" runat="server" TargetControlID="Button1" PopupControlID="pnlpopup" CancelControlID="btnCancel" BackgroundCssClass="modalBackground"></cc1:ModalPopupExtender>
                    </div>
                </div>

                <br />
                <div class="alert alert-danger" role="alert" runat="server" visible="false" id="errordiv">
                    <asp:Label runat="server" ID="lblError" Text=""></asp:Label>
                </div>
                <div class="table-responsive">
                    <asp:Repeater ID="Repeater1" runat="server">

                        <HeaderTemplate>
                            <table class="table">
                                <tr>
                                    <th scope="col">#</th>
                                    <th scope="col">
                                        <asp:Button ID="lnkUCName" class="btng" runat="server" ValidationGroup="x" OnClick="SortlnkUCNameClick" Text="company name" />
                                    </th>
                                    <th scope="col">
                                        <asp:Button ID="lnkUCPName" class="btng" runat="server" ValidationGroup="x" OnClick="SortlnkUCPNameClick" Text="contact name" />
                                    </th>
                                    <th scope="col">
                                        <asp:Button ID="lnklandline" class="btng" runat="server" ValidationGroup="x" OnClick="SortlnklandlineClick" Text="landline" />
                                    </th>
                                    <th scope="col">
                                        <asp:Button ID="lnkmobile" class="btng" runat="server" ValidationGroup="x" OnClick="SortlnkmobileClick" Text="mobile" />
                                    </th>
                                    <th scope="col">
                                        <asp:Button ID="lnkemail" class="btng" runat="server" ValidationGroup="x" OnClick="SortlnkemailClick" Text="email" />
                                    </th>
                                    <th scope="col">
                                        <asp:Button ID="lnkcity" class="btng" runat="server" ValidationGroup="x" OnClick="SortlnkcityClick" Text="city" /></th>
                                    <th scope="col">Edit</th>
                                </tr>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <th scope="row">
                                    <asp:Label ID="lblRowNumber" Text='<%# Container.ItemIndex + 1 %>' runat="server" />
                                    <asp:Label runat="server" Visible="false" ID="Label2" Text='<%# Eval("UID") %>' /></th>
                                <td>
                                    <asp:Label runat="server" ID="lblUCName" Text='<%# Eval("UCName") %>' /></td>
                                <td>
                                    <asp:Label runat="server" ID="lblUCPName" Text='<%# Eval("UCPName") %>' /></td>
                                <td>
                                    <asp:Label runat="server" ID="lblUPhone" Text='<%# Eval("UPhone") %>' /></td>
                                <td>
                                    <asp:Label runat="server" ID="lblUMobile" Text='<%# Eval("UMobile") %>' /></td>
                                <td>
                                    <asp:Label runat="server" ID="lblUEmail" Text='<%# Eval("UEmail") %>' />
                                    <asp:HiddenField runat="server" ID="hdnEmailId" Value='<%# Eval("UEMail") %>' />
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="lblUCity" Text='<%# Eval("UCity") %>' /></td>
                                <td>
                                    <asp:Button ID="btnEdit" OnClick="btnEdit_Click" runat="server" class="btn btn-info" Text="Edit" /></td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </tr>
                        </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
    </div>





    <asp:Panel ID="pnlpopup" runat="server" BackColor="White" Style="display: none">
        <div class="row" style="margin: 20px 20px 20px 20px; text-transform: capitalize;" runat="server" id="div1">
            <div class="col-md-12 ">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h4 class="text-right">
                        <asp:Label ID="lblformHeader" runat="server" Text=""></asp:Label>
                        Users </h4>
                </div>

                <div class="row mt-2">
                    <div class="col-md-6">
                        <label class="labels">
                            user company name
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" Display="Dynamic" ControlToValidate="txtUCName" runat="server" ErrorMessage="Please enter Company Name" Style="color: red; text-transform: capitalize;" ValidationGroup="formprofile"></asp:RequiredFieldValidator>
                        </label>
                        <asp:TextBox ID="txtUCName" runat="server" class="form-control" placeholder="User Company Name"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label class="labels">
                            user contact person name
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator7" Display="Dynamic" ControlToValidate="txtUCPName" runat="server" ErrorMessage="User Contact Person Name" Style="color: red; text-transform: capitalize;" ValidationGroup="formprofile"></asp:RequiredFieldValidator>
                        </label>
                        <asp:TextBox ID="txtUCPName" runat="server" class="form-control" value="" placeholder="User Contact Person Name"></asp:TextBox>

                    </div>
                </div>

                <div class="row mt-3">
                    <div class="col-md-6">
                        <label class="labels">
                            user role 
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator6" Display="Dynamic" InitialValue="select" ControlToValidate="drpURole" runat="server" ErrorMessage="Select User Role" Style="color: red; text-transform: capitalize;" ValidationGroup="formprofile"></asp:RequiredFieldValidator>
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
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator9" Display="Dynamic" ControlToValidate="txtUMobile" runat="server" ErrorMessage="user company mobile" Style="color: red; text-transform: capitalize;" ValidationGroup="formprofile"></asp:RequiredFieldValidator></label>
                        <asp:TextBox ID="txtUMobile" TextMode="Number" runat="server" class="form-control" placeholder="User Company Mobile"></asp:TextBox>
                    </div>
                </div>




                <div class="row mt-3">
                    <div class="col-md-6">
                        <label class="labels">
                            user company landline number
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator5" Display="Dynamic" ControlToValidate="txtUPhone" runat="server" ErrorMessage="user company landline number" Style="color: red; text-transform: capitalize;" ValidationGroup="formprofile"></asp:RequiredFieldValidator></label>
                        <asp:TextBox ID="txtUPhone" TextMode="Number" runat="server" class="form-control" placeholder="User Company Landline Number"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label class="labels">
                            user email
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator10" Display="Dynamic" ControlToValidate="txtUEmail" runat="server" ErrorMessage="user email" Style="color: red; text-transform: capitalize;" ValidationGroup="formprofile"></asp:RequiredFieldValidator></label>
                        <asp:TextBox ID="txtUEmail" TextMode="Email" runat="server" class="form-control" placeholder="user email"></asp:TextBox>
                    </div>
                </div>


                <div class="row mt-3">
                    <div class="col-md-12">
                        <label class="labels">
                            office address
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator4" Display="Dynamic" ControlToValidate="txtUOffAdd" runat="server" ErrorMessage="office address" Style="color: red; text-transform: capitalize;" ValidationGroup="formprofile"></asp:RequiredFieldValidator></label>

                        <asp:TextBox ID="txtUOffAdd" runat="server" TextMode="MultiLine" class="form-control" placeholder="office address"></asp:TextBox>
                    </div>
                </div>



                <div class="row mt-3">
                    <div class="col-md-6">
                        <label class="labels">
                            city
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator3" Display="Dynamic" ControlToValidate="txtUCity" runat="server" ErrorMessage="city" Style="color: red; text-transform: capitalize;" ValidationGroup="formprofile"></asp:RequiredFieldValidator></label>
                        <asp:TextBox ID="txtUCity" runat="server" class="form-control" placeholder="city"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label class="labels">
                            trade license
                        </label>
                        <asp:FileUpload ID="fileUTlicns" runat="server" class="form-control-file" />
                        <%if (this.isFileExists)
                            { %>
                        <br />
                        <asp:HyperLink ID="linkbaner" Target="_blank" runat="server" NavigateUrl="#" Text="Click here to View Baner."></asp:HyperLink>
                        <% } %>
                    </div>
                </div>

                <%if (this.isOperationAdd)
                    { %>
                <div class="row mt-3">
                    <div class="col-md-6">
                        <label class="labels">
                            Password <span style="color: red;">*</span>
                        </label>
                        <asp:TextBox ID="txtPassword" MaxLength="30" TextMode="Password" runat="server" class="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label class="labels">
                            Confirm Password
                            <span style="color: red;">*</span>
                        </label>
                        <asp:TextBox ID="txtConfirmPassword" TextMode="Password" runat="server" class="form-control"></asp:TextBox>
                    </div>
                </div>
                <% } %>
            </div>
            <div class="row mt-2">
                <div class="col-md-12">
                    <button type="submit" runat="server" validationgroup="formprofile" onserverclick="Save_ServerClick" id="Save" name="submit" class="btn btn-primary">Update</button>
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" class="btn btn-secondary" />

                    <asp:HiddenField ID="hdnUpdateid" runat="server" Value="0" />
                </div>
            </div>
        </div>
        <br />
        <div class="alert alert-danger" role="alert" runat="server" visible="false" id="divErrorForm">
            <asp:Label runat="server" ID="lblErrorForm" Text=""></asp:Label>
        </div>
    </asp:Panel>




</asp:Content>

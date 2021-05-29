<%@ Page Title="" Language="C#" MasterPageFile="~/users/users.Master" AutoEventWireup="true" CodeBehind="forgotpassword.aspx.cs" Inherits="SchoolApp.users.forgotpassword" %>

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

        .btn-secondary {
            color: #fff !important;
            background-color: #b23cfd !important;
            border-color: #b23cfd !important;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        .btnClosePanel {
            background-color: DodgerBlue;
            border: none;
            color: white;
            padding: 12px 16px;
            font-size: 16px;
            cursor: pointer;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

    <div class="container rounded bg-white mt-5 mb-5">
        <div class="row" style="margin: 0 0 20px 0; text-transform: capitalize;" runat="server" id="divform">
            <div class="col-md-12 ">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h4 class="text-right">Forgot Password</h4>
                </div>
                <div class="form-inline">


                    <div class="form-group mb-2">

                        <asp:DropDownList ID="drpFilter" runat="server" class="form-control">
                            <asp:ListItem Value="All">All</asp:ListItem>
                            <asp:ListItem Value="EECname">company name</asp:ListItem>
                            <asp:ListItem Value="EECPName">person name</asp:ListItem>
                            <asp:ListItem Value="EECNumber">number</asp:ListItem>
                            <asp:ListItem Value="EEMessage">email</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group mx-sm-3 mb-2">
                        <asp:TextBox ID="txtSearch" runat="server" class="form-control" placeholder="Enter filter values"></asp:TextBox>
                    </div>
                    <asp:Button ID="btnSearch" OnClick="btnSearch_Click" ValidationGroup="BBB" runat="server" Text="Search" class="btn btn-primary mb-2" />

                    <div class="form-group mx-sm-3 mb-2 float-right">
                        <asp:Button ID="btnDelete" runat="server" OnClick="btnDelete_Click" Text="Delete" class="btn btn-danger" />
                    </div>

                </div>
                <div class="alert alert-danger" role="alert" runat="server" visible="false" id="errordiv">
                    <asp:Label runat="server" ID="lblError" Text=""></asp:Label>
                </div>
                <div class="table-responsive">
                    <asp:Repeater ID="Repeater1" runat="server" OnItemDataBound="OnItemDataBound">

                        <HeaderTemplate>
                            <table class="table">
                                <tr>
                                    <th scope="col">Trash</th>
                                    <th scope="col">#</th>
                                    <th scope="col">email</th>
                                    <th scope="col">status</th>
                                    <th scope="col">remarks</th>
                                    <th scope="col">created</th>
                                    <th scope="col">updatedby </th>
                                    <th scope="col">updated</th>
                                    <th scope="col"></th>
                                </tr>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <asp:CheckBox ID="chkCheck" runat="server" />
                                </td>
                                <th scope="row">
                                    <asp:Label ID="lblRowNumber" Text='<%# Container.ItemIndex + 1 %>' runat="server" />
                                    <asp:Label runat="server" Visible="false" ID="Label2" Text='<%# Eval("id") %>' /></th>
                                <td>
                                    <asp:Label runat="server" ID="lblemail" Text='<%# Eval("email") %>' /></td>
                                <td>
                                    <asp:Label runat="server" ID="lblstatus" Text='<%# Eval("status") %>' /></td>
                                <td>
                                    <asp:Label runat="server" ID="lblremarks" Text='<%# Eval("remarks") %>' /></td>
                                <td>
                                    <asp:Label runat="server" ID="lblcreated" Text='<%# Eval("created") %>' /></td>
                                <td>
                                    <asp:Label runat="server" ID="lblupdatedby" Text='<%# Eval("updatedby") %>' />
                                </td>
                                <td>
                                    <b>
                                        <asp:Label runat="server" ID="lblupdated" Text='<%# Eval("updated") %>' />
                                    </b>
                                </td>
                                <td>
                                    <asp:Button ID="btnEditRow" runat="server" Text="Edit" class="btn btn-info" OnClick="btnEditRow_Click" />
                                </td>
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


        <asp:Button ID="btnShowPopup" runat="server" Style="display: none" />
        <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="btnShowPopup" PopupControlID="pnlpopup"
            CancelControlID="btnShowPopup" BackgroundCssClass="modalBackground">
        </cc1:ModalPopupExtender>
        <asp:Panel ID="pnlpopup" runat="server" BackColor="White" Style="display: none">
            <div class="row" style="margin: 20px 20px 20px 20px; text-transform: capitalize;" runat="server" id="div1">
                <div class="col-md-12 ">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h4 class="text-right">
                            <asp:Label ID="lblformHeader" runat="server" Text=""></asp:Label>
                            Forgot Password </h4>

                        <div class="form-inline ml-auto">
                            <button class="btnClosePanel" runat="server" validationgroup="lskjfdalskdjfsd" id="btnClosePanelIcon" onserverclick="btnClosePanelIcon_Click"><i class="fa fa-close"></i></button>
                        </div>
                    </div>

                    <div class="alert alert-danger" role="alert" runat="server" visible="false" id="errordivForm">
                        <asp:Label runat="server" ID="lblErrorForm" Text=""></asp:Label>
                    </div>


                    <div class="form-group row">
                        <label class="col-sm-4 col-form-label">EMail</label>
                        <div class="col-sm-8">
                            <asp:TextBox ID="txtEmail" ReadOnly="true" runat="server" TextMode="Email" class="form-control"></asp:TextBox>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-sm-4 col-form-label">Please choose status</label>
                        <div class="col-sm-8">
                            <asp:DropDownList ID="drpStatus" runat="server" class="form-control">
                                <asp:ListItem Value="requested" Selected="True">requested</asp:ListItem>
                                <asp:ListItem Value="done">Done</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-4 col-form-label">Please Enter Remarks</label>
                        <div class="col-sm-8">
                            <asp:TextBox ID="txtRemarks" runat="server" TextMode="MultiLine" class="form-control"></asp:TextBox>
                        </div>
                    </div>


                    <div class="form-group row">
                        <label class="col-sm-4 col-form-label">
                            Password
                            <span style="color: red;">*</span>
                        </label>
                        <div class="col-sm-8">
                            <asp:TextBox ID="txtPassword" MaxLength="35" runat="server" TextMode="Password" class="form-control"></asp:TextBox>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-sm-4 col-form-label">
                            Confirm Password
                            <span style="color: red;">*</span>
                        </label>
                        <div class="col-sm-8">
                            <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" class="form-control"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <div class="row mt-2">
                    <div class="col-md-12">
                        <asp:Button ID="btnUpdate" ValidationGroup="formInquiry" OnClick="btnUpdate_Click" CommandName="Update" class="btn btn-primary" runat="server" Text="Update" />
                        <asp:Button ID="btnCancel" OnClick="btnCancel_Click" ValidationGroup="form_cancel" runat="server" class="btn btn-secondary" Text="Cancel" />
                        <asp:HiddenField ID="hdnUpdateid" runat="server" Value="0" />
                    </div>
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>

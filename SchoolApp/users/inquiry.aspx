<%@ Page Title="" Language="C#" MasterPageFile="~/users/users.Master" AutoEventWireup="true" CodeBehind="inquiry.aspx.cs" Inherits="SchoolApp.users.inquiry" %>

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
                    <h4 class="text-right">Registered Inquiry</h4>
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
                        &nbsp; &nbsp; 
                     <asp:Button ID="btnAddInquiry" runat="server" OnClick="btnAddInquiry_Click" Text="Add Inquiry" class="btn btn-success" />
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
                                    <%if (this.isAdmin)
                                        { %>
                                    <th scope="col" id="thResponseHeader" runat="server"></th>
                                    <% } %>
                                    <th scope="col">Trash</th>
                                    <th scope="col">#</th>
                                    <th scope="col">company name</th>
                                    <th scope="col">contact person name </th>
                                    <th scope="col">contact number</th>
                                    <th scope="col">email</th>
                                    <th scope="col">message </th>
                                    <th scope="col">Status</th>
                                    <th scope="col">Remarks</th>
                                </tr>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <%if (this.isAdmin)
                                    { %>
                                <td id="tdResponseBody" runat="server">
                                    <asp:Button ID="btnRespond" OnClick="btnRespond_Click" class="btn btn-secondary" runat="server" Text="Respond" /></td>
                                <% } %>
                                <td>
                                    <asp:CheckBox ID="chkCheck" runat="server" />
                                </td>
                                <th scope="row">
                                    <asp:Label ID="lblRowNumber" Text='<%# Container.ItemIndex + 1 %>' runat="server" />
                                    <asp:Label runat="server" Visible="false" ID="Label2" Text='<%# Eval("EEID") %>' /></th>
                                <td>
                                    <asp:Label runat="server" ID="EECname" Text='<%# Eval("EECname") %>' /></td>
                                <td>
                                    <asp:Label runat="server" ID="EECPName" Text='<%# Eval("EECPName") %>' /></td>
                                <td>
                                    <asp:Label runat="server" ID="EECNumber" Text='<%# Eval("EECNumber") %>' /></td>
                                <td>
                                    <asp:Label runat="server" ID="EEEmail" Text='<%# Eval("EEEmail") %>' /></td>
                                <td>
                                    <asp:Label runat="server" ID="EEMessage" Text='<%# Eval("EEMessage") %>' />
                                </td>
                                <td>
                                    <b>
                                        <asp:Label runat="server" ID="lblStatus" Text='<%# Eval("EEstatus") %>' />
                                    </b>
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="lblRemarks" Text='<%# Eval("EERemark") %>' />
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
                            Inquiry </h4>

                        <div class="form-inline ml-auto">
                            <button class="btnClosePanel" runat="server" validationgroup="lskjfdalskdjfsd" id="btnClosePanelIcon" onserverclick="btnClosePanelIcon_Click"><i class="fa fa-close"></i></button>
                        </div>
                    </div>

                    <div class="alert alert-danger" role="alert" runat="server" visible="false" id="errordivForm">
                        <asp:Label runat="server" ID="lblErrorForm" Text=""></asp:Label>
                    </div>



                    <div class="form-group row">
                        <label class="col-sm-4 col-form-label">company name</label>
                        <div class="col-sm-8">
                            <asp:TextBox ID="CompanyName" ReadOnly="true" runat="server" class="form-control"></asp:TextBox>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-sm-4 col-form-label">contact person name</label>
                        <div class="col-sm-8">
                            <asp:TextBox ID="CompanyPName" ReadOnly="true" runat="server" class="form-control"></asp:TextBox>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-sm-4 col-form-label">contact number</label>
                        <div class="col-sm-8">
                            <asp:TextBox ID="Mobile" TextMode="Number" MaxLength="15" ReadOnly="true" runat="server" class="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" Display="Dynamic" ControlToValidate="Mobile" runat="server" ErrorMessage="Enter mobile number" Style="color: red; text-transform: capitalize;" ValidationGroup="formInquiry"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-4 col-form-label">email</label>
                        <div class="col-sm-8">
                            <asp:TextBox ID="email" ReadOnly="true" runat="server" class="form-control"></asp:TextBox>

                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Display="Dynamic" ControlToValidate="email" runat="server" ErrorMessage="Enter email" Style="color: red; text-transform: capitalize;" ValidationGroup="formInquiry"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" Style="color: red; text-transform: capitalize;" Display="Dynamic" ValidationExpression="^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$" ControlToValidate="email" runat="server" ErrorMessage="Enter valid email id" ValidationGroup="formInquiry"></asp:RegularExpressionValidator>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-4 col-form-label">Message</label>
                        <div class="col-sm-8">
                            <asp:TextBox ID="Message" ReadOnly="true" runat="server" TextMode="MultiLine" class="form-control"></asp:TextBox>
                        </div>
                    </div>

                    <%if (this.isAdmin)
                        { %>

                    <div class="form-group row">
                        <label class="col-sm-4 col-form-label">Please choose status</label>
                        <div class="col-sm-8">
                            <asp:DropDownList ID="drpStatus" runat="server" class="form-control">
                                <asp:ListItem Value="In-Progress" Selected="True">In-Progress</asp:ListItem>
                                <asp:ListItem Value="Close">Close</asp:ListItem>
                                <asp:ListItem Value="Reject">Reject</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-4 col-form-label">Please Enter Remarks</label>
                        <div class="col-sm-8">
                            <asp:TextBox ID="txtRemarks" runat="server" TextMode="MultiLine" class="form-control"></asp:TextBox>
                        </div>
                    </div>
                    <% } %>
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


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
                            <asp:ListItem Value="EMName">company name</asp:ListItem>
                            <asp:ListItem Value="EMType">person name</asp:ListItem>
                            <asp:ListItem Value="EMDescription">number</asp:ListItem>
                            <asp:ListItem Value="EMCity">email</asp:ListItem> 
                        </asp:DropDownList>
                    </div>
                    <div class="form-group mx-sm-3 mb-2">
                        <asp:TextBox ID="txtSearch" runat="server" class="form-control" placeholder="Enter filter values"></asp:TextBox>
                    </div>
                    <button type="submit" runat="server" class="btn btn-primary mb-2">Search</button>
                    <div class="form-group mx-sm-3 mb-2 float-right">
                        <asp:Button ID="btnShowPopupAdd" runat="server" OnClick="btnShowPopupAdd_Click" Text="Add Event" class="btn btn-success" />


                        <asp:Button ID="Button1" ValidationGroup="x" runat="server" Style="display: none" />
                        <cc1:ModalPopupExtender ID="ModalPopupExtender3" runat="server" TargetControlID="Button1" PopupControlID="pnlpopup" CancelControlID="btnCancel" BackgroundCssClass="modalBackground"></cc1:ModalPopupExtender>
                    </div>
                </div>

                <div class="table-responsive">
                    <asp:Repeater ID="Repeater1" runat="server">

                        <HeaderTemplate>
                            <table class="table">
                                <tr>
                                    <th scope="col">#</th>
                                    <th scope="col">company name</th>
                                    <th scope="col">contact person name </th>
                                    <th scope="col">contact number</th>
                                    <th scope="col">email</th>
                                    <th scope="col">message </th>
                                    <th scope="col">Edit</th>
                                </tr>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <th scope="row">
                                    <asp:Label runat="server" ID="Label2" Text='<%# Eval("EEID") %>' /></th>
                                <td>
                                    <asp:Label runat="server" ID="Label1" Text='<%# Eval("EECname") %>' /></td>
                                <td>
                                    <asp:Label runat="server" ID="Label3" Text='<%# Eval("EECPName") %>' /></td>
                                <td>
                                    <asp:Label runat="server" ID="Label4" Text='<%# Eval("EECNumber") %>' /></td>
                                <td>
                                    <asp:Label runat="server" ID="Label5" Text='<%# Eval("EEEmail") %>' /></td>
                                <td>
                                    <asp:Label runat="server" ID="Label6" Text='<%# Eval("EEMessage") %>' /></td>
                                <td>
                                    <asp:Button ID="btnShow" OnClick="btnShow_Click" runat="server" Text="Edit" /></td>
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
            CancelControlID="btnCancel" BackgroundCssClass="modalBackground">
        </cc1:ModalPopupExtender>
        <asp:Panel ID="pnlpopup" runat="server" BackColor="White" Height="269px" Width="400px" Style="display: none">
            <table width="100%" style="border: Solid 3px #D55500; width: 100%; height: 100%" cellpadding="0" cellspacing="0">
                <tr style="background-color: #D55500">
                    <td colspan="2" style="height: 10%; color: White; font-weight: bold; font-size: larger" align="center">User Details</td>
                </tr>
                <tr>
                    <td align="right" style="width: 45%">UserId:
                    </td>
                    <td>
                        <asp:Label ID="lblID" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="right">UserName:
                    </td>
                    <td>
                        <asp:Label ID="lblusername" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="right">FirstName:
                    </td>
                    <td>
                        <asp:TextBox ID="txtfname" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td align="right">LastName:
                    </td>
                    <td>
                        <asp:TextBox ID="txtlname" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td align="right">City:
                    </td>
                    <td>
                        <asp:TextBox ID="txtCity" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td align="right">Designation:
                    </td>
                    <td>
                        <asp:TextBox ID="txtDesg" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:Button ID="btnUpdate" CommandName="Update" runat="server" Text="Update" />
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
</asp:Content>

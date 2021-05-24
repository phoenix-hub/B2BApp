<%@ Page Title="" Language="C#" MasterPageFile="~/users/users.Master" AutoEventWireup="true" CodeBehind="attendee.aspx.cs" Inherits="SchoolApp.users.attendee" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <link href="../Scripts/WebForms/Users/users-profile.css" rel="stylesheet" />
    <style>
        .btn-secondary {
            color: #fff !important;
            background-color: #b23cfd !important;
            border-color: #b23cfd !important;
        }

        .modalBackground
{
background-color: Gray;
filter: alpha(opacity=80);
opacity: 0.8;
z-index: 10000;
}
    </style> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
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


    <div class="container rounded bg-white mt-5 mb-5">
        <div class="row" style="margin: 0 0 20px 0; text-transform: capitalize;" runat="server" id="divform">
            <div class="col-md-12 ">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h4 class="text-right">Attendee</h4>
                </div>

                <div class="table-responsive">
                    <asp:Repeater ID="Repeater1" runat="server">

                        <HeaderTemplate>
                            <table class="table">
                                <tr>
                                    <th scope="col">#</th>
                                    <th scope="col">company name</th>
                                    <th scope="col">contact name </th> 
                                    <th scope="col">email</th>
                                    <th scope="col">AddedBy</th>
                                    <th scope="col">UCrDt</th>
                                    <th scope="col">Edit</th>
                                </tr>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <th scope="row">
                                    <asp:Label runat="server" ID="Label2" Text='<%# Eval("EAID") %>' /></th>
                                <td>
                                    <asp:Label runat="server" ID="Label7" Text='<%# Eval("EACN") %>' /></td>
                                <td>
                                    <asp:Label runat="server" ID="Label1" Text='<%# Eval("EAName") %>' /></td>
                                <td>
                                    <asp:Label runat="server" ID="Label3" Text='<%# Eval("EAEmail") %>' /></td>
                                <td>
                                    <asp:Label runat="server" ID="Label4" Text='<%# Eval("EAAddedBy") %>' /></td>
                                <td>
                                    <asp:Label runat="server" ID="Label5" Text='<%# Eval("UCrDt") %>' /></td> 
                                <td>
                                    <asp:Button ID="btnShow" OnClick="btnShow_Click"  runat="server" Text="Edit" /></td>
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
</asp:Content>

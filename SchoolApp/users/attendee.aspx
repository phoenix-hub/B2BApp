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
                    <h4 class="text-right">Attendee</h4>
                </div>
                <div class="form-inline">


                    <div class="form-group mb-2">
                        <asp:Label ID="lblFilterByName" runat="server" Text="Please enter Attendee Name : " class="form-control-plaintext"></asp:Label>
                    </div>
                    <div class="form-group mx-sm-3 mb-2">
                        <asp:TextBox ID="txtSearch" runat="server" class="form-control" placeholder="Enter filter values"></asp:TextBox>
                    </div>
                    <button type="submit" onserverclick="Search_ServerClick" runat="server" class="btn btn-primary mb-2">Search</button>

                    <div class="form-group mx-sm-3 mb-2 float-right">
                        <asp:Button ID="btnDelete" runat="server" OnClick="btnDelete_Click" Text="Delete" class="btn btn-danger" />
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
                                    <th scope="col">Trash</th>
                                    <th scope="col">#</th>
                                    <th scope="col">company name</th>
                                    <th scope="col">contact name </th>
                                    <th scope="col">email</th>
                                    <th scope="col">AddedBy</th>
                                    <th scope="col">UCrDt</th>
                                </tr>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td scope="col">
                                    <asp:CheckBox ID="chkCheck" runat="server" />
                                </td>
                                <th scope="row">
                                    <asp:Label runat="server" Visible="false" ID="Label2" Text='<%# Eval("EAID") %>' />
                                    <asp:Label ID="lblRowNumber" Text='<%# Container.ItemIndex + 1 %>' runat="server" />
                                </th>
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
</asp:Content>

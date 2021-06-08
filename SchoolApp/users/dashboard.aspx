<%@ Page Title="" Language="C#" MasterPageFile="~/users/users.Master" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="SchoolApp.users.dashboard" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="../Scripts/WebForms/Users/users-profile.css" rel="stylesheet" />
    <style>
        .btn-secondary {
            color: #fff !important;
            background-color: #b23cfd !important;
            border-color: #b23cfd !important;
        }
    </style>
    <link href="../Scripts/WebForms/Users/dashboard-topbox.css" rel="stylesheet" />
    <link href="../Scripts/WebForms/Users/dashboard-table.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div class="container rounded bg-white mt-5 mb-5">

        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <div class="dbox dbox--color-1">
                        <div class="dbox__icon">
                            <i class="glyphicon glyphicon-cloud">
                                <span class="dbox__count">
                                    <asp:Label ID="lblTotEvents" runat="server" Text=""></asp:Label>
                                </span>
                            </i>
                        </div>
                        <div class="dbox__body">
                            <span class="dbox__count">
                                <span class="dbox__title" style="font-size: 2vw;">Total Events</span></span>
                        </div>

                        <div class="dbox__action">
                            <a class="dbox__action__btn" href="events?isactive=events">More Info</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="dbox dbox--color-2">
                        <div class="dbox__icon">
                            <i class="glyphicon glyphicon-download">
                                <span class="dbox__count">
                                    <asp:Label ID="lblTotInquiry" runat="server" Text=""></asp:Label></span>
                            </i>
                        </div>
                        <div class="dbox__body">
                            <span class="dbox__count">
                                <span class="dbox__title" style="font-size: 2vw;">Total Inquiry</span>
                            </span>
                        </div>

                        <div class="dbox__action">
                            <a class="dbox__action__btn" href="inquiry?isactive=inquiry">More Info</a>
                        </div>
                    </div>
                </div>
                <%if (this.isAdmin)
                    { %>
                <div class="col-md-4">
                    <div class="dbox dbox--color-3">
                        <div class="dbox__icon">
                            <i class="glyphicon glyphicon-heart">
                                <span class="dbox__count">
                                    <asp:Label ID="lblTotUsers" runat="server" Text=""></asp:Label>
                                </span>
                            </i>
                        </div>
                        <div class="dbox__body">
                            <span class="dbox__count">
                                <span class="dbox__title" style="font-size: 2vw;">Total Users</span> </span>
                        </div>

                        <div class="dbox__action">
                            <a class="dbox__action__btn" href="users?isactive=users">More Info</a>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>



            <div class="row">
                <div class="col-md-6">

                    <asp:Chart ID="Chart1" runat="server">
                        <Series>
                            <asp:Series Name="Series1" ChartType="Pie"></asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
                        </ChartAreas>
                    </asp:Chart>

                    <div style="display: none;">
                        <div class="alert alert-danger" role="alert" runat="server" visible="false" id="divEventDetails">
                            <asp:Label runat="server" ID="lblEventDetails" Text=""></asp:Label>
                        </div>
                        <table>
                            <tr>
                                <th class="bg-info" colspan="2" style="text-align: center; color: white;">
                                    <h4>Events
                                    </h4>
                                </th>
                            </tr>
                            <asp:Repeater ID="RepeaterEventDashBoard" runat="server">
                                <HeaderTemplate>
                                    <tr>
                                        <th>Event Details</th>
                                        <th>Date</th>
                                    </tr>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td><b><%# Eval("EMName") %></b></td>
                                        <td><%# Eval("EMDate") %> <%# Eval("EMTime") %></td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <tr>
                                        <td colspan="2">
                                            <a href="events?isactive=events">view more.......
                                            </a>
                                        </td>
                                    </tr>
                                </FooterTemplate>
                            </asp:Repeater>
                        </table>
                    </div>

                </div>
                <div class="col-md-6">
                    <div class="alert alert-danger" role="alert" runat="server" visible="false" id="divInquiry">
                        <asp:Label runat="server" ID="lblInquiry" Text=""></asp:Label>
                    </div>
                    <table>
                        <tr>
                            <th class="bg-info" colspan="3" style="text-align: center; color: white;">
                                <h4>Inquiry Details
                                </h4>
                            </th>
                        </tr>
                        <asp:Repeater ID="ReapeterInquiry" runat="server">
                            <HeaderTemplate>
                                <tr>
                                    <th>Message</th>
                                    <th>Date</th>
                                    <th>Status</th>
                                </tr>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td><%# Eval("EEMessage") %></td>
                                    <td><%# Eval("EECreated") %> </td>
                                    <td><%# Eval("EEstatus") %> </td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                <tr>
                                    <td colspan="3">
                                        <a href="inquiry?isactive=inquiry">view more.......
                                        </a>
                                    </td>
                                </tr>
                            </FooterTemplate>
                        </asp:Repeater>
                    </table>
                </div>
            </div>


        </div>

    </div>
</asp:Content>

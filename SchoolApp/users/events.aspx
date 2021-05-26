<%@ Page Title="" Language="C#" MasterPageFile="~/users/users.Master" AutoEventWireup="true" CodeBehind="events.aspx.cs" Inherits="SchoolApp.users.events" %>

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

        .atag {
            text-decoration: none;
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
                    <h4 class="text-right">Events</h4>
                </div>

                <div class="form-inline">


                    <div class="form-group mb-2">

                        <asp:DropDownList ID="drpFilter" runat="server" class="form-control">
                            <asp:ListItem Value="All">All</asp:ListItem>
                            <asp:ListItem Value="EMName">name</asp:ListItem>
                            <asp:ListItem Value="EMType">event type</asp:ListItem>
                            <asp:ListItem Value="EMDescription">description</asp:ListItem>
                            <asp:ListItem Value="EMCity">City</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group mx-sm-3 mb-2">
                        <asp:TextBox ID="txtSearch" runat="server" class="form-control" placeholder="Enter filter values"></asp:TextBox>
                    </div>
                    <button type="submit" onserverclick="Search_ServerClick" runat="server" class="btn btn-primary mb-2">Search</button>
                    <div class="form-group mx-sm-3 mb-2 float-right">
                        <asp:Button ID="btnShowPopupAdd" runat="server" OnClick="btnShowPopupAdd_Click" Text="Add Event" class="btn btn-success" />


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
                                        <asp:Button ID="lnkEMName" class="btng" runat="server" ValidationGroup="x" OnClick="SortlnkEMNameClick" Text="name" />
                                    </th>
                                    <th scope="col">
                                        <asp:Button ID="lnkEMType" class="btng" runat="server" ValidationGroup="x" OnClick="SortlnkEMTypeClick" Text="event type" />
                                    </th>
                                    <th scope="col">
                                        <asp:Button ID="lnkEMDescription" class="btng" runat="server" ValidationGroup="x" OnClick="SortlnkEMDescriptionClick" Text="description" />
                                    </th>
                                    <th scope="col">
                                        <asp:Button ID="lnkEMMaxCap" class="btng" runat="server" ValidationGroup="x" OnClick="SortlnkEMMaxCapClick" Text="maximum capacity " />
                                    </th>
                                    <th scope="col">
                                        <asp:Button ID="lnkEMDateTime" class="btng" runat="server" ValidationGroup="x" Text="Date & Time" />
                                    </th>
                                    <th scope="col">
                                        <asp:Button ID="lnkEMCity" class="btng" runat="server" ValidationGroup="x" OnClick="SortlnkEMCityClick" Text="city" /></th>
                                    <th scope="col">Attendees</th>
                                    <th scope="col">Edit</th>
                                </tr>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td scope="col">
                                    <a class="atag" href="assignevent.aspx?id=<%# Eval("EMID") %>">
                                        <asp:Label runat="server" ID="lblEMID" Text='<%# Eval("EMID") %>' />
                                    </a>
                                </td>
                                <td scope="col">
                                    <a class="atag" href="assignevent.aspx?id=<%# Eval("EMID") %>">
                                        <asp:Label runat="server" ID="lblEMName" Text='<%# Eval("EMName") %>' />
                                    </a>

                                </td>
                                <td scope="col">
                                    <a class="atag" href="assignevent.aspx?id=<%# Eval("EMID") %>">
                                        <asp:Label runat="server" ID="lblEMType" Text='<%# Eval("EMType") %>' />
                                    </a>
                                </td>
                                <td scope="col">
                                    <a class="atag" href="assignevent.aspx?id=<%# Eval("EMID") %>">
                                        <asp:Label runat="server" ID="lblEMDescription" Text='<%# Eval("EMDescription") %>' />
                                    </a></td>
                                <td scope="col">

                                    <a class="atag" href="assignevent.aspx?id=<%# Eval("EMID") %>">
                                        <asp:Label runat="server" ID="lblEMMaxCap" Text='<%# Eval("EMMaxCap") %>' />
                                    </a>
                                </td>
                                <td scope="col">

                                    <a class="atag" href="assignevent.aspx?id=<%# Eval("EMID") %>">
                                        <asp:Label runat="server" ID="lblEMDate" Text='<%# Eval("EMDate") %>' />
                                        <asp:Label runat="server" ID="lblEMTime" Text='<%# Eval("EMTime") %>' />
                                    </a>
                                </td>
                                <td scope="col">

                                    <a class="atag" href="assignevent.aspx?id=<%# Eval("EMID") %>">
                                        <asp:Label runat="server" ID="lblEMCity" Text='<%# Eval("EMCity") %>' />
                                    </a></td>
                                <td scope="col">
                                    <a target="_blank" class="btn btn-info" href="attendee.aspx?id=<%# Eval("EMID") %>">View
                                    </a></td>
                                <td scope="col">
                                    <asp:Button ID="btnShow" OnClick="btnShow_Click" class="btn btn-primary" runat="server" Text="Edit" /></td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </tr>
                        </table>
                        </FooterTemplate>
                    </asp:Repeater>
                    <asp:HiddenField ID="hdnEditRowValue" runat="server" Value="" />
                </div>
            </div>
        </div>
    </div>





    <asp:Panel ID="pnlpopup" runat="server" BackColor="White" Style="display: none; max-height: 500px; overflow: auto;">

        <div class="row" style="margin: 20px 20px 20px 20px; text-transform: capitalize;" runat="server" id="div1">
            <div class="col-md-12 ">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h4 class="text-right">
                        <asp:Label ID="lblformHeader" runat="server" Text=""></asp:Label>
                        &nbsp; Event </h4>
                </div>

                <div class="alert alert-danger" role="alert" runat="server" visible="false" id="errordivForm">
                    <asp:Label runat="server" ID="lblErrorForm" Text=""></asp:Label>
                </div>
                <div class="row mt-2">
                    <div class="col-md-6">
                        <label class="labels">
                            Name
                        </label>
                        <asp:TextBox ID="txtEMName" runat="server" class="form-control" placeholder="Event Name"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" Display="Dynamic" ControlToValidate="txtEMName" runat="server" ErrorMessage="Please enter Name" Style="font-size: 11px; color: red; text-transform: capitalize;" ValidationGroup="formprofile"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-6">
                        <label class="labels">
                            Event Type
                        </label>
                        <asp:DropDownList ID="drpEMType" runat="server" class="form-control">
                            <asp:ListItem Value="0">Select</asp:ListItem>
                            <asp:ListItem Value="public">public</asp:ListItem>
                            <asp:ListItem Value="private ">private </asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" Display="Dynamic" InitialValue="0" ControlToValidate="drpEMType" runat="server" ErrorMessage="Event Type" Style="font-size: 11px; color: red; text-transform: capitalize;" ValidationGroup="formprofile"></asp:RequiredFieldValidator>

                    </div>
                </div>

                <div class="row mt-3">
                    <div class="col-md-12">
                        <label class="labels">
                            Description</label>

                        <asp:TextBox ID="txtEMDescription" runat="server" TextMode="MultiLine" class="form-control" placeholder="Description"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" Display="Dynamic" ControlToValidate="txtEMDescription" runat="server" ErrorMessage="Description" Style="font-size: 11px; color: red; text-transform: capitalize;" ValidationGroup="formprofile"></asp:RequiredFieldValidator>
                    </div>
                </div>



                <div class="row mt-3">
                    <div class="col-md-6">
                        <label class="labels">
                            Date
                            <small style="color: red;">Use format : DD/MM/YYYY
                            </small>
                        </label>
                        <asp:TextBox ID="txtEMDate" runat="server" class="form-control" placeholder="DD/MM/YYYY"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" Display="Dynamic" ControlToValidate="txtEMDate" runat="server" ErrorMessage="Date" Style="font-size: 11px; color: red; text-transform: capitalize;" ValidationGroup="formprofile"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-6">
                        <label class="labels">
                            Time
                             <small style="color: red;">Use format : HH:MM:SS
                             </small>
                        </label>
                        <asp:TextBox ID="txtEMTime" runat="server" class="form-control" placeholder="Use format : HH:MM:SS"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" Display="Dynamic" ControlToValidate="txtEMTime" runat="server" ErrorMessage="Time" Style="font-size: 11px; color: red; text-transform: capitalize;" ValidationGroup="formprofile"></asp:RequiredFieldValidator>
                    </div>
                </div>



                <div class="row mt-3">
                    <div class="col-md-6">
                        <label class="labels">
                            Maximum Capacity
                        </label>
                        <asp:TextBox ID="txtEMMaxCap" runat="server" class="form-control" placeholder="Maximum Capacity"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" Display="Dynamic" ControlToValidate="txtEMMaxCap" runat="server" ErrorMessage="Maximum Capacity" Style="font-size: 11px; color: red; text-transform: capitalize;" ValidationGroup="formprofile"></asp:RequiredFieldValidator>
                        <asp:RangeValidator runat="server" Type="Integer" ValidationGroup="formprofile"
                            MinimumValue="0" Display="Dynamic" MaximumValue="2500" ControlToValidate="txtEMMaxCap"
                            ErrorMessage="Value must be a whole number between 0 and 2500" Style="font-size: 11px; color: red; text-transform: capitalize;" />
                    </div>
                    <div class="col-md-6">
                        <label class="labels">
                            EMCity</label>
                        <asp:TextBox ID="txtEMCity" runat="server" class="form-control" placeholder="city"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" Display="Dynamic" ControlToValidate="txtEMCity" runat="server" ErrorMessage="city" Style="font-size: 11px; color: red; text-transform: capitalize;" ValidationGroup="formprofile"></asp:RequiredFieldValidator>
                    </div>
                </div>





                <div class="row mt-3">
                    <div class="col-md-12">
                        <label class="labels">
                            Area 
                        </label>
                        <asp:TextBox ID="txtEMArea" runat="server" class="form-control" placeholder="Area">
                        </asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator11" Display="Dynamic" ControlToValidate="txtEMArea" runat="server" ErrorMessage="Area" Style="font-size: 11px; color: red; text-transform: capitalize;" ValidationGroup="formprofile"></asp:RequiredFieldValidator>
                    </div>
                </div>




                <div class="row mt-3">
                    <div class="col-md-6">
                        <label class="labels">
                            location description
                        </label>
                        <asp:TextBox ID="txtEMLocDesc" runat="server" class="form-control" placeholder="location description"></asp:TextBox>
                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator12" Display="Dynamic" ControlToValidate="txtEMLocDesc" runat="server" ErrorMessage="location description" Style="font-size: 11px; color: red; text-transform: capitalize;" ValidationGroup="formprofile"></asp:RequiredFieldValidator>--%>
                    </div>
                    <div class="col-md-6">
                        <label class="labels">
                            location link through google map
                        </label>
                        <asp:TextBox ID="txtEMLocLink" runat="server" class="form-control" placeholder="location link through google map"></asp:TextBox>
                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator13" Display="Dynamic" ControlToValidate="txtEMLocLink" runat="server" ErrorMessage="location link through google map" Style="font-size: 11px; color: red; text-transform: capitalize;" ValidationGroup="formprofile"></asp:RequiredFieldValidator>--%>
                    </div>
                </div>




                <div class="row mt-3">
                    <div class="col-md-6">
                        <label class="labels">
                            automatic generated code</label>
                        <asp:TextBox ID="txtEMCode" runat="server" class="form-control" placeholder="automatic generated code"></asp:TextBox>
                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" Display="Dynamic" ControlToValidate="txtEMCode" runat="server" ErrorMessage="automatic generated code" Style="font-size: 11px; color: red; text-transform: capitalize;" ValidationGroup="formprofile"></asp:RequiredFieldValidator>--%>
                    </div>
                    <div class="col-md-6">
                        <label class="labels">
                            status Id</label>
                        <asp:TextBox ID="txtEMStsID" runat="server" class="form-control" placeholder="status Id"></asp:TextBox>
                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator2" Display="Dynamic" ControlToValidate="txtEMStsID" runat="server" ErrorMessage="status Id" Style="font-size: 11px; color: red; text-transform: capitalize;" ValidationGroup="formprofile"></asp:RequiredFieldValidator>--%>
                    </div>
                </div>


                <div class="row mt-3">
                    <div class="col-md-12">
                        <label class="labels">
                            banner image of company</label>
                        <asp:FileUpload ID="fileEMCoverImg" runat="server" class="form-control-file" />
                        <asp:HyperLink ID="linkbaner" Target="_blank" runat="server" NavigateUrl="#" Text="Click here to View Baner."></asp:HyperLink>
                        <br />

                    </div>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-md-12">
                    <asp:Button ID="Save" runat="server" Text="Save" ValidationGroup="formprofile" class="btn btn-secondary" OnClick="Save_ServerClick" />
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" class="btn btn-secondary" />
                </div>
            </div>
        </div>

    </asp:Panel>



</asp:Content>

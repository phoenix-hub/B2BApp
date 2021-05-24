<%@ Page Title="" Language="C#" MasterPageFile="~/users/users.Master" MaintainScrollPositionOnPostback="true" AutoEventWireup="true" CodeBehind="assignevent.aspx.cs" Inherits="SchoolApp.users.assignevent" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="../Scripts/WebForms/Users/users-profile.css" rel="stylesheet" />
    <style>
        .btn-secondary {
            color: #fff !important;
            background-color: #b23cfd !important;
            border-color: #b23cfd !important;
        }

        fieldset.scheduler-border {
            border: 1px groove #ddd !important;
            padding: 0 1.4em 1.4em 1.4em !important;
            margin: 0 0 1.5em 0 !important;
            -webkit-box-shadow: 0px 0px 0px 0px #000;
            box-shadow: 0px 0px 0px 0px #000;
        }

        legend.scheduler-border {
            font-size: 1.2em !important;
            font-weight: bold !important;
            text-align: left !important;
            width: auto;
            padding: 0 10px;
            border-bottom: none;
        }

        .img-responsive {
            max-width: 700px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div class="container rounded bg-white mt-5 mb-5">
        <div class="row" style="margin: 0 0 20px 0; text-transform: capitalize;" runat="server" id="divform">
            <div class="col-md-12 ">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h4 class="text-right">Event Management</h4>
                </div>
                <div class="container-fluid no-padding">
                    <div class="row">
                        <div class="col-md-12">
                            <asp:Image ID="imgBaner" runat="server" ImageUrl="#" class="img-responsive" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">

                            <fieldset class="scheduler-border">
                                <legend class="scheduler-border">Event Name :
                                    <asp:Label ID="lblEventName" runat="server" Text="DemoEvent"></asp:Label></legend>
                                <div class="control-group">
                                    <label class="control-label input-label" style="font-weight: bold" for="startTime">Event Created By:</label>
                                    <asp:Label ID="lblEventCreatedBy" runat="server" Style="text-transform: none;" Text=""></asp:Label>
                                    <br />
                                    <label class="control-label input-label" style="font-weight: bold" for="startTime">Event Time:</label>
                                    <asp:Label ID="lblEventDateTime" runat="server" Text="31/05/2021 15:30 PM"></asp:Label>

                                    <br />
                                    <label class="control-label input-label" style="font-weight: bold" for="startTime">Description:</label>
                                    <asp:Label ID="lblDescription" runat="server" Text="Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."></asp:Label>
                                    <br />

                                    <label class="control-label input-label" style="font-weight: bold" for="startTime">Maximum Capecity:</label>
                                    <asp:Label ID="lblMaxCap" runat="server" Text="50"></asp:Label>

                                    <br />
                                </div>
                            </fieldset>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">

                            <fieldset class="scheduler-border">
                                <legend class="scheduler-border">Manage Attendee
                                </legend>

                                <section>

                                    <ul class="nav nav-tabs" id="myTab" role="tablist">
                                        <li class="nav-item waves-effect waves-light">
                                            <a class="nav-link  active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">Single Attendee</a>
                                        </li>
                                        <li class="nav-item waves-effect waves-light">
                                            <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false">Many Attendees</a>
                                        </li>
                                    </ul>
                                    <div class="tab-content" id="myTabContent">
                                        <div class="tab-pane fade active show" id="home" role="tabpanel" aria-labelledby="home-tab">
                                            <br />
                                            <br />
                                            <div class="form-group row">
                                                <label for="inputCompanyName" class="col-sm-2 col-form-label">Attendee Company Name</label>
                                                <div class="col-sm-10">
                                                    <asp:TextBox ID="txtCompanyName" runat="server" class="form-control" placeholder="Company Name"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label for="inputName" class="col-sm-2 col-form-label">Name</label>
                                                <div class="col-sm-10">
                                                    <asp:TextBox ID="txtName" runat="server" class="form-control" placeholder="Name"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label for="inputEmailId" class="col-sm-2 col-form-label">Email ID</label>
                                                <div class="col-sm-10">
                                                    <asp:TextBox ID="txtEmailId" runat="server" class="form-control" placeholder="Email ID"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <div class="col-sm-10">
                                                    <button type="submit" runat="server" id="btnSingleAttendee" onserverclick="btnSingleAttendee_ServerClick" class="btn btn-primary">Add Attendee</button>
                                                </div>
                                            </div>

                                        </div>
                                        <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                                            <br />
                                            <div class="form-group row">
                                                <label for="inputEMail" class="col-sm-5 col-form-label">Attendee List</label>
                                                <div class="col-sm-10">
                                                    <asp:FileUpload ID="fileUTlicns" runat="server" class="form-control-file" />
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <div class="col-8">
                                                    <button id="btnImportAttendeeFromFile" runat="server" onserverclick="btnImportAttendeeFromFile_ServerClick" validationgroup="fromfile" type="submit" class="btn btn-primary">Import</button>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <div class="col-12">
                                                    <small style="color: red;">
                                                        <b>Note:</b>
                                                        <ul>
                                                            <li>1. Only Excel file accepted.
                                                            </li>
                                                            <li>2. Sheet name should be "Sheet1"
                                                            </li>
                                                            <li>3. Column Name should be in following order and exact same
                                                               <ul>
                                                                   <li>a. "EACN" : This column is use for Company Name. 
                                                                   </li>
                                                                   <li>b. "EAName" : This column is use for Attendee Name. 
                                                                   </li>
                                                                   <li>c. "EAEmail" : This column is use for Email id's of Attendee.
                                                                   </li>
                                                               </ul>
                                                            </li>
                                                        </ul>
                                                    </small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="alert alert-danger" role="alert" runat="server" visible="false" id="errordiv">
                                        <asp:Label runat="server" ID="lblError" Text=""></asp:Label>
                                    </div>
                                </section>
                            </fieldset>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</asp:Content>

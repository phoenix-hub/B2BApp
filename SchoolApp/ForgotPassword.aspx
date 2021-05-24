﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="SchoolApp.ForgotPassword" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>Forgot Password</title>
    <link href='https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css' rel='stylesheet'>
    <link href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css' rel='stylesheet'>
    <link href="Scripts/WebForms/loginforms/login.css" rel="stylesheet" />
    <script type='text/javascript' src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
    <script type='text/javascript' src='https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js'></script>
    <script type='text/javascript'></script> 
    <link href="Scripts/WebForms/loginforms/NewLogin.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css">

</head>
<body class="bg">
    <form id="form1" runat="server"> 
         <div class="row gutters">
            <div class="col">
                <!-- Navbar -->
                <div class="sticky-top">
                    <nav class="navbar navbar-expand-lg navbar navbar-dark">
                        <img src="Scripts/WebForms/logo/xyz-logo.png" class="logo" />
                    </nav>
                </div>
            </div>
        </div> 
        <div class="container-fluid px-1 px-md-5 px-lg-1 px-xl-5 py-5 mx-auto">
            <div class="card card0 border-0"  style="margin-left: 25% !important;margin-right: 25% !important;">
                
                    <div class="position-relative">
                        <div class="card2 card border-0 px-4 py-5">
                            <div class="row mb-4 px-3">
                                 
                                <a href="login" data-toggle="tooltip" title="Go to login">
                                    <div class="facebook text-center mr-3">
                                        <i class="bi bi-box-arrow-in-right"></i>
                                    </div>
                                </a>

                                <a href="Inquiry" data-toggle="tooltip" title="Inquiry">
                                    <div class="facebook text-center mr-3">
                                        <i class="bi bi-person-lines-fill"></i>
                                    </div>
                                </a>
                                 
                                <a href="faq" data-toggle="tooltip" title="Frequenty asked questions">
                                    <div class="linkedin text-center mr-3">
                                        <i class="bi bi-info"></i>
                                    </div>
                                </a>

                            </div>
                            <div class="row px-3 mb-4">
                                <div class="line"></div>
                                <small class="or text-center">Forgot Password</small>
                                <div class="line"></div>
                            </div>
                            <div class="row px-3">
                                <label class="mb-1" style="text-transform:capitalize">
                                    <h6 class="mb-0 text-sm">Email Address
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Email Address" style="color:red; text-transform:capitalize" ControlToValidate="email">*</asp:RequiredFieldValidator>
                                    </h6>
                                </label> 
                                <asp:TextBox ID="email" required TextMode="Email" runat="server" class="mb-4" placeholder="Enter a valid email address"></asp:TextBox>
                            </div> 
                            <div class="row px-3 mb-4"> 
                                <a href="login" class="ml-auto mb-0 text-sm">Click here to login</a>
                            </div>
                            <div class="row mb-3 px-3"> 
                               
                                <button type="submit" id="btnRecover" runat="server" onserverclick="btnRecover_Click" class="btn text-center" style="background-color: #3D8080; color: white; width: 200px;">
                                    Recover
                                </button> 
                            </div> 
                            <br />
                            <div class="alert alert-danger" role="alert" runat="server" visible="false" id="errordiv">
                                <asp:Label runat="server" ID="lblError" Text=""></asp:Label>
                            </div>
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" style="text-transform:capitalize;color:red;" />
                        </div>
                    </div>
                    
                </div>
               
            </div> 

        <script>
            $(document).ready(function () {
                $('[data-toggle="tooltip"]').tooltip();
            });
        </script>

    </form> 
</body>
</html>

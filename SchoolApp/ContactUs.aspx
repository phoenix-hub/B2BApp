<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ContactUs.aspx.cs" Inherits="SchoolApp.ContactUs" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>ContactUs</title>
    <link href='https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css' rel='stylesheet'>
    <link href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css' rel='stylesheet'>
    <link href="Scripts/WebForms/loginforms/login.css" rel="stylesheet" />
    <script type='text/javascript' src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
    <script type='text/javascript' src='https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js'></script>
    <script type='text/javascript'></script>
    <link href="Scripts/WebForms/loginforms/login.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css">
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid px-1 px-md-5 px-lg-1 px-xl-5 py-5 mx-auto">
            <div class="card card0 border-0">
                <div class="row d-flex">
                    <div class="col-lg-6">

                        <div class="card1 pb-5">
                            <div class="row">
                                <img src="https://i.imgur.com/CXQmsmF.png" class="logo">
                            </div>

                            <div class="card2 card border-0 px-4 py-5">
                                <div class="row mb-4 px-3">

                                    <a href="login" data-toggle="tooltip" title="Go to login">
                                        <div class="facebook text-center mr-3">
                                            <i class="bi bi-box-arrow-in-right"></i>
                                        </div>
                                    </a>

                                    <a href="ContactUs" data-toggle="tooltip" title="Contact to us">
                                        <div class="facebook text-center mr-3">
                                            <i class="bi bi-person-lines-fill"></i>
                                        </div>
                                    </a>


                                    <a href="Inquiry" data-toggle="tooltip" title="Inquiry form">
                                        <div class="twitter text-center mr-3">
                                            <i class="bi bi-question"></i>
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
                                    <small class="or text-center">Contact Us</small>
                                    <div class="line"></div>
                                </div>
                                <div class="row px-3">
                                    <label class="mb-1">
                                        <h6 class="mb-0 text-sm">Name</h6>
                                    </label>
                                    <input class="mb-4" type="text" name="name" placeholder="Enter a full name">
                                </div>
                                <div class="row px-3">
                                    <label class="mb-1">
                                        <h6 class="mb-0 text-sm">Email Address</h6>
                                    </label>
                                    <input class="mb-4" type="text" name="email" placeholder="Enter a valid email address">
                                </div>
                                <div class="row px-3">
                                    <label class="mb-1">
                                        <h6 class="mb-0 text-sm">Message</h6>
                                    </label>
                                    <textarea type="text" name="message" placeholder="Write your message here" aria-multiline="true"></textarea>
                                </div>
                                <div class="row px-3 mb-4">
                                </div>
                                <div class="row mb-3 px-3">
                                    <button type="submit" class="btn btn-blue text-center">Save</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="card1 pb-5">
                            <div class="row">
                            </div>

                        </div>
                        <div class="card2 card border-0 px-4 py-5">
                            <div class="row mb-4 px-3">
                            </div>
                        </div>

                        <div class="row px-3 justify-content-center mt-4 mb-5 border-line">
                            <!--Grid column-->
                            <div class="col-md-3 text-center">
                                <ul class="list-unstyled mb-0">
                                    <li>
                                        <h1><i class="bi bi-geo-alt"></i></h1>
                                        <p>San Francisco, CA 94126, USA</p>
                                    </li>

                                    <li>
                                        <h1><i class="bi bi-telephone-outbound"></i></h1>
                                        <p>+ 01 234 567 89</p>
                                    </li>

                                    <li>
                                        <h1><i class="bi bi-envelope-open"></i></h1>
                                        <p>contact@mdbootstrap.com</p>
                                    </li>
                                </ul>
                            </div>
                            <!--Grid column-->
                        </div>
                    </div>
                </div>
                <div class="bg-blue py-4">
                    <div class="row px-3">
                        <small class="ml-4 ml-sm-5 mb-2">Copyright &copy; 2019. All rights reserved.</small>
                        <div class="social-contact ml-4 ml-sm-auto"><span class="fa fa-facebook mr-4 text-sm"></span><span class="fa fa-google-plus mr-4 text-sm"></span><span class="fa fa-linkedin mr-4 text-sm"></span><span class="fa fa-twitter mr-4 mr-sm-5 text-sm"></span></div>
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

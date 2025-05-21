<%-- 
    Document   : welcome
    Created on : Sep 12, 2024, 3:42:14 PM
    Author     : Dell Vostro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>Car Sales System</title>
    
    <link rel="shortcut icon" href="images/favicon.ico"/>
    
    <!--Bootstrap CSS-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <!--End of Bootstrap CSS-->
    
    <link rel="stylesheet" href="css/styles.css">
    
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
    <%@ include file="navbar.jsp" %>
    <div class="container-fluid">
        <div class="row">
            <div class="col d-flex centered-content">
                <%
                    // Retrieve session attributes
                    String username = (String) session.getAttribute("username");

                    if (username != null) {
                %>
                    <div class="welcome-message">
                        <p>Hello, <strong><%= username %></strong>!</p>
                        <p>Welcome to the Car Sales System!</p>
                    </div>
                <%
                    } else {
                %>
                    <div class="welcome-message">
                        <p>You are not logged in.</p>
                        <a href="home.jsp" class="btn btn-secondary">Login</a>
                    </div>
                <%
                    }
                %>
            </div>
        </div>
            
        <div class="row">
            <div class="col d-flex centered-content">
                <img src="images/logo_brown_bg.png" style="height: 200px;" alt="Car Sales System Logo">
            </div>
        </div>
            
        <div class="row">
            <div class="col d-flex centered-content">
                <div class="description-message">
                    <p>Make car buying and selling process easier, faster, and more convenient!</p>
                </div>
            </div>
        </div>
            
        <%
            // Retrieve session attributes
            String userRole = (String) session.getAttribute("role");

            if (userRole != null && userRole.equals("managing")) {
        %>
            <div class="row my-4">
                <div class="col-sm-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <span class="feature-icon">&#128663;</span>
                            <h3 class="card-title mt-3">Manage Car</h3>
                            <p>Add, update, or remove car listings to keep your inventory up to date.</p>
                            <a href="<c:url value='/Car' />" class="btn btn-custom">Start Now</a>
                        </div>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <span class="feature-icon">&#128179;</span>
                            <h3 class="card-title mt-3">Payment Analysis</h3>
                            <p>Track and analyze your company payments with our comprehensive dashboard.</p>
                            <a href="<c:url value='/PaymentAnalysis?type=daily' />" class="btn btn-custom">View Analysis</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <span class="feature-icon">&#128172;</span>
                            <h3 class="card-title mt-3">Feedback Analysis</h3>
                            <p>View customer feedback and ratings for a better purchasing experience.</p>
                            <a href="<c:url value='/FeedbackAnalysis' />" class="btn btn-custom">Analyze Feedback</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row mb-4">
                <div class="col-sm-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <span class="feature-icon">&#128100;</span>
                            <h3 class="card-title mt-3">Staff Management</h3>
                            <p>Manage staff profiles, assign roles, and track staff employment status.</p>
                            <a href="<c:url value='/ManagingStaff' />" class="btn btn-custom">Manage Staff</a>
                        </div>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <span class="feature-icon">&#128221;</span>
                            <h3 class="card-title mt-3">Edit Profile</h3>
                            <p>Update your personal details and account settings anytime.</p>
                            <a href="<c:url value='/Profile' />" class="btn btn-custom">Edit Profile</a>
                        </div>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <span class="feature-icon">&#128274;</span> <!-- Padlock emoji for Change Password -->
                            <h3 class="card-title mt-3">Change Password</h3>
                            <p>Update your password to ensure your account security. Make sure to use a strong password.</p>
                            <a href="<c:url value='/ChangePass' />" class="btn btn-custom">Change Password</a>
                        </div>
                    </div>
                </div>
            </div>
        <%
            } else if (userRole != null && userRole.equals("salesman")) {
        %>     
            <div class="row my-4">
                <div class="col-sm-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <span class="feature-icon">&#128197;</span>
                            <h3 class="card-title mt-3">Book a Car</h3>
                            <p>Schedule and manage car bookings for customers effectively.</p>
                            <a href="<c:url value='/Car' />" class="btn btn-custom">Book Now</a>
                        </div>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <span class="feature-icon">&#128179;</span>
                            <h3 class="card-title mt-3">Make Payment</h3>
                            <p>Process and record customer payments quickly and securely.</p>
                            <a href="<c:url value='/Payment' />" class="btn btn-custom">Make Payment</a>
                        </div>
                    </div>
                </div>  
                <div class="col-sm-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <span class="feature-icon">&#128200;</span>
                            <h3 class="card-title mt-3">View Sales Record</h3>
                            <p>View and manage the sales records to track performance and give comments on sales.</p>
                            <a href="<c:url value='/Sales' />" class="btn btn-custom">View Records</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row mb-4">
                <div class="col-sm-2"></div>
                <div class="col-sm-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <span class="feature-icon">&#128221;</span>
                            <h3 class="card-title mt-3">Edit Profile</h3>
                            <p>Update your personal details and account settings anytime.</p>
                            <a href="<c:url value='/Profile' />" class="btn btn-custom">Edit Profile</a>
                        </div>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <span class="feature-icon">&#128274;</span> <!-- Padlock emoji for Change Password -->
                            <h3 class="card-title mt-3">Change Password</h3>
                            <p>Update your password to ensure your account security. Make sure to use a strong password.</p>
                            <a href="<c:url value='/ChangePass' />" class="btn btn-custom">Change Password</a>
                        </div>
                    </div>
                </div>
            </div>
        <%
            } else if (userRole != null && userRole.equals("customer")) {
        %>
            <div class="row my-4">
                <div class="col-sm-2"></div>
                <div class="col-sm-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <span class="feature-icon">&#128179;</span>
                            <h3 class="card-title mt-3">View Purchase History</h3>
                            <p>Access your purchase history to review past transactions.</p>
                            <a href="<c:url value='/Purchase' />" class="btn btn-custom">View History</a>
                        </div>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <span class="feature-icon">&#128172;</span>
                            <h3 class="card-title mt-3">Give Feedback</h3>
                            <p>Provide feedback on your recent purchases to help us improve our service.</p>
                            <a href="<c:url value='/Purchase' />" class="btn btn-custom">Give Feedback</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row mb-4">
                <div class="col-sm-2"></div>
                <div class="col-sm-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <span class="feature-icon">&#128221;</span>
                            <h3 class="card-title mt-3">Edit Profile</h3>
                            <p>Update your personal details and account settings anytime.</p>
                            <a href="<c:url value='/Profile' />" class="btn btn-custom">Edit Profile</a>
                        </div>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <span class="feature-icon">&#128274;</span> <!-- Padlock emoji for Change Password -->
                            <h3 class="card-title mt-3">Change Password</h3>
                            <p>Update your password to ensure your account security. Make sure to use a strong password.</p>
                            <a href="<c:url value='/ChangePass' />" class="btn btn-custom">Change Password</a>
                        </div>
                    </div>
                </div>
            </div>
        <%
            }
        %>
    </div>
            
    <footer class="footer-bg text-dark text-center py-2">
        <p>&copy; 2024 Car Sales System. All rights reserved.</p>
    </footer>
    
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</body>
</html>

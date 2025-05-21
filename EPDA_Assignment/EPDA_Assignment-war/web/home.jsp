<%-- 
    Document   : home
    Created on : Sep 11, 2024, 3:17:18 PM
    Author     : Dell Vostro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>Car Sales System</title>
    
    <link rel="shortcut icon" href="images/favicon.ico"/>
    
    <!--Bootstrap CSS-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <!--End of Bootstrap CSS-->
</head>
<body>
    <div class="container-fluid text-center min-vh-100 p-0 d-flex align-items-center justify-content-center">
        <div class="row w-100">
            <div class="col-sm-6 min-vh-100 px-0">
                <img src="images/background.jpg" class="img-fluid" style="height: 100%;" alt="Car Sales System Logo">
            </div>
            <div class="col-sm-6 px-5 d-flex flex-column align-items-center justify-content-center">
                <div class="row w-100 justify-content-center mb-4">
                    <h2>Select your role to login...</h2>
                </div>
                <div class="row w-100 justify-content-center">
                    <div class="col-md-4 text-center mb-4">
                        <img src="images/managing_staff_icon.png" alt="Managing Staff Icon" class="img-fluid mb-2" style="max-width: 100px;">
                        <a href="<c:url value='login.jsp'>
                            <c:param name='userType' value='managing' />
                            </c:url>">
                            Managing Staff
                        </a>
                    </div>
                    
                    <div class="col-md-4 text-center mb-4">
                        <img src="images/salesman_icon.png" alt="Salesman Icon" class="img-fluid mb-2" style="max-width: 100px;">
                        <a href="<c:url value='login.jsp'>
                            <c:param name='userType' value='salesman' />
                            </c:url>">
                            Salesman
                        </a>
                    </div>
                    
                    <div class="col-md-4 text-center mb-4">
                        <img src="images/customer_icon.png" alt="Customer Icon" class="img-fluid mb-2" style="max-width: 100px;">
                        <a href="<c:url value='login.jsp'>
                            <c:param name='userType' value='customer' />
                            </c:url>">
                            Customer
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
    </body>
</html>
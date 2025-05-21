<%-- 
    Document   : login
    Created on : Sep 11, 2024, 1:35:38 PM
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
    
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <div class="container-fluid text-center min-vh-100 p-0 d-flex align-items-center justify-content-center">
        <div class="row w-100">
            <div class="col-sm-6 min-vh-100 px-0">
                <img src="images/background.jpg" class="img-fluid" style="height: 100%;" alt="Car Sales System Logo">
            </div>
            <div class="col-sm-6 px-5 d-flex flex-column align-items-center justify-content-center">
                <div class="row w-100">
                    <div class="col-12 d-flex justify-content-start mb-3">
                        <a href="home.jsp" class="btn p-0" id="btn-back" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="Back">
                            <i class="bi bi-arrow-left"></i>
                        </a>
                    </div>
                
                    <div class="col-12 d-flex flex-column align-items-center">
                        <c:choose>
                            <c:when test="${param.userType == 'managing'}">
                                <h2>Managing Staff Login</h2>
                            </c:when>
                            <c:when test="${param.userType == 'salesman'}">
                                <h2>Salesman Login</h2>
                            </c:when>
                            <c:when test="${param.userType == 'customer'}">
                                <h2>Customer Login</h2>
                            </c:when>
                            <c:otherwise>
                                <h2>Login</h2>
                            </c:otherwise>
                        </c:choose>

                        <c:if test="${not empty registersuccessMessage}">
                            <div class="alert alert-success" role="alert">
                                ${registersuccessMessage}
                            </div>
                        </c:if>
                                
                        <form action="Login" method="post" class="w-100">
                            <input type="hidden" name="userType" value="${param.userType}" />
                            <div class="row mb-2">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="username" name="username" placeholder="Username" autocomplete="off" required/>
                                </div>
                            </div>
                            <div class="row mb-2">
                                <div class="input-group">
                                    <input type="password" class="form-control" id="password" name="password" placeholder="Password" autocomplete="off" required/>
                                    <span class="input-group-text">
                                        <i class="bi bi-eye-slash-fill" id="togglePassword" style="cursor: pointer;"></i>
                                    </span>
                                </div>
                            </div>
                            <c:if test="${param.userType == 'customer'}">
                                <div class="row mb-2">
                                    <div class="col-sm-6">
                                        <a href="register.jsp" class="float-start" style="font-size: 13px;">New User?</a>
                                    </div>
                                </div>
                            </c:if>
                            
                            <!-- Display error message if any -->
                            <c:if test="${not empty param.error}">
                                <div class="alert alert-danger" role="alert">
                                    Invalid username or password. Please try again.
                                </div>
                            </c:if>
                            
                            <div class="row mb-2">
                                <div class="d-grid gap-2">
                                    <input type="submit" class="btn btn-secondary" value="Login" />
                                </div>
                            </div>
                        </form>
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
        
    <script type="text/javascript">
        $(document).ready(function() {
            $('[data-bs-toggle="tooltip"]').tooltip();
            
            $('#togglePassword').on('click', function() {
                var passwordField = $('#password');
                var type = (passwordField.attr('type') === 'password') ? 'text' : 'password';
                passwordField.attr('type', type);

                $(this).toggleClass('bi-eye-slash-fill bi-eye-fill');
            });
        });
    </script>
</body>
</html>
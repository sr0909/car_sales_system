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
    
    <title>New User Registration</title>
    
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
                        <a href="<c:url value='login.jsp'>
                            <c:param name='userType' value='customer' />
                            </c:url>" class="btn p-0" id="btn-back" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="Back">
                            <i class="bi bi-arrow-left"></i>
                        </a>
                        
                        <div class="col-12 d-flex flex-column align-items-center">
                            
                            <h2>New User Registration</h2>
                            
                            <form action="Register" method="post" class="w-100">
                            <div class="row mb-2">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="email" name="email" placeholder="Email Address" autocomplete="off" required/>
                                </div>
                            </div>
                            <div class="row mb-2">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="username" name="username" placeholder="Username" autocomplete="off" required/>
                                </div>
                            </div>
                            <div class="row mb-2">
                                <div class="input-group">
                                    <input type="password" class="form-control" id="password" name="password" placeholder="Password" autocomplete="off" required/>
                                </div>
                            </div>
                            <div class="row mb-2">
                                <div class="input-group">
                                    <input type="password" class="form-control" id="confirm_password" name="confirm_password" placeholder="Confirm Password" autocomplete="off" required/>
                                </div>
                            </div>
                            <!-- Display error message if any -->
                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger" role="alert">
                                    ${errorMessage}
                                </div>
                            </c:if>
                            <div class="row mb-2">
                                <div class="d-grid gap-2">
                                    <input type="submit" class="btn btn-secondary" value="Sign Up" />
                                </div>
                            </div>
                            </form>
                        </div>
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
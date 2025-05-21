<%-- 
    Document   : profile
    Created on : Sep 14, 2024, 12:31:56 AM
    Author     : Dell Vostro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>Profile</title>
    
    <link rel="shortcut icon" href="images/favicon.ico"/>
    
    <!--Bootstrap CSS-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <!--End of Bootstrap CSS-->
    
    <link href="https://unpkg.com/gijgo@1.9.14/css/gijgo.min.css" rel="stylesheet" type="text/css" >
    
    <link rel="stylesheet" href="css/styles.css">
    
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
    <%@ include file="navbar.jsp" %>
    
    <div class="card border-light mt-2" style="width: 100%;">
        <div class="card-body pt-1">
            <div class="d-flex justify-content-between align-items-center">
                <h5 class="card-title">Edit Profile</h5>
            </div>

            <hr class="hr">
            
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success" role="alert">
                    ${successMessage}
                </div>
            </c:if>
            
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger" role="alert">
                    ${errorMessage}
                </div>
            </c:if>
            
            <form action="EditProfile" method="POST" id="createForm">
            <c:choose>
                <c:when test="${hasData}">
                    <input type="hidden" name="mode" value="edit" />
                </c:when>
                <c:otherwise>
                    <input type="hidden" name="mode" value="create" />
                </c:otherwise>
            </c:choose>
                    
                <div class="row mb-2">
                    <div class="col-sm-2 mt-2">
                        <label class="fw-medium">Full Name</label>
                    </div>
                    <div class="col-sm-4">
                        <div class="input-group">
                            <input type="text" class="form-control" id="${not empty dbname ? dbname : ''}" name="${not empty dbname ? dbname : ''}" value="${not empty name ? name : ''}" autocomplete="off" maxlength="100" required/>
                        </div>
                    </div>
                    <div class="col-sm-2 mt-2">
                        <label class="fw-medium">Gender</label>
                    </div>
                    <div class="col-sm-4">
                        <div class="input-group">
                            <select class="form-select" id="gender" name="gender">
                                <option value="M" ${gender eq 'M' ? 'selected' : ''}>Male</option>
                                <option value="F" ${gender eq 'F' ? 'selected' : ''}>Female</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="row mb-2">
                    <div class="col-sm-2 mt-2">
                        <label class="fw-medium">Email</label>
                    </div>
                    <div class="col-sm-4">
                        <div class="input-group">
                            <input type="email" class="form-control" id="email" name="email" value="${not empty email ? email : ''}" autocomplete="off" maxlength="50" required readonly/>
                        </div>
                    </div>
                    <div class="col-sm-2 mt-2">
                        <label class="fw-medium">Phone Number</label>
                    </div>
                    <div class="col-sm-4">
                        <div class="input-group">
                            <input type="text" class="form-control" id="phone" name="phone" value="${not empty phone ? phone : ''}" autocomplete="off" maxlength="15" required/>
                        </div>
                    </div>
                </div>
                <div class="row mb-2">
                    <div class="col-sm-2 mt-2">
                        <label class="fw-medium">Street</label>
                    </div>
                    <div class="col-sm-10">
                        <div class="input-group">
                            <input type="text" class="form-control" id="street" name="street" value="${not empty street ? street : ''}" autocomplete="off" maxlength="100" required/>
                        </div>
                    </div>
                </div>
                <div class="row mb-2">
                    <div class="col-sm-2 mt-2">
                        <label class="fw-medium">City</label>
                    </div>
                    <div class="col-sm-4">
                        <div class="input-group">
                            <input type="text" class="form-control" id="city" name="city" value="${not empty city ? city : ''}" autocomplete="off" maxlength="50" required/>
                        </div>
                    </div>
                    <div class="col-sm-2 mt-2">
                        <label class="fw-medium">Zip Code</label>
                    </div>
                    <div class="col-sm-4">
                        <div class="input-group">
                            <input type="text" class="form-control" id="zip_code" name="zip_code" value="${not empty zip_code ? zip_code : ''}" autocomplete="off" maxlength="10" required/>
                        </div>
                    </div>
                </div>
                <div class="row mb-2">
                    <div class="col-sm-2 mt-2">
                        <label class="fw-medium">State</label>
                    </div>
                    <div class="col-sm-4">
                        <div class="input-group">
                            <input type="text" class="form-control" id="state" name="state" value="${not empty state ? state : ''}" autocomplete="off" maxlength="50" required/>
                        </div>
                    </div>
                    <div class="col-sm-2 mt-2">
                        <label class="fw-medium">Country</label>
                    </div>
                    <div class="col-sm-4">
                        <div class="input-group">
                            <input type="text" class="form-control" id="country" name="country" value="${not empty country ? country : ''}" autocomplete="off" maxlength="50" required/>
                        </div>
                    </div>
                </div>
                <div class="row mb-2">
                    <div class="col-sm-2 mt-2">
                        <label class="fw-medium">Date of Birth</label>
                    </div>
                    <div class="col-sm-4">
                        <div class="input-group">
                            <input type="text" class="form-control" id="dob" name="dob" value="${not empty dob ? dob : ''}" autocomplete="off" required/>
                        </div>
                    </div>
                    
                </div>
                        
                <div class="row mb-2 mt-3">
                    <div class="col text-end">
                        <button type="submit" class="btn btn-primary">Save</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
        
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://cdn.datatables.net/1.11.4/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.4/js/dataTables.bootstrap5.min.js"></script>
    
    <script src="https://unpkg.com/gijgo@1.9.14/js/gijgo.min.js" type="text/javascript"></script>

    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    
    <script type="text/javascript">
        $(document).ready(function() {
            // Function to format date as dd-mm-yyyy
            function formatDate(date) {
                var day = String(date.getDate()).padStart(2, '0');
                var month = String(date.getMonth() + 1).padStart(2, '0');
                var year = date.getFullYear();
                return day + '-' + month + '-' + year;
            }

            $('#dob').datepicker({
                uiLibrary: 'bootstrap5',
                format: 'dd-mm-yyyy', 
                maxDate: new Date(),
            });
        });
    </script>
</body>
</html>

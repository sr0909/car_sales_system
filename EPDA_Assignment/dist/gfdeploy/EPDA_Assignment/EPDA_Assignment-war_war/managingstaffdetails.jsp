<%-- 
    Document   : managingstaffdetails
    Created on : Sep 12, 2024, 6:04:34 PM
    Author     : Dell Vostro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>Staff Management</title>
    
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
                <h5 class="card-title">Staff Management</h5>
            </div>

            <hr class="hr">
            
            <!-- Display error message if any -->
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger" role="alert">
                    ${errorMessage}
                </div>
            </c:if>
            
            <c:choose>
                <c:when test="${mode == 'edit'}">
                    <form action="EditStaff" method="POST" id="createForm">
                    <input type="hidden" name="mode" value="update" />
                </c:when>
                <c:otherwise>
                    <form action="AddStaff" method="POST" id="createForm">
                </c:otherwise>
            </c:choose>
            <input type="hidden" name="staff_id" value="${not empty staff_id ? staff_id : ''}" />
                <div class="row mb-2">
                    <div class="col-sm-2 mt-2">
                        <label class="fw-medium">Role</label>
                    </div>
                    <div class="col-sm-4">
                        <div class="input-group">
                            <select class="form-select" id="role" name="role">
                                <option value=""></option>
                                <option value="managing" ${staffrole eq 'managing' ? 'selected' : ''}>Managing Staff</option>
                                <option value="salesman" ${staffrole eq 'salesman' ? 'selected' : ''}>Salesman</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-sm-2 mt-2">
                        <label class="fw-medium">Gender</label>
                    </div>
                    <div class="col-sm-4">
                        <div class="input-group">
                            <select class="form-select" id="gender" name="gender">
                                <option value=""></option>
                                <option value="M" ${gender eq 'M' ? 'selected' : ''}>Male</option>
                                <option value="F" ${gender eq 'F' ? 'selected' : ''}>Female</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="row mb-2">
                    <div class="col-sm-2 mt-2">
                        <label class="fw-medium">Full Name</label>
                    </div>
                    <div class="col-sm-4">
                        <div class="input-group">
                            <input type="text" class="form-control" id="staff_name" name="staff_name" value="${not empty staff_name ? staff_name : ''}" autocomplete="off" maxlength="100" required/>
                        </div>
                    </div>
                    <div class="col-sm-2 mt-2">
                        <label class="fw-medium">Salary</label>
                    </div>
                    <div class="col-sm-4">
                        <div class="input-group">
                            <input type="text" class="form-control" id="salary" name="salary" value="${not empty salary ? salary : ''}" autocomplete="off" maxlength="11" required/>
                        </div>
                    </div>
                </div>
                <div class="row mb-2">
                    <div class="col-sm-2 mt-2">
                        <label class="fw-medium">Email</label>
                    </div>
                    <div class="col-sm-4">
                        <div class="input-group">
                            <input type="email" class="form-control" id="email" name="email" value="${not empty email ? email : ''}" autocomplete="off" maxlength="50" required/>
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
                    <div class="col-sm-2 mt-2">
                        <label class="fw-medium">Status</label>
                    </div>
                    <div class="col-sm-4">
                        <div class="input-group">
                            <c:choose>
                                <c:when test="${not empty errorMessage}">
                                    <select class="form-select" id="status" name="status">
                                        <option value="Active" ${status eq 'Active' ? 'selected' : ''}>Active</option>
                                        <option value="Inactive" ${status eq 'Inactive' ? 'selected' : ''}>Inactive</option>
                                    </select>
                                </c:when>
                                <c:otherwise>
                                    <select class="form-select" id="status" name="status">
                                        <option value="Active" selected>Active</option>
                                        <option value="Inactive">Inactive</option>
                                    </select>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
                <div class="row mb-2">
                    <div class="col-sm-2 mt-2">
                        <label class="fw-medium">Hired Date</label>
                    </div>
                    <div class="col-sm-4">
                        <div class="input-group">
                            <input type="text" class="form-control" id="hired_date" name="hired_date" value="${not empty hired_date ? hired_date : ''}" autocomplete="off" required/>
                        </div>
                    </div>
                    <div class="col-sm-2 mt-2 terminatedDateContainer" style="display: none;">
                        <label class="fw-medium">Terminated Date</label>
                    </div>
                    <div class="col-sm-4 terminatedDateContainer" style="display: none;">
                        <div class="input-group">
                            <input type="text" class="form-control" id="terminated_date" name="terminated_date" autocomplete="off" />
                        </div>
                    </div>
                </div>
            
                <c:if test="${mode != 'edit'}">
                <div id = 'accInfoContainer'>
                    <h5 class="card-title" style="margin-top: 30px;">Account Info</h5>

                    <hr class="hr">

                    <div class="row mb-2">
                        <div class="col-sm-2 mt-2">
                            <label class="fw-medium">Username</label>
                        </div>
                        <div class="col-sm-4">
                            <div class="input-group">
                                <c:choose>
                                    <c:when test="${not empty errorMessage}">
                                        <input type="text" class="form-control" id="username" name="username" value="${not empty username ? username : ''}" autocomplete="off" maxlength="50" required/>
                                    </c:when>
                                    <c:otherwise>
                                        <input type="text" class="form-control" id="username" name="username" autocomplete="off" maxlength="50" required/>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="col-sm-2 mt-2">
                            <label class="fw-medium">Password</label>
                        </div>
                        <div class="col-sm-4">
                            <div class="input-group">
                                <input type="password" class="form-control" id="password" name="password" autocomplete="off" maxlength="50" required/>
                            </div>
                        </div>
                    </div>
                    <div class="row mb-2">
                        <div class="col-sm-2 mt-2">
                            <label class="fw-medium">Confirm Password</label>
                        </div>
                        <div class="col-sm-4">
                            <div class="input-group">
                                <input type="password" class="form-control" id="confirm_password" name="confirm_password" maxlength="50" autocomplete="off" required/>
                            </div>
                        </div>
                    </div>
                </div>
                </c:if>
            
                <div class="row mb-2 mt-3">
                    <div class="col text-end">
                        <a href="<c:url value='/ManagingStaff' />" class="btn btn-light">Cancel</a>
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
            $('#status').change(function() {
                var status = $(this).val();

                if (status == 'Inactive') {
                    $('.terminatedDateContainer').css('display', 'block');
                }else{
                    $('.terminatedDateContainer').css('display', 'none');
                }
            });
            
            // Function to format date as dd-mm-yyyy
            function formatDate(date) {
                var day = String(date.getDate()).padStart(2, '0');
                var month = String(date.getMonth() + 1).padStart(2, '0');
                var year = date.getFullYear();
                return day + '-' + month + '-' + year;
            }

            // Get today's date
            var today = new Date();
            var formattedToday = formatDate(today);

            $('#dob').datepicker({
                uiLibrary: 'bootstrap5',
                format: 'dd-mm-yyyy', 
                maxDate: new Date(),
            });

            $('#hired_date').datepicker({
                uiLibrary: 'bootstrap5',
                format: 'dd-mm-yyyy', 
                value: formattedToday
            });

            $('#terminated_date').datepicker({
                uiLibrary: 'bootstrap5',
                format: 'dd-mm-yyyy', 
                value: formattedToday
            });
            
            var hired = '${hired_date}';
            if (hired) {
                $('#hired_date').val(hired);
            }
            
            var terminated = '${terminated_date}';
            if (terminated) {
                $('#terminated_date').val(terminated);
            }
            
            $('#salary').on('keypress', function (e) {
                var charCode = (e.which) ? e.which : e.keyCode;
                // Allow only numbers and a single dot
                if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57)) {
                    e.preventDefault();
                }
                // Ensure only one dot is allowed
                if (charCode == 46 && $(this).val().indexOf('.') != -1) {
                    e.preventDefault();
                }
            });
        });
    </script>
</body>
</html>

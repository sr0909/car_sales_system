<%-- 
    Document   : cardetails
    Created on : Sep 14, 2024, 2:50:15 PM
    Author     : Dell Vostro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>Car Management</title>
    
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
                <c:choose>
                    <c:when test="${mode == 'edit'}">
                        <h5 class="card-title">Edit Car</h5>
                    </c:when>
                    <c:otherwise>
                        <h5 class="card-title">Add New Car</h5>
                    </c:otherwise>
                </c:choose>
            </div>

            <hr class="hr">
            
            <!-- Display error message if any -->
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger" role="alert">
                    ${errorMessage}
                </div>
            </c:if>
            
            <form action="AddCar" method="POST" id="createForm" enctype="multipart/form-data">
            <c:choose>
                <c:when test="${mode == 'edit'}">
<!--                    <form action="EditCar" method="POST" id="createForm">
                    <input type="hidden" name="mode" value="update" />-->
                    <input type="hidden" name="mode" value="edit" />
                </c:when>
                <c:otherwise>
                    <!--<form action="AddCar" method="POST" id="createForm">-->
                    <input type="hidden" name="mode" value="create" />
                </c:otherwise>
            </c:choose>
                        
            <input type="hidden" name="car_id" value="${not empty car_id ? car_id : ''}" />
                <div class="row mb-2">
                    <div class="col-sm-2 mt-2">
                        <label class="fw-medium">Brand Name</label>
                    </div>
                    <div class="col-sm-4">
                        <div class="input-group">
                            <c:choose>
                                <c:when test="${mode == 'edit'}">
                                    <input type="text" class="form-control" id="brand" name="brand" value="${not empty brand ? brand : ''}" autocomplete="off" maxlength="50" required readonly disabled/>
                                </c:when>
                                <c:otherwise>
                                    <select class="form-select" id="brand" name="brand">
                                        <option value=""></option>
                                        <c:forEach items="${brands}" var="brandName">
                                            <option value="${brandName}" ${brand eq brandName ? 'selected' : ''}>${brandName}</option>
                                        </c:forEach>
                                    </select>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="col-sm-2 mt-2">
                        <label class="fw-medium">Year</label>
                    </div>
                    <div class="col-sm-4">
                        <div class="input-group">
                            <div class="input-group">
                                <input type="number" class="form-control" id="year" name="year" value="${not empty year ? year : ''}" autocomplete="off" max="9999" required/>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mb-2">
                    <div class="col-sm-2 mt-2">
                        <label class="fw-medium">Model</label>
                    </div>
                    <div class="col-sm-4">
                        <div class="input-group">
                            <input type="text" class="form-control" id="model" name="model" value="${not empty model ? model : ''}" autocomplete="off" maxlength="50" required <c:if test="${mode == 'edit'}">readonly disabled</c:if>/>
                        </div>
                    </div>
                    <div class="col-sm-2 mt-2">
                        <label class="fw-medium">Mileage</label>
                    </div>
                    <div class="col-sm-4">
                        <div class="input-group">
                            <input type="number" class="form-control" id="mileage" name="mileage" value="${not empty mileage ? mileage : ''}" autocomplete="off" min="0" max="99999999999" required/>
                        </div>
                    </div>
                </div>
                <div class="row mb-2">
                    <div class="col-sm-2 mt-2">
                        <label class="fw-medium">Color</label>
                    </div>
                    <div class="col-sm-4">
                        <div class="input-group">
                            <input type="text" class="form-control" id="color" name="color" value="${not empty color ? color : ''}" autocomplete="off" maxlength="20" required/>
                        </div>
                    </div>
                    <div class="col-sm-2 mt-2">
                        <label class="fw-medium">Fuel Type</label>
                    </div>
                    <div class="col-sm-4">
                        <div class="input-group">
                            <input type="text" class="form-control" id="fuel_type" name="fuel_type" value="${not empty fuel_type ? fuel_type : ''}" autocomplete="off" maxlength="50" required/>
                        </div>
                    </div>
                </div>
                <div class="row mb-2">
                    <div class="col-sm-2 mt-2">
                        <label class="fw-medium">Engine Capacity</label>
                    </div>
                    <div class="col-sm-4">
                        <div class="input-group">
                            <input type="text" class="form-control" id="engine_capacity" name="engine_capacity" value="${not empty engine_capacity ? engine_capacity : ''}" autocomplete="off" maxlength="5" required/>
                        </div>
                    </div>
                    <div class="col-sm-2 mt-2">
                        <label class="fw-medium">Transmission</label>
                    </div>
                    <div class="col-sm-4">
                        <div class="input-group">
                            <select class="form-select" id="transmission" name="transmission">
                                <option value=""></option>
                                <option value="Automatic" ${transmission eq 'Automatic' ? 'selected' : ''}>Automatic</option>
                                <option value="Manual" ${transmission eq 'Manual' ? 'selected' : ''}>Manual</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="row mb-2">
                    <div class="col-sm-2 mt-2">
                        <label class="fw-medium">Price (RM)</label>
                    </div>
                    <div class="col-sm-4">
                        <div class="input-group">
                            <input type="text" class="form-control" id="price" name="price" value="${not empty price ? price : ''}" autocomplete="off" maxlength="11" required <c:if test="${status != 'Available' && mode == 'edit'}">readonly </c:if>/>
                        </div>
                    </div>
                    <div class="col-sm-2 mt-2">
                        <label class="fw-medium">Status</label>
                    </div>
                    <div class="col-sm-4">
                        <div class="input-group">
                            <select class="form-select" id="status" name="status">
                                <option value="Available" ${status eq 'Available' ? 'selected' : ''}>Available</option>
                                <option value="Booked" ${status eq 'Booked' ? 'selected' : ''}>Booked</option>
                                <option value="Paid" ${status eq 'Paid' ? 'selected' : ''}>Paid</option>
                                <option value="Canceled" ${status eq 'Canceled' ? 'selected' : ''}>Canceled</option>
                            </select>
                        </div>
                    </div>
                </div>
                         
                <c:if test="${mode != 'edit'}">
                    <div class="row mb-2">
                        <div class="col-sm-2 mt-2">
                            <label class="fw-medium">Car Image</label>
                        </div>
                        <div class="col-sm-4">
                            <div class="input-group">
                                <input type="file" class="form-control" id="img_path" name="img_path" accept="image/*" required>
                            </div>
                        </div>
                    </div>
                </c:if>
                            
                <c:if test="${status != 'Available' && mode == 'edit'}">
                    <div class="row mb-2">
                        <div class="col-sm-2 mt-2">
                            <label class="fw-medium">Customer Name</label>
                        </div>
                        <div class="col-sm-4">
                            <div class="input-group">
                                <input type="text" class="form-control" id="customer_name" name="customer_name" value="${not empty customer_name ? customer_name : ''}" autocomplete="off" maxlength="100" required readonly disabled/>
                            </div>
                        </div>
                        <div class="col-sm-2 mt-2">
                            <label class="fw-medium">Handled By</label>
                        </div>
                        <div class="col-sm-4">
                            <div class="input-group">
                                <input type="text" class="form-control" id="staff_name" name="staff_name" value="${not empty staff_name ? staff_name : ''}" autocomplete="off" maxlength="100" required readonly disabled/>
                            </div>
                        </div>
                    </div>
                </c:if>
                        
                <div class="row mb-2 mt-3">
                    <div class="col text-end">
                        <a href="<c:url value='/Car' />" class="btn btn-light">Cancel</a>
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
            $('#engine_capacity').on('keypress', function (e) {
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
            
            $('#price').on('keypress', function (e) {
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

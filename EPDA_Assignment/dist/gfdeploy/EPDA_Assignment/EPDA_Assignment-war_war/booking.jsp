<%-- 
    Document   : booking
    Created on : Sep 14, 2024, 11:22:14 PM
    Author     : Dell Vostro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>Booking</title>
    
    <link rel="shortcut icon" href="images/favicon.ico"/>
    
    <!--Bootstrap CSS-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <!--End of Bootstrap CSS-->
    
    <link href="https://unpkg.com/gijgo@1.9.14/css/gijgo.min.css" rel="stylesheet" type="text/css" >
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    
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
                <h5 class="card-title">Booking Confirmation</h5>
            </div>

            <hr class="hr">
            
            <div class="row mb-2">
                <div class="col-sm-6">
                    <img src="${img_path}" class="img-fluid" style="width: 100%;" alt="Car Photo">
                </div>
                
                <div class="col-sm-6">
                    <form action="Booking" method="POST" id="createForm">
                        <input type="hidden" name="car_id" value="${not empty car_id ? car_id : ''}" />
                        <input type="hidden" name="staff_id" value="${not empty staff_id ? staff_id : ''}" />
                        <input type="hidden" name="price" value="${not empty price ? price : ''}" />
                        
                        <div class="row mb-2">
                            <div class="col-sm-2 mt-2">
                                <label class="fw-medium">Brand</label>
                            </div>
                            <div class="col-sm-4">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="brand" name="brand" value="${not empty brand ? brand : ''}" autocomplete="off" maxlength="50" required readonly disabled/>
                                </div>
                            </div>
                            <div class="col-sm-2 mt-2">
                                <label class="fw-medium">Year</label>
                            </div>
                            <div class="col-sm-4">
                                <div class="input-group">
                                    <div class="input-group">
                                        <input type="number" class="form-control" id="year" name="year" value="${not empty year ? year : ''}" autocomplete="off" max="9999" required readonly disabled/>
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
                                    <input type="text" class="form-control" id="model" name="model" value="${not empty model ? model : ''}" autocomplete="off" maxlength="50" required readonly disabled/>
                                </div>
                            </div>
                            <div class="col-sm-2 mt-2">
                                <label class="fw-medium">Mileage</label>
                            </div>
                            <div class="col-sm-4">
                                <div class="input-group">
                                    <input type="number" class="form-control" id="mileage" name="mileage" value="${not empty mileage ? mileage : ''}" autocomplete="off" min="0" max="99999999999" required readonly disabled/>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-2">
                            <div class="col-sm-2 mt-2">
                                <label class="fw-medium">Color</label>
                            </div>
                            <div class="col-sm-4">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="color" name="color" value="${not empty color ? color : ''}" autocomplete="off" maxlength="20" required readonly disabled/>
                                </div>
                            </div>
                            <div class="col-sm-2 mt-2">
                                <label class="fw-medium">Fuel Type</label>
                            </div>
                            <div class="col-sm-4">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="fuel_type" name="fuel_type" value="${not empty fuel_type ? fuel_type : ''}" autocomplete="off" maxlength="50" required readonly disabled/>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-2">
                            <div class="col-sm-2 mt-2">
                                <label class="fw-medium">Engine</label>
                            </div>
                            <div class="col-sm-4">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="engine_capacity" name="engine_capacity" value="${not empty engine_capacity ? engine_capacity : ''}" autocomplete="off" maxlength="5" required readonly disabled/>
                                </div>
                            </div>
                            <div class="col-sm-2 mt-2">
                                <label class="fw-medium">Transmission</label>
                            </div>
                            <div class="col-sm-4">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="transmission" name="transmission" value="${not empty transmission ? transmission : ''}" autocomplete="off" maxlength="50" required readonly disabled/>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-2">
                            <div class="col-sm-2 mt-2">
                                <label class="fw-medium">Price (RM)</label>
                            </div>
                            <div class="col-sm-4">
                                <div class="input-group">
                                    
                                    <input type="text" class="form-control" id="price" name="price" value="${not empty price ? price : ''}" autocomplete="off" maxlength="11" required readonly disabled/>
                                </div>
                            </div>
                        </div>
                                
                        <hr class="hr" style="margin-top: 20px;">
                        
                        <div class="row mb-2">
                            <div class="col-sm-2 mt-2">
                                <label class="fw-medium">Date</label>
                            </div>
                            <div class="col-sm-10">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="sales_date" name="sales_date" value="${not empty today_date ? today_date : ''}" autocomplete="off" required readonly/>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-2">
                            <div class="col-sm-2 mt-2 pe-0">
                                <label class="fw-medium">Handled By</label>
                            </div>
                            <div class="col-sm-10">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="staff_name" name="staff_name" value="${not empty staff_name ? staff_name : ''}" autocomplete="off" maxlength="100" required readonly/>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-2">
                            <div class="col-sm-2 mt-2">
                                <label class="fw-medium">Customer</label>
                            </div>
                            <div class="col-sm-10">
                                <div class="input-group">
                                    <select class="form-select" id="customer_id" name="customer_id" required>
                                        <option value=""></option>
                                        <c:forEach var="customer" items="${customerList}">
                                            <option value="${customer.customer_id}">${customer.customer_name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>
                        
                        <div class="row mt-3">
                            <div class="col text-end">
                                <a href="<c:url value='/Car' />" class="btn btn-light">Cancel</a>
                                <button type="submit" class="btn btn-success">Book</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
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
            $('#customer_id').select2({
                placeholder: 'Select a customer',
                allowClear: true
            });
        });
    </script>
</body>
</html>

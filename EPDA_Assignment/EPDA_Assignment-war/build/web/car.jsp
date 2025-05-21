<%-- 
    Document   : car
    Created on : Sep 14, 2024, 2:20:06 PM
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
                <c:choose>
                    <c:when test="${userRole eq 'managing'}">
                        <h5 class="card-title">Car Management</h5>
                        
                        <a href="<c:url value='/AddCar' />" class="btn btn-light" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="Create">
                            <i class="bi bi-plus-lg h3"></i>
                        </a>
                    </c:when>
                    <c:otherwise>
                        <h5 class="card-title">Make Booking</h5>
                    </c:otherwise>
                </c:choose>
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
            
            <c:if test="${userRole eq 'managing'}">
            <form action="Car" method="POST" id="createForm">
                <div class="row mb-4">
                    <div class="col-sm-2 mt-2">
                        <label class="fw-medium">Filter By Status</label>
                    </div>
                    <div class="col-sm-2">
                        <div class="input-group">
                            <select class="form-select" id="filter_status" name="filter_status">
                                <option value="ALL" ${filter_status eq 'ALL' ? 'selected' : ''}>ALL</option>
                                <option value="Available" ${filter_status eq 'Available' ? 'selected' : ''}>Available</option>
                                <option value="Booked" ${filter_status eq 'Booked' ? 'selected' : ''}>Booked</option>
                                <option value="Paid" ${filter_status eq 'Paid' ? 'selected' : ''}>Paid</option>
                                <option value="Canceled" ${filter_status eq 'Canceled' ? 'selected' : ''}>Canceled</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-sm-2">
                        <button type="submit" class="btn btn-light" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="Search">
                            <i class="bi bi-search"></i>
                        </button>
                    </div>
                </div>
            </form>
            </c:if>
            
            <c:choose>
                <c:when test="${hasData}">
                    <table class="table my-3" id="admin-data">
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>Car</th>
                                <th>Brand Name</th>
                                <th>Model</th>
                                <th>Year</th>
                                <th>Mileage</th>
                                <th>Fuel Type</th>
                                <th>Price (RM)</th>
                                <th>Status</th>
                                <th class="text-center">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="car" items="${carList}">
                                <tr>
                                    <td>${car.no}</td>
                                    <td>
                                        <img src="${car.img_path}" class="img-fluid" style="height: 100px; width: 140px;" alt="Car Photo">
                                    </td>
                                    <td>${car.brand}</td>
                                    <td>${car.model}</td>
                                    <td>${car.year}</td>
                                    <td>${car.mileage}</td>
                                    <td>${car.fuel_type}</td>
                                    <td>${car.price}</td>
                                    <td>${car.status}</td>
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${userRole eq 'managing'}">
                                                <div class="btn-group">
                                                    <c:choose>
                                                        <c:when test="${car.status eq 'Available'}">
                                                            <a href="javascript:void(0)" class="btn btn-light btn-sm me-2 edit-btn" data-id="${car.id}">
                                                                <i class="bi bi-pencil-fill"></i>
                                                            </a>
                                                            <a href="javascript:void(0)" class="btn btn-light btn-sm delete-btn" data-id="${car.id}">
                                                                <i class="bi bi-trash3-fill"></i>
                                                            </a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="javascript:void(0)" class="btn btn-light btn-sm me-2 edit-btn" data-id="${car.id}">
                                                                <i class="bi bi-pencil-fill"></i>
                                                            </a>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="text-center"><a href="javascript:void(0)" class="btn btn-light btn-sm book-btn" data-id="${car.id}">Book</a></div>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <p>No car data available.</p>
                </c:otherwise>
            </c:choose>
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
            $('[data-bs-toggle="tooltip"]').tooltip();
            
            $('#admin-data').DataTable();
            
            $(document).on('click', '.book-btn', function() {
                var dataId = $(this).data('id');

                window.location.href = "${pageContext.request.contextPath}/Booking?carId=" + dataId;
            });
            
            $(document).on('click', '.edit-btn', function() {
                var dataId = $(this).data('id');

                window.location.href = "${pageContext.request.contextPath}/AddCar?carId=" + dataId;
            });
            
            $(document).on('click', '.delete-btn', function() {
                var dataId = $(this).data('id');

                Swal.fire({
                    title: "Are you sure to delete this car?",
                    text: "You won't be able to revert this!",
                    icon: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#3085d6",
                    cancelButtonColor: "#d33",
                    confirmButtonText: "Yes, delete it!"
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = "${pageContext.request.contextPath}/DeleteCar?carId=" + dataId;
                    }
                });
            });
        });
    </script>
</body>
</html>

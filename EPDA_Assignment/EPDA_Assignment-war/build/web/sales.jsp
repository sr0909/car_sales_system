<%-- 
    Document   : sales
    Created on : Sep 16, 2024, 12:05:44 AM
    Author     : Dell Vostro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>Sales</title>
    
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
                <h5 class="card-title">Sales</h5>
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
            
            <form action="Sales" method="POST" id="createForm">
                <div class="row mb-4">
                    <div class="col-sm-2 mt-2">
                        <label class="fw-medium">Filter By Status</label>
                    </div>
                    <div class="col-sm-2">
                        <div class="input-group">
                            <select class="form-select" id="filter_status" name="filter_status">
                                <option value="ALL" ${filter_status eq 'ALL' ? 'selected' : ''}>ALL</option>
                                <option value="Pending" ${filter_status eq 'Pending' ? 'selected' : ''}>Pending</option>
                                <option value="Completed" ${filter_status eq 'Completed' ? 'selected' : ''}>Completed</option>
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
            
            <c:choose>
                <c:when test="${hasData}">
                    <table class="table my-3" id="admin-data">
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>Car</th>
                                <th>Sales Date</th>
                                <th>Customer Name</th>
                                <th>Brand Name</th>
                                <th>Model</th>
                                <th>Price (RM)</th>
                                <th>Status</th>
                                <th class="text-center">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="sales" items="${salesList}">
                                <tr>
                                    <td>${sales.no}</td>
                                    <td>
                                        <img src="${sales.img_path}" class="img-fluid" style="height: 100px; width: 140px;" alt="Car Photo">
                                    </td>
                                    <td>${sales.sales_date}</td>
                                    <td>${sales.customer_name}</td>
                                    <td>${sales.brand}</td>
                                    <td>${sales.model}</td>
                                    <td>${sales.price}</td>
                                    <td>${sales.status}</td>
                                    <td class="text-center">
                                        <div class="text-center">
                                            <a href="javascript:void(0)" class="btn btn-light btn-sm edit-btn" data-id="${sales.id}">
                                                <i class="bi bi-pencil-fill"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <p>No sales data available.</p>
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
            
            $(document).on('click', '.edit-btn', function() {
                var dataId = $(this).data('id');

                window.location.href = "${pageContext.request.contextPath}/SalesDetails?salesId=" + dataId;
            });
        });
    </script>
</body>
</html>

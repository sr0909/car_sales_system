<%-- 
    Document   : managingstaff
    Created on : Sep 12, 2024, 4:58:39 PM
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
    
    <!-- DataTables CSS -->
    <!--<link rel="stylesheet" href="https://cdn.datatables.net/1.13.1/css/jquery.dataTables.min.css">-->
    <!--End of DataTables CSS-->
    
    <link href="https://unpkg.com/gijgo@1.9.14/css/gijgo.min.css" rel="stylesheet" type="text/css" >

    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    
    <link rel="stylesheet" href="css/styles.css">
    
<!--    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>-->
</head>
<body>
    <%@ include file="navbar.jsp" %>
    
    <div class="card border-light mt-2" style="width: 100%;">
        <div class="card-body pt-1">
            <div class="d-flex justify-content-between align-items-center">
                <h5 class="card-title">Staff Management</h5>
                <a href="managingstaffdetails.jsp" class="btn btn-light" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="Create">
                    <i class="bi bi-plus-lg h3"></i>
                </a>
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
            
            <c:choose>
                <c:when test="${hasData}">
                    <table class="table my-3" id="admin-data">
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>Role</th>
                                <th>Full Name</th>
                                <th>Hired Date</th>
                                <th>Terminated Date</th>
                                <th>Salary</th>
                                <th>Status</th>
                                <th class="text-center">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="staff" items="${staffList}">
                                <tr>
                                    <td>${staff.no}</td>
                                    <td>${staff.role}</td>
                                    <td>${staff.staff_name}</td>
                                    <td>${staff.hired_date}</td>
                                    <td>${staff.terminated_date != null ? staff.terminated_date : ""}</td>
                                    <td>${staff.salary}</td>
                                    <td>${staff.status}</td>
                                    <td class="text-center">
                                        <div class="btn-group">
                                            <a href="javascript:void(0)" class="btn btn-light btn-sm me-2 edit-btn" data-id="${staff.id}">
                                                <i class="bi bi-pencil-fill"></i>
                                            </a>
                                            <a href="javascript:void(0)" class="btn btn-light btn-sm delete-btn" data-id="${staff.id}">
                                                <i class="bi bi-trash3-fill"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <p>No managing staff data available.</p>
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

                window.location.href = "${pageContext.request.contextPath}/EditStaff?staffId=" + dataId;
            });
            
            $(document).on('click', '.delete-btn', function() {
                var dataId = $(this).data('id');

                Swal.fire({
                    title: "Are you sure to delete this?",
                    text: "You won't be able to revert this!",
                    icon: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#3085d6",
                    cancelButtonColor: "#d33",
                    confirmButtonText: "Yes, delete it!"
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = "${pageContext.request.contextPath}/DeleteStaff?staffId=" + dataId;
                    }
                });
            });
        });
    </script>
</body>
</html>

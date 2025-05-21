<%-- 
    Document   : paymentanalysis
    Created on : Sep 16, 2024, 5:49:23 PM
    Author     : Dell Vostro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>Payment Analysis</title>
    
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
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <%@ include file="navbar.jsp" %>
    
    <div class="card border-light mt-2" style="width: 100%;">
        <div class="card-body pt-1">
            <div class="d-flex justify-content-between align-items-center">
                <c:choose>
                    <c:when test="${param.type eq 'daily'}">
                        <h5 class="card-title">Daily Payment Analysis</h5>
                    </c:when>
                    <c:when test="${param.type eq 'monthly'}">
                        <h5 class="card-title">Monthly Payment Analysis</h5>
                    </c:when>
                </c:choose>
            </div>

            <hr class="hr">
            
            <form action="PaymentAnalysis" method="POST" id="createForm">
                <input type="hidden" name="type" value="<c:out value="${param.type}" />" />
                
                <div class="row mb-4">
                    <div class="col-sm-2 mt-2">
                        <c:choose>
                            <c:when test="${param.type eq 'daily'}">
                                <label class="fw-medium">Please select a month</label>
                            </c:when>
                            <c:when test="${param.type eq 'monthly'}">
                                <label class="fw-medium">Please select a year</label>
                            </c:when>
                        </c:choose>
                    </div>
                    <div class="col-sm-2">
                        <div class="input-group">
                            <c:choose>
                                <c:when test="${param.type eq 'daily'}">
                                    <select class="form-select" id="filter_month" name="filter_month" required>
                                        <option value=""></option>
                                        <option value="1" ${filter_month eq '1' ? 'selected' : ''}>January</option>
                                        <option value="2" ${filter_month eq '2' ? 'selected' : ''}>February</option>
                                        <option value="3" ${filter_month eq '3' ? 'selected' : ''}>March</option>
                                        <option value="4" ${filter_month eq '4' ? 'selected' : ''}>April</option>
                                        <option value="5" ${filter_month eq '5' ? 'selected' : ''}>May</option>
                                        <option value="6" ${filter_month eq '6' ? 'selected' : ''}>June</option>
                                        <option value="7" ${filter_month eq '7' ? 'selected' : ''}>July</option>
                                        <option value="8" ${filter_month eq '8' ? 'selected' : ''}>August</option>
                                        <option value="9" ${filter_month eq '9' ? 'selected' : ''}>September</option>
                                        <option value="10" ${filter_month eq '10' ? 'selected' : ''}>October</option>
                                        <option value="11" ${filter_month eq '11' ? 'selected' : ''}>November</option>
                                        <option value="12" ${filter_month eq '12' ? 'selected' : ''}>December</option>
                                    </select>
                                </c:when>
                                <c:when test="${param.type eq 'monthly'}">
                                    <select class="form-select" id="filter_year" name="filter_year" required>
                                        <option value=""></option>
                                        <option value="2024" ${filter_year eq '2024' ? 'selected' : ''}>2024</option>
                                        <option value="2025" ${filter_year eq '2025' ? 'selected' : ''}>2025</option>
                                        <option value="2026" ${filter_year eq '2026' ? 'selected' : ''}>2026</option>
                                        <option value="2027" ${filter_year eq '2027' ? 'selected' : ''}>2027</option>
                                        <option value="2028" ${filter_year eq '2028' ? 'selected' : ''}>2028</option>
                                    </select>
                                </c:when>
                            </c:choose>
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
                <c:when test="${param.type eq 'daily' and hasData}">
                    <canvas id="dailyPaymentsChart" width="400" height="170"></canvas>

                    <c:set var="days" value="${days}" />
                    <c:set var="payments" value="${payments}" />
                </c:when>
                
                <c:when test="${param.type eq 'monthly' and hasData}">
                    <canvas id="monthlyPaymentsChart" width="400" height="170"></canvas>

                    <c:set var="months" value="${months}" />
                    <c:set var="payments" value="${payments}" />
                </c:when>
                
                <c:otherwise>
                    <p>No analysis data available.</p>
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
            <c:choose>
                <c:when test="${param.type eq 'daily' and hasData}">
                    var ctx = document.getElementById('dailyPaymentsChart').getContext('2d');

                    // Convert JSP arrays to JavaScript arrays
                    var days = ${days};
                    var payments = ${payments};

                    // Create the chart
                    var dailyPaymentsChart = new Chart(ctx, {
                        type: 'line',
                        data: {
                            labels: days,
                            datasets: [{
                                label: 'Payments',
                                data: payments,
                                borderColor: 'rgba(75, 192, 192, 1)',
                                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                                fill: true,
                            }]
                        },
                        options: {
                            scales: {
                                x: {
                                    title: {
                                        display: true,
                                        text: 'Days of the Month', // Label for x-axis
                                    }
                                },
                                y: {
                                    beginAtZero: true,
                                    title: {
                                        display: true,
                                        text: 'Price (RM)', // Label for y-axis
                                    }
                                }
                            }
                        }
                    });
                </c:when>
                <c:when test="${param.type eq 'monthly' and hasData}">
                    var ctxMonthly = document.getElementById('monthlyPaymentsChart').getContext('2d');

                    var months = [
                        <c:forEach var="month" items="${months}" varStatus="status">
                            "${month}"<c:if test="${!status.last}">,</c:if>
                        </c:forEach>
                    ];

                    var payments = [
                        <c:forEach var="payment" items="${payments}" varStatus="status">
                            ${payment}<c:if test="${!status.last}">,</c:if>
                        </c:forEach>
                    ];
                    
                    // Create the monthly payments chart
                    new Chart(ctxMonthly, {
                        type: 'bar',
                        data: {
                            labels: months,
                            datasets: [{
                                label: 'Payments',
                                data: payments,
                                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                                borderColor: 'rgba(75, 192, 192, 1)',
                                borderWidth: 1
                            }]
                        },
                        options: {
                            scales: {
                                x: {
                                    title: {
                                        display: true,
                                        text: 'Month'
                                    }
                                },
                                y: {
                                    beginAtZero: true,
                                    title: {
                                        display: true,
                                        text: 'Price (RM)'
                                    }
                                }
                            }
                        }
                    });
                </c:when>
            </c:choose>
        });
    </script>
</body>
</html>

<%-- 
    Document   : purchasedetails
    Created on : Sep 16, 2024, 2:52:42 PM
    Author     : Dell Vostro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>Purchase</title>
    
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
                    <c:when test="${mode eq 'Completed'}">
                        <h5 class="card-title">Purchase History</h5>
                    </c:when>
                    <c:otherwise>
                        <h5 class="card-title">View Pending Purchase</h5>
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
            
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success" role="alert">
                    ${successMessage}
                </div>
            </c:if>
                
            <div class="row mb-2">
                <div class="col-sm-6">
                    <img src="${img_path}" class="img-fluid" style="width: 100%;" alt="Car Photo">
                </div>
                
                <div class="col-sm-6">
                    <form action="PurchaseDetails" method="POST" id="createForm">
                        <input type="hidden" name="sales_id" value="${not empty sales_id ? sales_id : ''}" />
                        <input type="hidden" name="customer_id" value="${not empty customer_id ? customer_id : ''}" />
                        <input type="hidden" name="feedbackMode" value="${not empty feedbackMode ? feedbackMode : ''}" />
                        <input type="hidden" name="feedback_id" value="${not empty feedback_id ? feedback_id : ''}" />
                        
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
                                
                        <hr class="hr" style="margin-top: 20px;">
                        
                        <div class="row mb-2">
                            <div class="col-sm-2 mt-2">
                                <label class="fw-medium">Sales Date</label>
                            </div>
                            <div class="col-sm-4">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="sales_date" name="sales_date" value="${not empty sales_date ? sales_date : ''}" autocomplete="off" required readonly disabled/>
                                </div>
                            </div>
                            <div class="col-sm-2 mt-2 pe-0">
                                <label class="fw-medium">Handled By</label>
                            </div>
                            <div class="col-sm-4">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="staff_name" name="staff_name" value="${not empty staff_name ? staff_name : ''}" autocomplete="off" maxlength="100" required readonly disabled/>
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
                            <div class="col-sm-2 mt-2 pe-0">
                                <label class="fw-medium">Customer</label>
                            </div>
                            <div class="col-sm-4">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="customer_name" name="customer_name" value="${not empty customer_name ? customer_name : ''}" autocomplete="off" maxlength="100" required readonly disabled/>
                                </div>
                            </div>
                        </div>
                                
                        <c:if test="${mode eq 'Completed'}">
                            <div class="row mb-2">
                                <div class="col-sm-2 mt-2 pe-0">
                                    <label class="fw-medium">Amount</label>
                                </div>
                                <div class="col-sm-4">
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="amount_paid" name="amount_paid" value="${not empty amount_paid ? amount_paid : ''}" autocomplete="off" maxlength="11" required readonly disabled/>
                                    </div>
                                </div>
                                <div class="col-sm-2 mt-2 pe-0">
                                    <label class="fw-medium">Method</label>
                                </div>
                                <div class="col-sm-4">
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="payment_method" name="payment_method" value="${not empty payment_method ? payment_method : ''}" autocomplete="off" maxlength="50" required readonly disabled/>
                                    </div>
                                </div>
                            </div>
                            <div class="row mb-2">
                                <div class="col-sm-2 mt-2 pe-0">
                                    <label class="fw-medium">Balance</label>
                                </div>
                                <div class="col-sm-4">
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="balance" name="balance" value="${not empty balance ? balance : ''}" autocomplete="off" maxlength="11" required readonly disabled/>
                                    </div>
                                </div>
                                <div class="col-sm-2 mt-2">
                                    <label class="fw-medium">Pay Date</label>
                                </div>
                                <div class="col-sm-4">
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="payment_date" name="payment_date" value="${not empty payment_date ? payment_date : ''}" autocomplete="off" required readonly disabled/>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                              
                        <c:if test="${not empty comment}">
                            <div class="row mb-2">
                                <div class="col-sm-2 mt-2">
                                    <label class="fw-medium">Comment</label>
                                </div>
                                <div class="col-sm-10">
                                    <div class="input-group">
                                        <textarea class="form-control" id="comment" name="comment" row="3" required readonly disabled>${comment}</textarea>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                            
                        <!-- Feedback & Rating -->
                        <c:if test="${mode eq 'Completed'}">
                            <hr class="hr" style="margin-top: 20px;">
                            
                            <div class="row mb-2">
                                <div class="col-sm-2 mt-2">
                                    <label class="fw-medium">Feedback</label>
                                </div>
                                <div class="col-sm-10">
                                    <div class="input-group">
                                        <textarea class="form-control" id="feedback" name="feedback" row="3">${not empty feedback ? feedback : ''}</textarea>
                                    </div>
                                </div>
                            </div>
                                    
                            <div class="row mb-2">
                                <div class="col-sm-2 mt-2">
                                    <label class="fw-medium">Rating</label>
                                </div>       
                                <div class="col-sm-10">
                                    <div class="input-group">
                                        <div class="rating">
                                            <input type="radio" name="rating" id="star5" value="5" ${rating == 5 ? 'checked' : ''} />
                                            <label for="star5" title="5 stars"><i class="bi bi-star-fill"></i></label>
                                            <input type="radio" name="rating" id="star4" value="4" ${rating == 4 ? 'checked' : ''} />
                                            <label for="star4" title="4 stars"><i class="bi bi-star-fill"></i></label>
                                            <input type="radio" name="rating" id="star3" value="3" ${rating == 3 ? 'checked' : ''} />
                                            <label for="star3" title="3 stars"><i class="bi bi-star-fill"></i></label>
                                            <input type="radio" name="rating" id="star2" value="2" ${rating == 2 ? 'checked' : ''} />
                                            <label for="star2" title="2 stars"><i class="bi bi-star-fill"></i></label>
                                            <input type="radio" name="rating" id="star1" value="1" ${rating == 1 ? 'checked' : ''} />
                                            <label for="star1" title="1 star"><i class="bi bi-star-fill"></i></label>
                                        </div>
                                    </div>
                                </div> 
                            </div> 
                        </c:if>
                        
                        <div class="row mt-3">
                            <div class="col text-end">
                                <a href="<c:url value='/Purchase' />" class="btn btn-light">Cancel</a>
                                
                                <c:if test="${mode eq 'Completed'}">
                                    <button type="submit" class="btn btn-primary">Save</button>
                                </c:if>
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
    
</body>
</html>

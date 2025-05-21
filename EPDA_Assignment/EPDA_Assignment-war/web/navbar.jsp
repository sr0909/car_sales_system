<!-- navbar.jsp -->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
<!--    <a class="navbar-brand" href="#">Car Sales System</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>-->
    <div class="mx-2">
        <img src="images/logo.png" style="width: 50px;" alt="Car Sales Logo">
    </div>

    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link" href="welcome.jsp">Home</a>
            </li>
            <c:choose>
                <c:when test="${sessionScope.role == 'managing'}">
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/Car' />">Car</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Payment Analysis
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="<c:url value='/PaymentAnalysis?type=daily' />">Daily</a>
                            <a class="dropdown-item" href="<c:url value='/PaymentAnalysis?type=monthly' />">Monthly</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/FeedbackAnalysis' />">Feedback Analysis</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/ManagingStaff' />">Staff Management</a>
                    </li>
                </c:when>
                <c:when test="${sessionScope.role == 'salesman'}">
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/Car' />">Car</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/Payment' />">Payment</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/Sales' />">Sales</a>
                    </li>
                </c:when>
                <c:when test="${sessionScope.role == 'customer'}">
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/Purchase' />">Purchase</a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="nav-item">
                        <a class="nav-link" href="welcome.jsp">Home</a>
                    </li>
                </c:otherwise>
            </c:choose>
        </ul>
        <ul class="navbar-nav ml-auto" style="margin-left: auto;">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Profile
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="<c:url value='/Profile' />">Edit Profile</a>
                    <a class="dropdown-item" href="<c:url value='/ChangePass' />">Change Password</a>
                </div>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="home.jsp">Logout</a>
            </li>
        </ul>
    </div>
</nav>
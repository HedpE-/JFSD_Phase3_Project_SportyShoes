<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- jQuery Library -->
<script src="/path/to/cdn/jquery.slim.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css"
	integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"
	integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js"
	integrity="sha384-VHvPCCyXqtD5DqJeNxl2dtTyhF78xXNXdkwX1CZeRusQfRKp+tA7hAShOK/B/fQ2"
	crossorigin="anonymous"></script>
<title>Customer Registration System</title>
</head>
<body>
	<jsp:include page="navbar.jsp" />
	<div class="container mt-5 w-50">
		<div class="jumbotron">
			<h1 class="display-4">Customer Registration</h1>
			<br />
			<form action="register" method="post" class="justify-content-center">
				<div class="container w-75">
					<div class="row mb-3">
						<div class="col-md-6">
							<label for="fname">First name</label>
							<input type="text" class="form-control" id="fname" name="fname" placeholder="First Name" required>
						</div>
						<div class="col-md-6">
							<label for="lname">Last name</label>
							<input type="text" class="form-control" id="lname" name="lname" placeholder="Last Name" required>
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-md-6">
							<label for="username">Username</label>
							<input type="text" class="form-control" id="uname" name="username" placeholder="Username" required>
						</div>
						<div class="col-md-6">
							<label for="email">Email</label>
							<input type="email" class="form-control" id="email" name="email" placeholder="Email address" required>
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-md-6">
							<label for="password">Password</label>
							<input type="password" class="form-control" id="password" name="password" placeholder="Enter password" required>
						</div>
						<div class="col-md-6">
							<label for="rpassword">Repeat Password</label>
							<input type="password" class="form-control" id="rpassword" name="rpassword" placeholder="Repeat Password" required>
						</div>
					</div>
					<div class="form-check mb-4">
						<input class="form-check-input" type="checkbox" value="yes" id="admin_request" name="admin_request">
						<label class="form-check-label" for="admin_request">Request Admin access</label>
					</div>
					<c:if test="${param.redirect ne null && !param.redirect.equals('')}">
						<input type="hidden" name="redirect" value="${param.redirect}">
					</c:if>
					<div class="form-group w-100 text-center">
						<button type="submit" id="complete-registration" class="btn btn-primary w-50">Complete registration</button>
					</div> 
				</div>
			</form>
			<p class="text-center w-100">Have an account?
				<a href="signin${param.redirect ne null && !param.redirect.equals('') ? '?redirect=' + param.redirect : ''}">Sign In</a>
			</p>
		</div>
	</div>
	<jsp:include page="footer.jsp" />
	<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
		<div id="adminToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
			<div class="toast-header">
				<img src="..." class="rounded me-2" alt="...">
				<strong class="me-auto">SportyShoes</strong>
				<button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
			</div>
			<div class="toast-body">
				Your Admin request has been approved.
			</div>
		</div>
	</div>
    <script>
		let toastTrigger = document.getElementById('complete-registration');
		let toastLiveExample = document.getElementById('adminToast');
		if (toastTrigger != null) {
			toastTrigger.addEventListener('click', function () {
				let adminRequest = document.getElementById('admin_request').getState();
				if(adminRequest) {
					let toast = new bootstrap.Toast(toastLiveExample);
					
					toast.show();
				}
			})
		}
    </script>
</body>
</html>
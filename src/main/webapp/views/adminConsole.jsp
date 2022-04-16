<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
<title>Admin Console</title>
</head>
<body>
<div class="modal fade" id="adminModal" aria-labelledby="adminModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="adminModalLabel">Admin Console</h5>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
				<c:if test="${user.getRole().equals('admin')}">
					<div class="row mx-auto">
						<form class='form' action='changePassword' method='post'>
							<div class="row form-group ml-1">
								<label for="username"><strong>Change your admin password</strong></label>
								<input type="hidden" class="form-control" id="username" name="username" value="${user.getUsername()}">
						    </div>
							<div class="row form-group mb-3 text-center">
								<div class="col-md-6">
									<input type="password" class="form-control" name="password" placeholder="New Password" required>
								</div>
								<div class="col-md-6">
									<input type="password" class="form-control" name="rpassword" placeholder="Repeat new Password" required>
								</div>
						    </div>
							<button class='btn btn-primary' type='submit'>Change password</button>
						</form>
					</div>
					<hr/>
					<div class="col w-100 text-center">
						<div class="row"><label><strong>Shop Administration</strong></label></div>						
						<a href="adminMasterlist?view=shoes" class="f-n-hover btn btn-primary btn-md my-2 mx-2">Shoes</a>
						<a href="adminMasterlist?view=brands" class="f-n-hover btn btn-primary btn-md my-2 mx-2">Brands</a>
						<a href="adminMasterlist?view=categories" class="f-n-hover btn btn-primary btn-md my-2 mx-2">Categories</a>
						<a href="adminMasterlist?view=users" class="f-n-hover btn btn-primary btn-md my-2 mx-2">Users</a>
						<a href="adminMasterlist?view=purchases" class="f-n-hover btn btn-primary btn-md my-2 mx-2">Purchases</a>
					</div>
				</c:if>
			</div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
		</div>
	</div>
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
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
</head>
<body>
	<c:set var="user" value="${sessionScope.user}" />
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<a class="navbar-brand" href="home">Sporty Shoes</a>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto d-flex align-items-center justify-content-center">
				<li class="nav-item active">
					<a class="nav-link" href="products">Products</a>
				</li>
				<c:if test="${user ne null}">
					<li class="nav-item active">
						<a class="nav-link" href="purchases">History</a>
					</li>
				</c:if>
				<c:if test="${(param.error ne null && param.error != '') || (param.success ne null && param.success != '')}">
					<li class="nav-item" style="margin-left: 300px; align-self: center;">
						<c:if test="${param.error ne null && param.error != ''}">
							<div class="alert alert-danger py-1 m-0" role="alert">${param.error}</div>
						</c:if>
						<c:if test="${param.success ne null && param.success != ''}">
							<div class="alert alert-success py-1 m-0" role="alert">${param.success}</div>
						</c:if>
					</li>
				</c:if>
			</ul>
			<c:choose>
				<c:when test="${user ne null}">
					<div class='d-flex'>
						<ul class='navbar-nav mr-auto'>
							<li class='nav-item text-white d-flex align-items-center justify-content-center'>
								<svg xmlns='http://www.w3.org/2000/svg' width='32' height='32'
									fill='white' class='bi bi-person-circle mr-1' viewBox='0 0 16 16'>
									<path d='M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z' />
									<path fill-rule='evenodd'
										d='M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z' />
								</svg>
								&nbsp;${user.getUsername()}&nbsp;&nbsp;
							</li>
							<c:if test="${user.getRole().equals('admin')}">
								<li class='nav-item'>
									<button type='button'
										class='btn btn-outline-success mr-2 ml-3'
										data-toggle='modal' data-target='#adminModal'>Admin</button>
								</li>
							</c:if>
							<li class='nav-item'>
								<a href="logout" class="btn btn-outline-success mr-2">Logout</a>
							</li>
						</ul>
					</div>
				</c:when>
				<c:otherwise>
					<form class='form-inline my-2' action='login' method='post'>
						<input class='form-control mr-2' type='text' name='username'
							placeholder='Username' aria-label='Username' required>
						<input class='form-control mr-2' type='password' name='password'
							placeholder='Password' aria-label='Password' required>
						<button class='btn btn-outline-success' type='submit'>Login</button>
					</form>
					<c:if test="<%=!request.getRequestURI().contains(\"register.jsp\")%>">
						<a href="register" class="btn btn-outline-success ml-2">Register</a>
					</c:if>
				</c:otherwise>
			</c:choose>
		</div>
	</nav>
	<jsp:include page="/views/adminConsole.jsp" />
</body>
</html>
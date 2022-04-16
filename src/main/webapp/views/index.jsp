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
<title>Sporty Shoes Shop</title>
</head>
<body>
	<jsp:include page="navbar.jsp" />
	<div class="container mt-5 w-50">
		<div class="jumbotron">
			<h1 class="display-4 mb-3">
				Welcome
				<c:if test="${sessionScope.user ne null}">
					${sessionScope.user.getFname()}
				</c:if>
				<br />Find your perfect shoes!
			</h1>
			<form class="needs-validation" action="products">
				<div class="container w-75">
					<div class="row mb-3">
						<div class="col-md-6">
							<jsp:useBean id="crud" class="jfsd.assessments.phase3.SportyShoes.util.CrudHelper"/>
							<c:set var="categories" scope="page"
								value="${crud.getCategories()}" />
							<label for="category" class="form-label">Category</label> <select
								class="form-control custom-select" id="category" name="category">
								<option value="-1" selected>Choose...</option>
								<c:forEach var="category" items="${categories}">
									<option value="${category.getId()}">${category.getName()}</option>
								</c:forEach>
							</select>
						</div>
						<div class="col-md-6">
							<c:set var="brands" scope="page"
								value="${crud.getBrands()}" />
							<label for="brand" class="form-label">Brand</label> <select
								class="form-control custom-select" id="brand" name="brand">
								<option value="-1" selected>Choose...</option>
								<c:forEach var="brand" items="${brands}">
									<option value="${brand.getId()}">${brand.getName()}</option>
								</c:forEach>
							</select>
						</div>
					</div>
				</div>
				<div class="col text-center w-100 mt-5">
					<button type="submit" class="btn btn-primary w-25">Find your shoes</button>
				</div>
			</form>
		</div>
		<div class="jumbotron">
			<h1 class="display-4 mb-4">Featured Shoes</h1>
			<c:set var="featured" value="${crud.getShoes(4, true)}"/>
			<c:choose>
				<c:when test="${featured ne null && featured.size() > 0}">
					<ul class="list-group d-flex align-items-center justify-content-center">
						<c:forEach var="shoe" items="${featured}"
							varStatus="loopCount">
							<c:if test="${loopCount.index % 4 == 0}">
								<li class="list-group-item my-1"><div class="row">
							</c:if>
							<div class="card mx-2" style="width: 11rem;">
								<div class="card-header d-flex align-items-center justify-content-center" style="height: 9rem">
									<img src="assets/${shoe.getBrand().getAsset()}" class="img-fluid">
								</div>
								<div class="card-body">
									<p class="card-text"><strong>${shoe.getBrand().getName()}<br>${shoe.getModel()}</strong></p>
									<p class="card-text">${shoe.getCategory().getName()}</p>
								</div>
								<div class="card-footer">
									<h6 class="pt-3 text-170 text-600 text-primary-d1 letter-spacing">
										${shoe.getPrice()} EUR</h6>
									<div class="d-flex align-items-center justify-content-center">
<%-- 							           	<c:if test="${sessionScope.user ne null}"> --%>
											<a href="buy?id=${shoe.getId()}" class="btn btn-primary w-100">Buy</a>
<%-- 										</c:if> --%>
									</div>
								</div>
							</div>
							<c:if test="${loopCount.count % 4 == 0 || loopCount.count == sessionScope.shoesResult.size()}">
								</div></li>
							</c:if>
						</c:forEach>
					</ul>
<%-- 					<c:forEach var="shoe" items="${featured}" begin="0" end="4"> --%>
<!-- 						<div class="d-style border-2 bg-light w-100 my-2 py-3 shadow-sm"> -->
<!-- 							<div class="row align-items-center"> -->
<!-- 								<div class="col text-center"> -->
<!-- 									<h1 class="pt-3 text-170 text-600 text-primary-d1 letter-spacing"> -->
<!-- 										#${shoe.getId()} -->
<!-- 									</h1> -->
<!-- 									<p class="lead display-5 text-180"> -->
<%-- 										${shoe.getPrice()} EUR --%>
<!-- 									</p> -->
<!-- 								</div> -->
<!-- 								<div class="col-12 col-md-4"> -->
<!-- 									<h4 class="pt-3 text-170 text-600 text-primary-d1 letter-spacing"> -->
<%-- 										${shoe.getBrand().getName()} -> ${shoe.getModel()} --%>
<!-- 									</h4> -->
<!-- 									<div class="text-secondary-d1 text-120"> -->
<!-- 						            	<span class="text-180"> -->
<%-- 											${shoe.getCategory().getName()} --%>
<!-- 										</span> -->
<!-- 						            </div> -->
<!-- 								</div> -->
<!-- 								<div class="col text-center"> -->
<!-- 									<h4 class="pt-3 text-170 text-600 text-primary-d1 letter-spacing"> -->
<%-- 										${shoe.getPrice()} EUR --%>
<!-- 									</h4> -->
<!-- 									<form action='viewFlight'> -->
<%-- 										<input type='hidden' name='id' value="${shoe.getId()}"> --%>
<!-- 										<button type='submit' class='btn btn-primary mt-3'>View details</button> -->
<!-- 									</form> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<%-- 					</c:forEach> --%>
				</c:when>
				<c:otherwise>
					<h4 class="lead mt-5">
						No results found
					</h4>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<title>
	<c:set var="view" scope="page" value="${param.view.toLowerCase()}"/>
	<c:set var="view" scope="page" value="${view.substring(0, 1).toUpperCase().concat(view.substring(1))}"/>
	${view} Masterlist
</title>
</head>
<body>
	<jsp:include page="navbar.jsp" />
	<div class="container mt-5 w-50">
		<div class="jumbotron">
			<h1 class="display-4">Purchases Masterlist</h1>			
			<form action="purchasesMasterlist" method="post">
				<c:if test="${param.username == null}">
					<div class="row">
						<div class="col">
							<label for="categoryFilter" class="form-label">Category</label>
						</div>
						<div class="col">
							<label for="dateFilter" class="form-label">Purchase Date</label>
						</div>
						<div class="col">
						</div>
					</div>
					<div class="row">
						<div class="col">
							<jsp:useBean id="crud" class="jfsd.assessments.phase3.SportyShoes.util.CrudHelper"/>
							<c:set var="categories" scope="page" value="${crud.getCategories()}" />
							<select class="form-control custom-select" id="categoryFilter" name="categoryFilter">
								<option value="-1" selected>All</option>
								<c:forEach var="category" items="${categories}">
									<option value="${category.getId()}">${category.getName()}</option>
								</c:forEach>
							</select>
						</div>
						<div class="col">
							<input type="date" class="form-control" id="dateFilter" name="dateFilter">
						</div>
						<div class="col">
							<button class="btn btn-primary ml-2" type="submit">Filter Purchases</button>
							<a class="btn btn-secondary ml-4" href="adminMasterlist?view=purchases">Clear</a>
						</div>
					</div>
				</c:if>
				<c:if test="${param.username ne null}">
					<div class="row">
						<h4 class="text-primary-d1 letter-spacing pt-3 ml-3">For user:</h4><p class="lead mx-2 mt-3"><strong>${param.username}</strong></p>
					</div>
				</c:if>
				<div class="row mt-1">
					<h4 class="text-primary-d1 letter-spacing pt-3 ml-3">Purchases found:</h4><p class="lead mx-2 mt-3">${viewContext.size()}</p>
				</div>
			</form>
			<c:choose>
				<c:when test="${viewContext ne null && viewContext.size() > 0}">					
					<c:forEach var="purchase" items="${viewContext}">
						<div class="d-style bg-light w-100 my-2 py-3 shadow-sm">
							<div class="row align-items-center">
								<div class="col text-center">
									<h4 class="pt-3 text-primary-d1 letter-spacing">
										Purchase date
									</h4>
									<p class="lead display-5 mb-1">
										${purchase.getPurchase_date("dd-MM-yyyy")}
									</p>
									<h4 class="pt-1 text-primary-d1 letter-spacing">User</h4>
									<p class="lead display-5 mb-1">
										${purchase.getUsername()}
									</p>
										
								</div>
								<div class="col-10 col-md-5">
									<div class="row">
										<div class="col">
											<h4 class="pt-3 text-primary-d1 letter-spacing">
												${purchase.getShoe().getBrand().getName()}
											</h4>
											<p class="lead display-5 text-180">
													${purchase.getShoe().getModel()}
											</p>
											<p class="lead display-5 text-180">
													${purchase.getCategory().getName()}
											</p>
								        </div>
										<div class="col text-center">
											<h4 class="pt-3 text-primary-d1 letter-spacing">
												Quantity
											</h4>
											<p class="lead display-5 text-180">
												${purchase.getQuantity()}
											</p>
										</div>
									</div>
								</div>
								<div class="col text-center">
									<h4 class="pt-3 text-170 text-600 text-primary-d1 letter-spacing">
										Total price
									</h4>
									<p class="lead display-5 text-180">
										${purchase.getTotal_ammount()} EUR
									</p>
									<a href="purchaseDetails?id=${purchase.getId()}&redirect=adminMasterlist" class="f-n-hover btn btn-primary px-4 py-25 mb-3 text-600">View details</a>
								</div>
							</div>
						</div>
					</c:forEach>
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
	<jsp:include page="confirmDeleteModal.jsp" />
	<jsp:include page="entityEditorModal.jsp" />
</body>
</html>
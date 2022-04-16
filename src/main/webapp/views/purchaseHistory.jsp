<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
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
<title>History</title>
</head>
<body>
	<jsp:include page="navbar.jsp" />
	<div class="container mt-5 w-50">
		<div class="jumbotron">
			<h1 class="display-4 mb-3">Purchase History</h1>
			<c:choose>
				<c:when test="${purchasesResult ne null && purchasesResult.size() > 0}">
					<c:forEach var="purchase" items="${purchasesResult}">
						<div class="d-style bg-light w-100 my-2 py-3 shadow-sm">
							<div class="row align-items-center">
								<div class="col text-center">
									<h4 class="pt-3 text-primary-d1 letter-spacing">
										Purchase date
									</h4>
									<p class="lead display-5 text-180">
										${purchase.getPurchase_date("dd-MM-yyyy")}
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
									<a href="purchaseDetails?id=${purchase.getId()}&redirect=purchases" class="f-n-hover btn btn-primary px-4 py-25 mb-3 text-600">View details</a>
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
</body>
</html>
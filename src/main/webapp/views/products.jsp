<%@page language="java" contentType="text/html; charset=ISO-8859-1"
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
<title>Shoes</title>
</head>
<body>
	<jsp:include page="navbar.jsp" />
	<div class="container mt-5 w-50">
		<div class="jumbotron">
			<h1 class="display-4">
				<c:set var="hasParams"
					value="${(param.category ne null && param.category > -1) || (param.brand ne null && param.brand ne '') || (size ne null && size > -1)}" />
				<c:choose>
					<c:when test="${hasParams}">
					Filter results
				</c:when>
					<c:otherwise>
					Shoes Catalog
				</c:otherwise>
				</c:choose>
			</h1>
<%-- 			<c:set var="shoesResult" value="${sessionScope.shoesResult}" /> --%>
			<c:choose>
				<c:when test="${shoesResult ne null && shoesResult.size() > 0}">
					<ul class="list-group d-flex align-items-center justify-content-center">
						<c:forEach var="shoe" items="${shoesResult}"
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
				</c:when>
				<c:otherwise>
					<h4 class="lead mt-5">No results found</h4>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>
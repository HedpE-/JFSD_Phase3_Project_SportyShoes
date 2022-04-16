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
			<h1 class="display-4">${view} Masterlist</h1>
           	<c:if test="${sessionScope.user ne null && sessionScope.user.getRole().equals('admin') && !view.equals('Purchases') && !view.equals('Users')}">
				<button class="btn btn-primary w-25 my-2" data-href="add?view=${view.toLowerCase()}" data-toggle="modal" data-target="#entity-editor">Add new</button>
			</c:if>
			<c:choose>
				<c:when test="${viewContext ne null && viewContext.size() > 0}">
					<c:if test="${view.equals('Shoes')}">
						<ul class="list-group d-flex align-items-center justify-content-center">
							<c:forEach var="shoe" items="${viewContext}"
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
											<button class="btn btn-warning w-100 mt-2" data-href="delete?view=shoes&id=${shoe.getId()}"
												data-toggle="modal" data-target="#confirm-delete">Delete</button>
										</div>
									</div>
								</div>
								<c:if test="${loopCount.count % 4 == 0 || loopCount.count == sessionScope.shoesResult.size()}">
									</div></li>
								</c:if>
							</c:forEach>
						</ul>
					</c:if>
					<c:if test="${!view.equals('Shoes')}">
						<c:forEach var="obj" items="${viewContext}">
							<div class="d-style bg-light w-100 my-2 py-3 shadow-sm">
								<div class="row align-items-center">
									<div class="col text-center">
										<c:if test="${obj['class'].simpleName.equals('Purchase')}">
											<h4 class="pt-3 text-primary-d1 letter-spacing">
												Purchase date
											</h4>
											<p class="lead display-5 text-180">
												${purchase.getPurchase_date("dd-MM-yyyy")}
											</p>
										</c:if>
										<c:if test="${!obj['class'].simpleName.equals('Purchase')}">
											<h1 class="pt-3 text-170 text-600 text-primary-d1 letter-spacing">
								            	<c:if test="${obj['class'].simpleName.equals('User')}">
													${obj.getUsername()}
												</c:if>
												<c:if test="${!obj['class'].simpleName.equals('User')}">
													#${obj.getId()}
												</c:if>
											</h1>
										</c:if>
									</div>
									<c:if test="${obj['class'].simpleName.equals('Purchase')}">
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
									</c:if>
									<c:if test="${!obj['class'].simpleName.equals('Purchase')}">
										<div class="col-12 col-md-4">
											<h4 class="pt-3 text-170 text-600 text-primary-d1 letter-spacing">
								            	<c:if test="${obj['class'].simpleName.equals('User')}">
													${obj.getFname()} ${obj.getLname()}
												</c:if>
												<c:if test="${!obj['class'].simpleName.equals('User')}">
													${obj.getName()}
												</c:if>
											</h4>
											<c:if test="${!obj['class'].simpleName.equals('Category')}">
												<div class="text-secondary-d1 text-120">
									            	<span class="text-180">
										            	<c:if test="${obj['class'].simpleName.equals('Brand')}">
															${obj.getAsset()}
														</c:if>
														<c:if test="${obj['class'].simpleName.equals('User')}">
															Registered: ${obj.getCreate_time("dd-MM-yyyy HH:mm:ss")}
														</c:if>
													</span>
									            </div>
								            </c:if>
											<c:if test="${obj['class'].simpleName.equals('User')}">
												<div class="text-secondary-d1 text-120">
									            	<span class="text-180">
														Last login: ${obj.getLast_login("dd-MM-yyyy HH:mm:ss")}
													</span>
									            </div>
								            </c:if>
										</div>
									</c:if>
									<div class="col text-center">
										<c:if test="${obj['class'].simpleName.equals('Purchase')}">
											<h4 class="pt-3 text-170 text-600 text-primary-d1 letter-spacing">
												Total price
											</h4>
											<p class="lead display-5 text-180">
												${purchase.getTotal_ammount()} EUR
											</p>
											<a href="purchaseDetails?id=${purchase.getId()}&redirect=adminMasterlist" class="f-n-hover btn btn-primary px-4 py-25 mb-3 text-600">View details</a>
										</c:if>
										<c:if test="${!obj['class'].simpleName.equals('Purchase')}">
											<c:if test="${obj['class'].simpleName.equals('User')}">
												<a class="btn btn-primary w-75 my-2" href="adminMasterlist?view=purchases&username=${obj.getUsername()}">View Purchases</a>
								            </c:if>
											<button class="btn btn-warning w-75 mt-2" data-href="delete?view=${view.toLowerCase()}&${obj['class'].simpleName.equals('User') ? 'username' : 'id'}=${obj['class'].simpleName.equals('User') ? obj.getUsername() : obj.getId()}"
												data-toggle="modal" data-target="#confirm-delete">Delete</button>
										</c:if>
									</div>
								</div>
							</div>
						</c:forEach>
					</c:if>
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
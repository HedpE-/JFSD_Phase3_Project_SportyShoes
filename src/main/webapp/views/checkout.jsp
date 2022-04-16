<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Checkout</title>
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
<script>
	function calc() {
		let price = document.getElementById("price").innerHTML;
		let qty = document.getElementById("quantity").value;
		let total = parseFloat(price) * qty
		if (!isNaN(total)){
			document.getElementById("total").innerHTML = total + " EUR"
			document.getElementById("total_ammount").value = total
		}
	}
</script>
</head>
<body>
	<jsp:include page="navbar.jsp" />
	<c:set var="user" value="${sessionScope.user}" />
	<div class="container mt-5 w-60">
		<div class="jumbotron">
			<div class="py-5">
				<h1 class="display-4">Checkout Shoes</h1>
				<p class="lead">
					Just one step to go!<br />Please enter your Billing details on the
					form below to confirm your purchase.
				</p>
			</div>

			<form action="buy" method="post" class="needs-validation">
				<input type="hidden" id="shoeid" name="shoeid" value="${shoe.getId()}" required>
				<input type="hidden" id="username" name="username" value="${user.getUsername()}" required>
				<div class="row">
					<div class="col-md-4 order-md-2 mb-4">
						<ul class="list-group mb-3">
							<li class="list-group-item d-flex lh-condensed">
								<div class="col">
									<h6 class="my-0">${shoe.getBrand().getName()}<br />
										${shoe.getModel()}</h6>
									<small class="text-muted">${shoe.getCategory().getName()}<br />
										<input id="categoryid" name="categoryid" type="hidden" class="form-control" value="${shoe.getCategory().getId()}" required>
										<strong>Quantity: </strong>
									</small>
									<input type="number" class="form-control mt-1"
										style="max-width: 75px;" id="quantity" name="quantity"
										oninput="calc()" min="1" value="1" step="1" required>
								</div>
								<div class="col d-flex justify-content-right align-items-right">
									<span class="text-bold justify-content-end pl-5" id="price">${shoe.getPrice()}
										EUR</span>
									<input id="price" name="price" type="hidden" class="form-control" value="${shoe.getPrice()}" required>
								</div>
							</li>
						</ul>
						<h4 class="d-flex justify-content-between align-items-center mb-3">
							<span class="text-muted">Total</span>
							<span class="badge badge-secondary badge-pill" id="total">
								${shoe.getPrice()} EUR</span>
							<input type="hidden" id="total_ammount" name="total_ammount" value="${shoe.getPrice()}" required>
						</h4>
					</div>
					<div class="col-md-8 order-md-1">
						<h4 class="mb-3">Billing address</h4>
						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="fname">First name</label> <input type="text"
									class="form-control" id="fname" name="fname"
									value="${user.getFname()}" required disabled readonly>
							</div>
							<div class="col-md-6 mb-3">
								<label for="lname">Last name</label> <input type="text"
									class="form-control" id="lname" name="lname"
									value="${user.getLname()}" required disabled readonly>
							</div>
						</div>
						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="email">Email</label> <input type="email"
									class="form-control" id="email" name="email"
									value="${user.getEmail()}" required disabled readonly>
							</div>
							<div class="col-md-6 mb-3">
								<label for="uname">Username</label>
								<div class="input-group">
									<input type="text" class="form-control" id="uname" name="uname"
										value="${user.getUsername()}" required disabled readonly>
								</div>
							</div>
						</div>
						<div class="mb-3">
							<label for="address">Address</label> <input type="text"
								class="form-control" id="address" name="address"
								placeholder="1234 Main St" required>
							<div class="invalid-feedback">Please enter your shipping
								address.</div>
						</div>
						<div class="mb-3">
							<label for="address2">Address 2 <span class="text-muted">(Optional)</span></label>
							<input type="text" class="form-control" id="address2"
								name="address2" placeholder="House number">
						</div>
						<div class="row">
							<div class="col-md-5 mb-3">
								<label for="country">Country</label> <input type="text"
									class="form-control d-block w-100" id="country" name="country"
									placeholder="Portugal" required>
							</div>
							<div class="col-md-4 mb-3">
								<label for="city">City</label> <input type="text"
									class="form-control d-block w-100" id="city" name="city"
									placeholder="Lisbon" required>
							</div>
							<div class="col-md-3 mb-3">
								<label for="postcode">Postal or Zip code</label> <input
									type="text" class="form-control" id="postcode" name="postcode"
									placeholder="" required>
							</div>
						</div>
						<hr class="mb-4">

						<h4 class="mb-3">Payment</h4>

						<div class="d-block my-3">
							<div class="custom-control custom-radio">
								<input id="credit" name="payment_method" type="radio"
									class="custom-control-input" checked required> <label
									class="custom-control-label" for="credit">Credit card</label>
							</div>
						</div>
						<div class="card-details">
							<h3 class="title">Credit Card Details</h3>
							<div class="row">
								<div class="form-group col-sm-8">
									<div class="inner-addon right-addon">
										<label for="cc-name">Name on card</label> <i
											class="far fa-user"></i> <input id="cc-name" name="cc-name"
											type="text" class="form-control" placeholder="Card Holder"
											aria-label="Card Holder" aria-describedby="basic-addon1" required>
									</div>
								</div>
								<div class="form-group col-sm-4">
									<label for="cc-expiration">Expiration Date</label>
									<div class="input-group expiration-date">
										<input type="month" class="form-control" id="cc-expiration"
											name="cc-expiration" placeholder="MM" required>
									</div>
								</div>
								<div class="form-group col-sm-8">
									<div class="inner-addon right-addon">
										<label for="cc_number">Card Number</label> <i
											class="far fa-credit-card"></i> <input id="cc_number"
											name="cc_number" type="text" class="form-control"
											placeholder="Card Number" minlength="15" maxlength="15"
											min="000000000000000" max="999999999999999" step="1"
											pattern="[0-9]{15}" required>
									</div>
								</div>
								<div class="form-group col-sm-4">
									<label for="cc-cvv">CVV</label> <input id="cc-cvv"
										name="cc-cvv" type="text" class="form-control"
										placeholder="CVC" minlength="3" maxlength="3" min="000"
										max="999" step="1" pattern="[0-9]{3}" required>
								</div>
							</div>
						</div>
						<hr class="mb-4">
						<button class="btn btn-primary btn-md" type="submit">Confirm payment</button>
						<a href="products" class="f-n-hover btn btn-danger btn-md px-4 py-25 w-25 text-600">Cancel</a>
					</div>
				</div>
			</form>
		</div>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>

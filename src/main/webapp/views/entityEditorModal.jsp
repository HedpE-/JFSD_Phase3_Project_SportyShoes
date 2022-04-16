<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Entity Editor</title>
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
</head>
<body>
	<div class="modal fade" id="entity-editor" tabindex="-1" role="dialog" aria-labelledby="entityEditorModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-md">
            <div class="modal-content">
				<c:set var="view" scope="page" value="${param.view.toLowerCase()}"/>
				<c:set var="view" scope="page" value="${view.substring(0, 1).toUpperCase().concat(view.substring(1))}"/>
                <div class="modal-header">
                    <h4 class="modal-title" id="entityEditorModalLabel">Add new ${view.equals('Categories') ? 'Category' : view.substring(0, view.length() - 1)}</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
            	<form class="form-block" id="editorForm" action="add${view.equals('Categories') ? 'Category' : view.substring(0, view.length() - 1)}" method="post">
	                <div class="modal-body">
		            	<c:if test="${view.equals('Brands')}">
	               			<div class="row mx-2">
	               				<div class="md-6 mr-3">
									<label for="name" class="form-label">Brand Name</label>
								    <input type="text" class="form-control" id="name" name="name" placeholder="Brand Name"
										aria-label="Brand Name" required>
								</div>
								<div class="md-6">
									<label for="asset" class="form-label">Logo asset</label>
								    <input type="text" class="form-control" id="asset" name="asset" placeholder="Logo asset"
										aria-label="Logo asset">
								</div>
							</div>
						</c:if>
		            	<c:if test="${view.equals('Categories')}">
               				<div class="mb-3">
								<label for="name" class="form-label">Category Name</label>
							    <input type="text" class="form-control" id="name" name="name" placeholder="Category Name"
									aria-label="Category Name" required>
							</div>
						</c:if>
		            	<c:if test="${view.equals('Shoes')}">
							<jsp:useBean id="crud" class="jfsd.assessments.phase3.SportyShoes.util.CrudHelper"/>
							<c:set var="brands" scope="page" value="${crud.getBrands()}"/>
							<c:set var="categories" scope="page" value="${crud.getCategories()}"/>
	               			<div class="row mb-3">
	               				<div class="col-md-6">
									<label for="brandid" class="form-label">Brand</label>
									<select class="form-control custom-select" id="brandid" name="brandid" required>
									    <option selected></option>
									    <c:forEach var="brand" items="${brands}">
										    <option value="${brand.getId()}">${brand.getName()}</option>
									    </c:forEach>
								  	</select>
								</div>
	               				<div class="col-md-6">
									<label for="model" class="form-label">Model</label>
								    <input type="text" class="form-control" id="model" name="model"
										placeholder="Model" aria-label="Model" required>
								</div>
							</div>
	               			<div class="row mb-3">
								<div class="col-md-6">
									<label for="categoryId" class="form-label">Category</label>
									<select class="form-control custom-select" id="categoryId" name="categoryId" required>
									    <option selected>Choose...</option>
									    <c:forEach var="category" items="${categories}">
										    <option value="${category.getId()}">${category.getName()}</option>
									    </c:forEach>
								  	</select>
								</div>
								<div class="col-md-6">
									<label for="price" class="form-label">Price</label>
								    <input type="number" class="form-control sm-2 w-75" step="0.01" min="0"
								    	id="price" name="price" placeholder="Price in EUR" aria-label="Price" required>
								</div>
							</div>
						</c:if>
	                </div>
	                
	                <div class="modal-footer">
	                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
	                    <button type="submit" class="btn btn-primary btn-ok">Save</button>
	                </div>
				</form>
            </div>
        </div>
    </div>
</body>
</html>
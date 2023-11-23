<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
    }
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<title>Create a note</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
		<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css" />
		<style>
			.mainbox {
				padding: 12px;
				margin-top: 2rem;
			}
		</style>
	</head>
	<body class="container">
	<div style="float:right;">
			<a href="dashboard.jsp" type="button" class="btn btn-primary">Back to home</a>
			<a href="logout" type="button" class="btn btn-outline-primary">Log Out</a>
		</div>
		<div class="mainbox">
            <h1>Create a note</h1>
            <form action="create" method="POST">
                <div class="mb-3">
                    <label for="title" class="form-label">Title</label>
                    <input type="text" class="form-control" id="title" name="title" placeholder="Enter title" minlength="4" maxlength="64" required>
                </div>
                <div class="mb-3">
                    <label for="content" class="form-label">Content</label>
                    <textarea class="form-control" id="content" name="content" rows="3" placeholder="Enter content" minlength="24" maxlength="65555" required></textarea>
                </div>
                <div class="mb-3">
                    <select class="form-select" aria-label="Default select example" name="color">
                        <option value="BLUE">Blue</option>
                        <option value="GREY">Gray</option>
                        <option value="GREN">Green</option>
                        <option value="REDD">Red</option>
                        <option value="YLOW">Yellow</option>
                        <option value="LGHT">Light</option>
                        <option value="DARK">Dark</option>
                    </select>
                </div>
                <div class="mb-3">
                    <input type="checkbox" class="form-check-input" id="checkbox" name="pinned">
                    <label for="checkbox" class="form-label">Mark this note as important?</label>
                </div>
                <button type="submit" class="btn btn-primary" style="float: right;">Create note</button>
            </form>
		</div>
		<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
		<script>
			
		</script>
	</body>
</html>
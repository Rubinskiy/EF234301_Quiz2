<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    if (session.getAttribute("username") != null) {
        response.sendRedirect("dashboard.jsp");
    }
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<title>Register</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
		<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css" />
		<style>
			body {
	            height: 100vh;
	            display: flex;
	            align-items: center;
	            justify-content: center;
	            background-color: #f8f9fa;
	        }
	        .login-container {
	            max-width: 400px;
	            width: 100%;
	            padding: 15px;
	            background-color: #ffffff;
	            border: 1px solid #dee2e6;
	            border-radius: 5px;
	            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	        }
	        .login-container h2 {
	            margin-bottom: 20px;
	        }
		</style>
	</head>
	<body class="container">
		<div style="width: 400px;">
			<h1 class="mb-3">Create an account</h1>
			<form action="register" method="POST">
				<div class="mb-3">
	                <label for="username" class="form-label">Username</label>
	                <input class="form-control" type="text" name="username" placeholder="Username" minlength="4" maxlength="16" required />
	            </div>
	            <div>
	                <label for="password" class="form-label">Password</label>
	                <input type="password" class="form-control" name="password" placeholder="Password" minlength="3" maxlength="255" required /><br />
	            </div>
	            <button type="submit" class="btn btn-primary" style="width: 100%;">Create account</button>
	            <br /><br />
	            Or <a href="login.jsp">Sign in</a> to your account
			</form>
		</div>
		<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
	</body>
</html>
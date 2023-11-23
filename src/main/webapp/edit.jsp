<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.quiz2.Note" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="javax.servlet.RequestDispatcher" %>
<%@ page import="java.io.IOException" %>

<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
    }

    // Check for get parameter
    if (request.getParameter("id") == null) {
        response.sendRedirect("dashboard.jsp");
    }

    // Get the note id
    String id = request.getParameter("id");

    // Get the note
    Connection con = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz2", "root", "");
        PreparedStatement ps = con.prepareStatement("SELECT * FROM notes WHERE id = ?");
        ps.setString(1, id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            Note note = new Note();
            note.setId(rs.getString("id"));
            note.setTitle(rs.getString("title"));
            note.setContent(rs.getString("content"));
            note.setColor(rs.getString("color"));
            note.setPinned(rs.getBoolean("pinned"));
            request.setAttribute("note", note);
        } else {
            response.sendRedirect("dashboard.jsp");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<title>Edit a note</title>
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
            <h1>Edit a note</h1>
            <form action="edit?id=<%= id %>" method="POST">
                <input type="hidden" name="id" value="<%= id %>">
                <div class="mb-3">
                    <label for="title" class="form-label">Title</label>
                    <input type="text" name="title" class="form-control" id="title" value="<%= ((Note) request.getAttribute("note")).getTitle() %>">
                </div>
                <div class="mb-3">
                    <label for="content" class="form-label">Content</label>
                    <textarea class="form-control" name="content" id="content" rows="3"><%= ((Note) request.getAttribute("note")).getContent() %></textarea>
                </div>
                <div class="mb-3">
                    <label for="color" class="form-label">Color</label>
                    <select class="form-select" name="color" id="color">
                        <option value="BLUE" <%= ((Note) request.getAttribute("note")).getColor().equals("BLUE") ? "selected" : "" %>>Blue</option>
                        <option value="GREY" <%= ((Note) request.getAttribute("note")).getColor().equals("GREY") ? "selected" : "" %>>Gray</option>
                        <option value="GREN" <%= ((Note) request.getAttribute("note")).getColor().equals("GREN") ? "selected" : "" %>>Green</option>
                        <option value="REDD" <%= ((Note) request.getAttribute("note")).getColor().equals("REDD") ? "selected" : "" %>>Red</option>
                        <option value="YLOW" <%= ((Note) request.getAttribute("note")).getColor().equals("YLOW") ? "selected" : "" %>>Yellow</option>
                        <option value="LGHT" <%= ((Note) request.getAttribute("note")).getColor().equals("LGHT") ? "selected" : "" %>>Light</option>
                        <option value="DARK" <%= ((Note) request.getAttribute("note")).getColor().equals("DARK") ? "selected" : "" %>>Dark</option>
                    </select>
                </div>
                <div class="mb-3">
                    <input type="checkbox" class="form-check-input" name="pinned" id="pinned" <%= ((Note) request.getAttribute("note")).getPinned() ? "checked" : "" %>>
                    <label for="checkbox" class="form-label">Mark this note as important?</label>
                </div>
                <button type="submit" class="btn btn-primary" style="float: right;">Update note</button>
            </form>
		</div>
		<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
		<script>
			
		</script>
	</body>
</html>
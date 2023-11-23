<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
    }
%>
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
    // Get all notes from user from database
    String user_id = (String) request.getSession().getAttribute("id");
    RequestDispatcher dispatcher = null;
    Connection con = null;
    ArrayList<Note> notes = new ArrayList<Note>();
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz2", "root", "");
        PreparedStatement pst = con.prepareStatement("SELECT * FROM notes WHERE user_id=? ORDER BY created_at DESC LIMIT 10");
        pst.setString(1, user_id);
        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            Note note = new Note();
            note.setId(rs.getString("id"));
            note.setTitle(rs.getString("title"));
            note.setContent(rs.getString("content"));
            note.setColor(rs.getString("color"));
            note.setPinned(rs.getBoolean("pinned"));
            note.setCreatedAt(rs.getString("created_at"));
            note.setUpdatedAt(rs.getString("updated_at"));
            notes.add(note);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            con.close();
        } catch (SQLException e2) {
            e2.printStackTrace();
        }
    }

    // Check if delete parameter exists
    if (request.getParameter("delete") != null) {
        String note_id = request.getParameter("delete");
        Note note = null;
        for (Note n : notes) {
            if (n.getId().equals(note_id)) {
                note = n;
                break;
            }
        }
        
        // Check if note exists
        if (note != null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz2", "root", "");
                PreparedStatement pst = con.prepareStatement("DELETE FROM notes WHERE id=?");
                pst.setString(1, note_id);
                pst.executeUpdate();
                response.sendRedirect("dashboard.jsp");
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    con.close();
                } catch (SQLException e2) {
                    e2.printStackTrace();
                }
            }
        } else {
            response.sendRedirect("dashboard.jsp");
        }
    }
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Your Notes</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
		<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css" />
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
		<style>
			.mainbox {
				padding: 12px;
				margin-top: 2rem;
			}
		</style>
	</head>
	<body class="container">
		<div style="float:right;">
			<a href="create.jsp" type="button" class="btn btn-primary">Create Note</a>
			<a href="logout" type="button" class="btn btn-outline-primary">Log Out</a>
		</div>
		<div class="mainbox">
			<h1><%= session.getAttribute("username") %>'s notes</h1>
			<div style="padding-top: 25px;"></div>
			<div class="row row-cols-1 row-cols-md-2 g-4">
				<%
                    if (notes.size() != 0) {
				 	    for (Note note : notes) {
				 	    	String color = note.getColor();
				 	    	String linkColor = "fff";
				 	    	if (color.equals("BLUE")) {
				 	            color = "text-bg-primary";
				 	            linkColor = "fff";
				 	        } else if (color.equals("GREY")) {
				 	        	color = "text-bg-secondary";
				 	        	linkColor = "fff";
				 	        } else if (color.equals("GREN")) {
				 	        	color = "text-bg-success";
				 	        	linkColor = "fff";
				 	        } else if (color.equals("YLOW")) {
				 	        	color = "text-bg-warning";
				 	        	linkColor = "000";
				 	        } else if (color.equals("LGHT")) {
				 	        	color = "text-bg-light";
				 	        	linkColor = "000";
				 	        } else if (color.equals("DARK")) {
				 	        	color = "text-bg-dark";
				 	        	linkColor = "fff";
				 	       } else if (color.equals("REDD")) {
				 	        	color = "text-bg-danger";
				 	        	linkColor = "000";
				 	       } else {
				 	        	color = "text-bg-light";
				 	        	linkColor = "000";
				 	       }
				%>
                    <div class="col">
                        <div class="card <%= color %>">
                            <div class="card-body">
                                <h5 class="card-title">
                                	<%= note.getTitle() %>
                                	<%
                                		if (note.getPinned()) {
                                	%>
                                		<span style="float: right;">
	                                		<i class="bi bi-star-fill"></i>
	                                	</span>
                                	<%	
                                		}
                                	%>
                                </h5>
                                <p class="card-text"><%= note.getContent() %></p>
                                <a style="color:#<%= linkColor %>;" href="edit.jsp?id=<%= note.getId() %>">Edit</a>
                                <span style="color:#<%= linkColor %>;"> | </span>
                                <a style="color:#<%= linkColor %>;" href="javascript:deleteCard('<%= note.getId() %>');">Delete</a>
                            </div>
                        </div>
                    </div>
                <% 
                        } 
                    } else {
                %>
                	<h1 style="text-align:center;background-color:#e9e9e9;width:100%;padding:12px;color:#a7a7a7;">No notes found</h1>
                <% } %>
			</div>
			
			<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
			<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
			<script>
				function deleteCard(id) {
                    if (confirm("Are you sure you want to delete this note?")) {
                        window.location.href = "dashboard.jsp?delete=" + id;
                    }
                }
			</script>
		</div>
	</body>
</html>
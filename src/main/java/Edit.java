

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Edit
 */
@WebServlet("/edit")
public class Edit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Edit() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String color = request.getParameter("color");
        String pinned = request.getParameter("pinned");
        RequestDispatcher dispatcher = null;
        Connection con = null;
        
        // Check if title > 64 and = 0
        if (title.length() > 64 || title.length() == 0) {
        	request.setAttribute("status", "failed");
        	dispatcher = request.getRequestDispatcher("edit.jsp?id=" + id);
        	dispatcher.forward(request, response);
        	return;
        }
        
        // Check if content > 65555 and = 0
        if (content.length() > 65535 || content.length() == 0) {
        	request.setAttribute("status", "failed");
        	dispatcher = request.getRequestDispatcher("edit.jsp?id=" + id);
        	dispatcher.forward(request, response);
        	return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz2", "root", "");
            PreparedStatement ps = con.prepareStatement("UPDATE notes SET title=?, content=?, color=?, pinned=? WHERE id=?;");
            ps.setString(1, title);
            ps.setString(2, content);
            ps.setString(3, color);
            if (pinned != null) {
            	ps.setInt(4, 1);
            } else {
            	ps.setInt(4, 0);
            }
            ps.setString(5, id);
            
            int rowcount = ps.executeUpdate();
			if (rowcount > 0) {
				request.setAttribute("status", "success");
				dispatcher = request.getRequestDispatcher("dashboard.jsp");
			} else {
				System.out.println("Error: " + rowcount);
				request.setAttribute("status", "failed");
                dispatcher = request.getRequestDispatcher("edit.jsp?id=" + id);
			}
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                con.close();
            } catch (Exception e) {
                System.out.println(e);
            }
        }
	}

}
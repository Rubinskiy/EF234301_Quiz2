

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import com.quiz2.Note;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Dashboard
 */
@WebServlet("/dashboard")
public class Dashboard extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Dashboard() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Get all notes from user from database
        String user_id = (String) request.getSession().getAttribute("id");
        RequestDispatcher dispatcher = null;
        Connection con = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz2", "root", "");
            PreparedStatement pst = con.prepareStatement("SELECT * FROM notes WHERE user_id=? ORDER BY created_at DESC LIMIT 10");
            pst.setString(1, user_id);
            ResultSet rs = pst.executeQuery();

            ArrayList<Note> notes = new ArrayList<Note>();
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

            request.setAttribute("notes", notes);
            dispatcher = request.getRequestDispatcher("dashboard.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                con.close();
            } catch (SQLException e2) {
                e2.printStackTrace();
            }
        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

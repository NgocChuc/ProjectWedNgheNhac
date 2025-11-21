package Controller_Layer;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model_Layer.*;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
	protected void doGet(HttpServletRequest req, HttpServletResponse res)
		throws ServletException, IOException {
		SongDAO dao = new SongDAO();
		List<Song> list = dao.getAllSongs();
		req.setAttribute("song", list);
		req.getRequestDispatcher("admin.jsp").forward(req, res);
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse res)
		throws ServletException, IOException {
		String action = req.getParameter("action");
		SongDAO dao = new SongDAO();
		
		if ("delete".equals(action)) {
			int  id = Integer.parseInt(req.getParameter("id"));
			dao.deleteSong(id);
		}
		res.sendRedirect("admin");
	}

}

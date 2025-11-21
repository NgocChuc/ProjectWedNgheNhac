package Controller_Layer;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model_Layer.*;

@WebServlet("/songs")
public class SongServlet extends HttpServlet {
	protected void doGet(HttpServletRequest req, HttpServletResponse res)
		throws ServletException, IOException {
		SongDAO dao = new SongDAO();
		List<Song> list = dao.getAllSongs();
		req.setAttribute("songs", list);
		req.getRequestDispatcher("songs.jsp").forward(req, res);
	}
	
}

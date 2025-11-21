package Controller_Layer;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model_Layer.*;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {
	protected void doGet(HttpServletRequest req, HttpServletResponse res)
		throws ServletException, IOException {
		String keyword = req.getParameter("q");
		SongDAO dao = new SongDAO();
		List<Song> ressult = dao.searchSongs(keyword);
		req.setAttribute("songs", ressult);
		req.getRequestDispatcher("search.jsp").forward(req, res);
	}

}

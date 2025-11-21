package Controller_Layer;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model_Layer.*;

@WebServlet("/favorite")
public class FavoriteServlet extends HttpServlet{
	protected void doGet(HttpServletRequest req, HttpServletResponse res)
		throws ServletException, IOException {
		HttpSession session = req.getSession();
		User user = (User) session.getAttribute("user");
		if (user == null) {
			res.sendRedirect("login.jsp");
			return;
		}
		
		FavoriteDAO dao = new FavoriteDAO();
		List<Song> list = dao.getFavoritesByUser(user.getId());
		req.setAttribute("favorites", list);
		req.getRequestDispatcher("favorites.jsp").forward(req, res);
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse res)
		throws ServletException, IOException {
		int songId = Integer.parseInt(req.getParameter("songId"));
		HttpSession sesion = req.getSession();
		User user = (User) sesion.getAttribute("user");
		FavoriteDAO dao = new FavoriteDAO();
		dao.addFavorite(user.getId(), songId);
		res.sendRedirect("favorite");
	}

}

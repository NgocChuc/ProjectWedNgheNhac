package Controller_Layer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest; // Quan trọng
import javax.servlet.http.HttpServletResponse; // Quan trọng

import Model_Layer.Playlist;
import Model_Layer.Song;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import Dao.AlbumDAO;
import Dao.ArtistDAO;
import Dao.SongDAO;

@WebServlet(urlPatterns = { "/home", "/index" })
public class HomeServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
		SongDAO songDAO = new SongDAO();

	    // 1. Lấy dữ liệu
	    List<Song> randomList = songDAO.getRandomSongs(6);

	    // 2. GỬI DỮ LIỆU SANG JSP 
	    req.setAttribute("listRandom", randomList); 

	    req.getRequestDispatcher("/index.jsp").forward(req, resp);
	}
}

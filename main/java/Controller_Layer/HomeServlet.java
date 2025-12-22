package Controller_Layer;

import Model_Layer.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest; // Quan trọng
import javax.servlet.http.HttpServletResponse; // Quan trọng
import java.io.IOException;
import java.util.List;

import Dao.AlbumDAO;
import Dao.ArtistDAO;
import Dao.SongDAO;
import Model_Layer.Song;

@WebServlet({"/home", "/index"})
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        SongDAO dao = new SongDAO();
        List<Song> randomList = dao.getRandomSongs(6);
        req.setAttribute("listRandom", randomList);
        req.getRequestDispatcher("/index.jsp").forward(req, resp);
    }
}

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

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        System.out.println(">>> HomeServlet CALLED <<<");

        SongDAO dao = new SongDAO();
        List<Song> randomList = dao.getRandomSongs(6);

        System.out.println(">>> Random songs size = " + randomList.size());

        req.setAttribute("songs", randomList);

        req.getRequestDispatcher("/views/home.jsp").forward(req, resp);
    }
}


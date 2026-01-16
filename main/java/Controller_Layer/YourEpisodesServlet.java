package Controller_Layer;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model_Layer.Song;
import Model_Layer.User;
import Dao.SongDAO;

@WebServlet("/your_episodes")
public class YourEpisodesServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        SongDAO dao = new SongDAO();
        List<Song> savedEpisodes = dao.getSavedEpisodes(user.getId());

        request.setAttribute("episodes", savedEpisodes);
        request.setAttribute("episodeCount", savedEpisodes.size());
        
        // Chuyển hướng đến file JSP (nhớ dùng dấu gạch nối cho đồng bộ)
        request.getRequestDispatcher("/assets/views/user/your_episodes.jsp").forward(request, response);
    }
}
package Controller_Layer;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Dao.FavoriteDAO;
import Model_Layer.Song;
import Model_Layer.User;

@WebServlet("/liked_songs")
public class LikedSongsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Nếu chưa đăng nhập thì không cho xem danh sách này
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        FavoriteDAO dao = new FavoriteDAO();
        List<Song> likedSongs = dao.getLikedSongs(user.getId());

        // Gửi danh sách sang trang JSP
        request.setAttribute("likedSongs", likedSongs);
        
        // Chuyển hướng tới file JSP giao diện yêu thích
        request.getRequestDispatcher("/assets/views/user/liked_songs.jsp").forward(request, response);
    }
}
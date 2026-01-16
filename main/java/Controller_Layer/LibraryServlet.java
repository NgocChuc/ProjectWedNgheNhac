package Controller_Layer;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model_Layer.Playlist;
import Model_Layer.User;
// IMPORT DAO THẬT (Chú ý chữ hoa/thường cho khớp với file DAO của bạn)
import Dao.PlaylistDAO;

@WebServlet("/my-library")
public class LibraryServlet extends HttpServlet {

    // ĐÃ XÓA CLASS PlaylistDao GIẢ Ở ĐÂY

    protected void doGet(HttpServletRequest req, HttpServletResponse res) 
            throws ServletException, IOException {
        
    	res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
        res.setHeader("Pragma", "no-cache"); // HTTP 1.0
        res.setDateHeader("Expires", 0); // Proxies
        
        req.setCharacterEncoding("UTF-8");
        res.setCharacterEncoding("UTF-8");
        
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        
        // 1. Check đăng nhập
        if (user == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // 2. Gọi DAO thật để lấy dữ liệu từ Database
        PlaylistDAO playlistDao = new PlaylistDAO(); 
        List<Playlist> userPlaylists = playlistDao.getPlaylistsByUserId(user.getId());
        
        // 3. Gửi dữ liệu sang JSP
        req.setAttribute("myPlaylists", userPlaylists);
        
        req.getRequestDispatcher("/assets/views/main/library.jsp").forward(req, res);
    }
}
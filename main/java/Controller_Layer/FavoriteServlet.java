package Controller_Layer;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Dao.FavoriteDAO;
import Model_Layer.User;

@WebServlet("/api/favorite")
public class FavoriteServlet extends HttpServlet {

    // POST: Dùng để Toggle (Thêm/Xóa) yêu thích
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.getWriter().write("login_required");
            return;
        }

        int songId = Integer.parseInt(request.getParameter("songId"));
        FavoriteDAO dao = new FavoriteDAO();
        
        if (dao.isLiked(user.getId(), songId)) {
            dao.removeFavorite(user.getId(), songId);
            response.getWriter().write("removed");
        } else {
            dao.addFavorite(user.getId(), songId);
            response.getWriter().write("added");
        }
    }

    // GET: Dùng để kiểm tra trạng thái khi vừa load bài hát mới
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        String songIdRaw = request.getParameter("songId");

        if (user == null || songIdRaw == null) {
            response.getWriter().write("not_liked");
            return;
        }

        int songId = Integer.parseInt(songIdRaw);
        FavoriteDAO dao = new FavoriteDAO();
        
        if (dao.isLiked(user.getId(), songId)) {
            response.getWriter().write("liked");
        } else {
            response.getWriter().write("not_liked");
        }
    }
}
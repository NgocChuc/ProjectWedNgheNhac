package Controller_Layer;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Dao.PlaylistDAO;



@WebServlet("/add-to-playlist")
public class AddToPlaylistServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Lấy dữ liệu từ JSP gửi lên
        String sIdRaw = request.getParameter("songId");
        String pIdRaw = request.getParameter("playlistId");
        
        // Giả sử user đang đăng nhập và muốn thêm vào playlist "Yêu thích" của họ
        // Nếu chưa có hệ thống login phức tạp, ta tạm fix cứng playlistId = 1 để test
        if (pIdRaw == null) pIdRaw = "1"; 

        try {
            int songId = Integer.parseInt(sIdRaw);
            int playlistId = Integer.parseInt(pIdRaw);

            // 2. Gọi DAO
            PlaylistDAO dao = new PlaylistDAO();
            boolean success = dao.addSongToPlaylist(playlistId, songId);

            // 3. Trả về kết quả cho Javascript (AJAX)
            response.setContentType("text/plain");
            response.setCharacterEncoding("UTF-8");
            
            if (success) {
                response.getWriter().write("success");
            } else {
                response.getWriter().write("fail"); // Có thể do trùng bài hát
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("error");
        }
    }
}

package Controller_Layer;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model_Layer.Song;
import Dao.SongDAO;

@WebServlet("/genre")
public class GenreControlServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Lấy mã thể loại từ URL (V, K, hoặc U)
        String type = request.getParameter("type");
        if(type == null) type = "V"; // Mặc định là Vpop nếu null
        
        // 2. Xử lý tên hiển thị (Title) cho đẹp
        String displayTitle = "";
        switch (type) {
            case "V":
                displayTitle = "Top Hits V-Pop";
                break;
            case "K":
                displayTitle = "K-Pop Thịnh Hành";
                break;
            case "U":
                displayTitle = "US-UK";
                break;
            default:
                displayTitle = "Danh Sách Nhạc";
        }
        
        // 3. Gọi DAO lấy dữ liệu
        SongDAO dao = new SongDAO();
        List<Song> list = dao.getSongsByGenre(type);
        
        // 4. Đẩy dữ liệu ra JSP
        request.setAttribute("playlistName", displayTitle); 
        request.setAttribute("songList", list);           
        
        // 5. Chuyển sang trang chi tiết 
        request.getRequestDispatcher("/assets/views/main/genre_detail.jsp").forward(request, response);
    }
}
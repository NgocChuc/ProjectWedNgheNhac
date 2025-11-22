package controller;

import model.user.User;
import model.song.Song; // Import class Song mới tạo
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/home") 
public class HomeServlet extends HttpServlet {
    private static final String USER_SESSION_KEY = "loggedInUser";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // --- PHẦN 1: LOGIC USER (Giữ nguyên) ---
        HttpSession session = request.getSession(true); 
        User user = null;
        
        if (session.getAttribute(USER_SESSION_KEY) != null) {
            user = (User) session.getAttribute(USER_SESSION_KEY);
        } else {
            // Logic Bypass User Demo
            user = new User(999, "GiaoVienDemo", "user");
            String avatarUrl = request.getContextPath() + "/img/avatar_1.jpg";
            user.setAvatarUrl(avatarUrl); 
            session.setAttribute(USER_SESSION_KEY, user);
        }
        request.setAttribute("user", user); 

        // --- PHẦN 2: LOGIC SONG (MỚI THÊM) ---
        // Tạo một bài hát mẫu để hiển thị trên Player
        // Bạn có thể thay đổi thông tin này
        Song currentSong = new Song(
            1, 
            "Gnarly", 
            "KATSEYE", 
            "https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=200&h=200&fit=crop", 
            "3:45"
        );
        
        // Truyền bài hát vào Request Scope để music_player.jsp lấy được
        request.setAttribute("currentSong", currentSong);

        // --- PHẦN 3: CHUYỂN HƯỚNG ---
        request.getRequestDispatcher("/main.jsp").forward(request, response);
    }
}
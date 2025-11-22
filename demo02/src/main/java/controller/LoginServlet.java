package controller;

import java.io.IOException;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.dao.UserDao; // Lớp truy cập dữ liệu
import model.user.User; // Lớp Domain Model User 

@WebServlet("/login") 
public class LoginServlet extends HttpServlet {
    private static final String USER_SESSION_KEY = "loggedInUser";
    
    // Khai báo đường dẫn các ảnh avatar có sẵn
    // Yêu cầu: 3 file avatar_1.jpg, avatar_2.jpg, avatar_3.jpg phải có trong thư mục /img
    private static final String[] AVAILABLE_AVATARS = {
        "/img/avatar_1.jpg", "/img/avatar_2.jpg", "/img/avatar_3.jpg"
    };
    private UserDao userDao = new UserDao(); 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Lấy dữ liệu từ Form
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // 2. Gọi DAO để kiểm tra đăng nhập (Sử dụng Plaintext cho mục đích demo)
        User user = userDao.checkLogin(username, password);
        
        if (user != null) {
            // 3. Đăng nhập thành công: Gán Avatar ngẫu nhiên
            Random random = new Random();
            int randomIndex = random.nextInt(AVAILABLE_AVATARS.length);
            String randomAvatarPath = AVAILABLE_AVATARS[randomIndex];
            
            // Set Avatar URL đầy đủ (Context Path + đường dẫn ngẫu nhiên)
            user.setAvatarUrl(request.getContextPath() + randomAvatarPath);
            
            // 4. LƯU USER VÀO SESSION (Thiết lập trạng thái đăng nhập)
            HttpSession session = request.getSession();
            session.setAttribute(USER_SESSION_KEY, user);
            
            // 5. Chuyển hướng về trang chủ
            response.sendRedirect(request.getContextPath() + "/home");
            
        } else {
            // 6. Đăng nhập thất bại
            request.setAttribute("loginError", "Tên đăng nhập hoặc mật khẩu không đúng.");
            // Chuyển tiếp lại về trang login.jsp để hiển thị thông báo lỗi
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}
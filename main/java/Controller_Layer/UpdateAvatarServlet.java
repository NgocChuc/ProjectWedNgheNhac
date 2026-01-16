package Controller_Layer;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import Model_Layer.User;
import Dao.UserDao;


@WebServlet("/update-avatar")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class UpdateAvatarServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Kiểm tra đăng nhập
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        try {
            Part filePart = request.getPart("avatar");
            String fileName = "user_" + user.getId() + "_" + System.currentTimeMillis() + ".jpg";
            
            // Lưu vào thư mục assets/image của Server
            // Lưu ý: Đường dẫn này là đường dẫn ảo khi chạy trên Eclipse
            String uploadPath = getServletContext().getRealPath("") + File.separator + "assets" + File.separator + "image";
            
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();
            
            // Ghi file
            filePart.write(uploadPath + File.separator + fileName);
            
            // Cập nhật Database
            String dbPath = "assets/image/" + fileName; // Đường dẫn lưu trong DB
            UserDao dao = new UserDao();
            if(dao.updateAvatar(user.getId(), dbPath)) {
                // Cập nhật Session để hiển thị ngay lập tức
                user.setAvatarUrl(dbPath);
                session.setAttribute("user", user);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        // Quay lại trang profile
        response.sendRedirect("profile");
    }
}
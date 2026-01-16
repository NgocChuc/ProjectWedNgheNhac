package Controller_Layer;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model_Layer.User;
import Dao.UserDao;

@WebServlet("/adminUser")
public class AdminUserServlet extends HttpServlet {
    
    // Hiển thị danh sách người dùng
    protected void doGet(HttpServletRequest req, HttpServletResponse res) 
            throws ServletException, IOException {
        UserDao dao = new UserDao();
        List<User> list = dao.getAllUsers(); // Hàm này bạn đã thêm vào UserDao
        req.setAttribute("userList", list);
        req.getRequestDispatcher("/assets/views/admin/admin_user.jsp").forward(req, res);
    }
    
    // Xử lý xóa người dùng
    protected void doPost(HttpServletRequest req, HttpServletResponse res) 
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            UserDao dao = new UserDao();
            dao.deleteUser(id); // Hàm này bạn đã thêm vào UserDao
        }
        res.sendRedirect("adminUser");
    }
}
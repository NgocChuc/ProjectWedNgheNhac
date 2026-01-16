package Controller_Layer;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model_Layer.*;
import Dao.UserDao;
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	protected void doPost(HttpServletRequest req, HttpServletResponse res)
		throws ServletException, IOException {
		
		// hỗ trợ tiếng Việt
        req.setCharacterEncoding("UTF-8");
        res.setCharacterEncoding("UTF-8");
        String loginKey = req.getParameter("email"); 
        String password = req.getParameter("password");
		
		UserDao dao = new UserDao();
		User user = dao.checkLogin(loginKey, password);
		
		String contextPath = req.getContextPath();
		
		if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            
            // SỬA LỖI: Thêm contextPath để redirect đúng trang
            if ("admin".equals(user.getRole())) {
                res.sendRedirect(contextPath + "/admin/dashboard-data");
            } else {
                res.sendRedirect(contextPath + "/home");
            }
        } else {
            req.setAttribute("error", "Sai tài khoản hoặc mật khẩu!");
            // Giữ lại email người dùng đã nhập để họ không phải gõ lại
            req.setAttribute("enteredAccount", loginKey); 
            req.getRequestDispatcher("/assets/views/auth/login.jsp").forward(req, res);
        }
    }
	// Khi người dùng truy cập link /login trực tiếp -> Hiện trang login.jsp
    protected void doGet(HttpServletRequest req, HttpServletResponse res) 
            throws ServletException, IOException {
        req.getRequestDispatcher("/assets/views/auth/login.jsp").forward(req, res);
    }
}

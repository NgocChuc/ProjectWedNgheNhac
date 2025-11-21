package Controller_Layer;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model_Layer.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	protected void doPost(HttpServletRequest req, HttpServletResponse res)
		throws ServletException, IOException {
		String username = req.getParameter("username");
		String password = req.getParameter("password");
		
		UserDao dao = new UserDao();
		User user = dao.checkLogin(username, password);
		
		if (user != null) {
			HttpSession session = req.getSession();
			session.setAttribute("user", user);
			if ("admin".equals(user.getRole())) res.sendRedirect("admin.jsp");
			else
				res.sendRedirect("index.jsp");
		} else {
			req.setAttribute("error", "Sai tài khoản hoặc mật khẩu!");
			req.getRequestDispatcher("login.jsp").forward(req, res);
		}
	}
	
}

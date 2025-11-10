package Controller_Layer;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model_Layer.*;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
	protected void doPost(HttpServletRequest req, HttpServletResponse res)
		throws ServletException, IOException {
		String username = req.getParameter("username");
		String password = req.getParameter("password");
		
		UserDao dao  = new UserDao();
		User user = new User();
		user.setUserName(username);
		user.setPassword(password);;
		
		if (dao.insertUser(user)) {
			res.sendRedirect("login.jsp");
		} else {
			req.setAttribute("error", "Đăng ký thất bại!");
			req.getRequestDispatcher("register.jsp").forward(req, res);
		}
	}
}

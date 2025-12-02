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
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirm");

        boolean hasError = false;

        // giữ giá trị input để floating label vẫn hoạt động
        request.setAttribute("username", username);
        request.setAttribute("email", email);

        if (username == null || username.trim().isEmpty()) {
            request.setAttribute("usernameError", "Username cannot be empty");
            hasError = true;
        }
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("emailError", "Email cannot be empty");
            hasError = true;
        }
        if (password == null || password.trim().isEmpty()) {
            request.setAttribute("passwordError", "Password cannot be empty");
            hasError = true;
            
        } else if (!password.equals(confirm)) {
            request.setAttribute("confirmError", "Passwords do not match");
            hasError = true;
        }

        UserDao dao = new UserDao();
        if (dao.checkEmailExists(email)) {
            request.setAttribute("emailError", "Email already exists");
            hasError = true;
        }

        if (hasError) {
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // lưu user mới
        dao.registerUser(new User(username, email, password));

        request.setAttribute("success", "Register successful! You can login now.");
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

  
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }
}

package Controller_Layer;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model_Layer.*;
import Dao.UserDao;
@WebServlet("/forgot")
public class ForgotPasswordServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        request.setAttribute("email", email);

        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Email cannot be empty");
            request.getRequestDispatcher("/forgot.jsp").forward(request, response);
            return;
        }

        UserDao dao = new UserDao();
        User user = dao.getUserByEmail(email);

        if (user == null) {
            request.setAttribute("error", "Email not found");
            request.getRequestDispatcher("/forgot.jsp").forward(request, response);
            return;
        }

        // Demo: chưa gửi mail thật, chỉ show thông báo
        request.setAttribute("success", "Password reset link sent to your email (demo)");
        request.getRequestDispatcher("/assets/views/auth/forgot.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/assets/views/auth/forgot.jsp").forward(request, response);
    }

}

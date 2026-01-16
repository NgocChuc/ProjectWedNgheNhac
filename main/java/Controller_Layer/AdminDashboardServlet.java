package Controller_Layer;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Dao.SongDAO;
import Dao.UserDao;

@WebServlet("/admin/dashboard-data")
public class AdminDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) 
            throws ServletException, IOException {
        SongDAO songDao = new SongDAO();
        UserDao userDao = new UserDao();

        int songs = songDao.getTotalSongs();
        int users = userDao.getTotalUsers();

        // Thêm 2 dòng này để kiểm tra trong cửa sổ Console của Eclipse/IntelliJ
        System.out.println("DEBUG: Total Songs = " + songs);
        System.out.println("DEBUG: Total Users = " + users);

        req.setAttribute("totalSongs", songs);
        req.setAttribute("totalUsers", users);

        req.getRequestDispatcher("/admin.jsp").forward(req, res);
    }
}

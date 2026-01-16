package Controller_Layer;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model_Layer.User;
import Dao.SongDAO;

@WebServlet("/record-history")
public class RecordHistoryServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        String songIdRaw = request.getParameter("songId");

        if (user != null && songIdRaw != null) {
            try {
                int songId = Integer.parseInt(songIdRaw);
                SongDAO dao = new SongDAO();
                // Gọi hàm insert vào bảng UserMusicHistory
                dao.recordListenHistory(user.getId(), songId); 
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}

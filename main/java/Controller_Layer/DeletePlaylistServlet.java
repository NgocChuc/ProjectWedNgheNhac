package Controller_Layer;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import Model_Layer.User; 
import Dao.PlaylistDAO;

@WebServlet("/delete-playlist")
public class DeletePlaylistServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("--- Bat dau xu ly xoa playlist ---");
        
        HttpSession session = request.getSession();
      
        Object userObj = session.getAttribute("user");
        if (userObj == null || !(userObj instanceof Model_Layer.User)) {
            System.out.println("Loi: Khong tim thay User trong session hoac sai kieu class.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        Model_Layer.User user = (Model_Layer.User) userObj;
        String idRaw = request.getParameter("id");
        System.out.println("ID playlist nhan duoc tu request: " + idRaw);

        if (idRaw != null && !idRaw.isEmpty()) {
            try {
                int playlistId = Integer.parseInt(idRaw);
                PlaylistDAO dao = new PlaylistDAO();

                boolean success = dao.deletePlaylist(playlistId);

                if (success) {
                    System.out.println("Xoa thanh cong! Dang chuyen huong ve Servlet...");
                   
                    response.sendRedirect(request.getContextPath() + "/my-library");
                
                } else {
                    System.out.println("DAO bao loi: Khong xoa duoc trong database.");
                    response.sendRedirect(request.getContextPath() + "/my-library?error=db");
                }
            } catch (Exception e) {
                System.out.println("Loi Exception: " + e.getMessage());
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/my-library");
            }
        } else {
            System.out.println("Loi: Tham so ID bi null.");
            response.sendRedirect(request.getContextPath() + "/my-library");
        }
    }
}
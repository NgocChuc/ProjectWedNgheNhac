package Controller_Layer;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

// CHÚ Ý: Import đúng class User của bạn
import Model_Layer.User; 
import Dao.PlaylistDAO;

@WebServlet("/rename-playlist")
public class RenamePlaylistServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
   
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String idRaw = request.getParameter("id");
        String newName = request.getParameter("name");

        if (idRaw != null && newName != null && !newName.trim().isEmpty()) {
            try {
                int playlistId = Integer.parseInt(idRaw);
                PlaylistDAO dao = new PlaylistDAO();

                boolean success = dao.renamePlaylist(playlistId, newName.trim());

                if (success) {
                    
                    response.sendRedirect(request.getContextPath() + "/my-library");
                } else {
                    response.sendRedirect(request.getContextPath() + "/my-library?error=db");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/my-library");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/my-library");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
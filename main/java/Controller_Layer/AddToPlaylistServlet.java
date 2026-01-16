package Controller_Layer;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Dao.PlaylistDAO;

@WebServlet("/api/add-to-playlist")
public class AddToPlaylistServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int songId = Integer.parseInt(request.getParameter("songId"));
        int playlistId = Integer.parseInt(request.getParameter("playlistId"));
        
        PlaylistDAO dao = new PlaylistDAO();
        
        // 1. Kiểm tra xem bài hát đã có trong playlist chưa
        if (dao.isSongInPlaylist(playlistId, songId)) {
            response.getWriter().write("exists");
        } else {
            // 2. Thêm vào database
            boolean success = dao.addSongToPlaylist(playlistId, songId);
            if (success) {
                response.getWriter().write("success");
            } else {
                response.getWriter().write("error");
            }
        }
    }
}

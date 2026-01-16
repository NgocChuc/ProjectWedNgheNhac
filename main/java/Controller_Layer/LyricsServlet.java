package Controller_Layer;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model_Layer.Song;
import Dao.SongDAO;

@WebServlet("/song-detail") // Lưu ý: URL này dùng để gọi servlet
public class LyricsServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String idStr = request.getParameter("id");
        
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                
                SongDAO dao = new SongDAO();
                Song song = dao.getSongById(id);
                
                if (song != null) {
                    // Tách lời bài hát để hiển thị từng dòng
                    String rawLyrics = song.getLyrics();
                    if (rawLyrics != null && !rawLyrics.isEmpty()) {
                        String[] lines = rawLyrics.split("\\r?\\n");
                        request.setAttribute("lyricLines", lines);
                    }
                    
                    request.setAttribute("song", song); 
                  
                }
            } catch (NumberFormatException e) {
                System.out.println("ID lỗi format: " + idStr);
            }
        }
        
        request.getRequestDispatcher("/assets/view/lyrics.jsp").forward(request, response);
    }
}
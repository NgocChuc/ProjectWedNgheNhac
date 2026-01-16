package Controller_Layer;

import Dao.SongDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model_Layer.Song;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/api/search")
public class AjaxSearchServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest req, HttpServletResponse res) 
            throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8");
        res.setCharacterEncoding("UTF-8");
        res.setContentType("application/json"); 

        String keyword = req.getParameter("term");
        PrintWriter out = res.getWriter();

        if (keyword == null || keyword.trim().isEmpty()) {
            out.print("[]");
            return;
        }

        SongDAO dao = new SongDAO();
        List<Song> songs = dao.searchSongs(keyword.trim());
        
        StringBuilder json = new StringBuilder();
        json.append("[");
        
        for (int i = 0; i < songs.size(); i++) {
            Song s = songs.get(i);
            json.append("{");
            json.append("\"id\":").append(s.getId()).append(",");
            
            // Xử lý ký tự đặc biệt để tránh lỗi JSON
            String safeTitle = (s.getTitle() != null) ? s.getTitle().replace("\"", "\\\"") : "";
            String safeArtist = (s.getArtist() != null) ? s.getArtist().replace("\"", "\\\"") : "";
            String safeCover = (s.getCoverImage() != null) ? s.getCoverImage() : "";
            String safeFile = (s.getFilename() != null) ? s.getFilename() : "";

            json.append("\"title\":\"").append(safeTitle).append("\",");
            json.append("\"artist\":\"").append(safeArtist).append("\",");
            json.append("\"coverImage\":\"").append(safeCover).append("\",");
            
           
            json.append("\"filename\":\"").append(safeFile).append("\"");
            
            json.append("}");
            
            if (i < songs.size() - 1) {
                json.append(",");
            }
        }
        json.append("]");

        out.print(json.toString());
        out.flush();
    }
}
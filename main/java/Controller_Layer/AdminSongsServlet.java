package Controller_Layer;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Dao.SongDAO;

@WebServlet("/adminSongs") // Đổi link thành /adminSongs
public class AdminSongsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) 
            throws ServletException, IOException {
        SongDAO dao = new SongDAO();
        req.setAttribute("song", dao.getAllSongs());
        req.getRequestDispatcher("/assets/views/admin/admin_songs.jsp").forward(req, res);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) 
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        SongDAO dao = new SongDAO();

        if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            dao.deleteSong(id);
        } 
     // Trong phương thức doPost, phần else if ("add".equals(action))
        else if ("add".equals(action)) {
            String title = req.getParameter("title");
            String artist = req.getParameter("artist");
            String genre = req.getParameter("genre");
            String coverImage = req.getParameter("coverImage");
            String songUrl = req.getParameter("songUrl"); // Đường dẫn file nhạc
            String lyrics = req.getParameter("lyrics");   // Lời bài hát

            dao.addSong(title, artist, genre, coverImage, songUrl, lyrics);
        }

        // Sau khi xử lý xong, quay về trang danh sách
        res.sendRedirect("adminSongs");
    }
}

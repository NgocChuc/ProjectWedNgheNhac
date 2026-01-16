package Controller_Layer;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model_Layer.Song;
import Dao.SongDAO;

// Sevlet Test chức năng phát nhạc, xem lời, hiển thị toàn bộ bài hát 
@WebServlet("/list-songs")
public class SongListServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        SongDAO dao = new SongDAO();
        List<Song> list = dao.getAllSongs();
        
        request.setAttribute("danhSachBaiHat", list);
        request.getRequestDispatcher("/assets/test/SongList.jsp").forward(request, response);
    }
}
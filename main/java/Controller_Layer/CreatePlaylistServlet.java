package Controller_Layer;

import Dao.PlaylistDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import Model_Layer.Playlist;
import Model_Layer.User;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

@WebServlet("/create-playlist")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, 
    maxFileSize = 1024 * 1024 * 10,      
    maxRequestSize = 1024 * 1024 * 50    
)
public class CreatePlaylistServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "assets/ima";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("views/auth/login.jsp");
            return;
        }

        try {
            String playlistName = request.getParameter("playlistName");
           
            String filename = null; 
            Part filePart = request.getPart("coverImage");

            if (filePart != null && filePart.getSize() > 0) {
                String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                filename = System.currentTimeMillis() + "_" + originalFileName;

                String applicationPath = request.getServletContext().getRealPath("");
                String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;

                File uploadDir = new File(uploadFilePath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                filePart.write(uploadFilePath + File.separator + filename);
            }

            // 5. Lưu vào Database
            PlaylistDAO dao = new PlaylistDAO();
            dao.insertPlaylist(playlistName, filename, user.getId());

            //CẬP NHẬT SESSION
            List<Playlist> updatedList = dao.getPlaylistsByUserId(user.getId()); 
            session.setAttribute("userPlaylists", updatedList);

            // chuyển hướng sang trang Thư viện
            // gọi Servlet my-library để nó load lại danh sách mới nhất
            response.sendRedirect(request.getContextPath() + "/my-library");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi tạo Playlist");
        }
    }
}
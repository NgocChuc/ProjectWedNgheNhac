package controller.music;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.song.Song;

/**
 * Xử lý các yêu cầu điều khiển trình phát: play, pause, next, prev, loop, shuffle.
 */
@WebServlet("/player")
public class PlayerController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // Giả lập trạng thái trình phát hiện tại (thường lưu trong Session hoặc Application Scope)
    private static PlayerStateModel currentState = new PlayerStateModel(false, false, false, "0:00", 0);
    

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");

        if (action != null) {
            switch (action) {
                case "play":
                    currentState.setPlaying(true);
                    System.out.println("ACTION: Phát nhạc.");
                    break;
                case "pause":
                    currentState.setPlaying(false);
                    System.out.println("ACTION: Tạm dừng.");
                    break;
                case "next":
                    // Logic chuyển bài (gọi SongService để lấy SongModel mới)
                    System.out.println("ACTION: Bài hát tiếp theo.");
                    break;
                case "prev":
                    // Logic chuyển bài lùi
                    System.out.println("ACTION: Bài hát trước.");
                    break;
                case "loop":
                    currentState.setLooping(!currentState.isLooping());
                    System.out.println("ACTION: Chế độ lặp lại: " + currentState.isLooping());
                    break;
                case "shuffle":
                    currentState.setShuffling(!currentState.isShuffling());
                    System.out.println("ACTION: Chế độ trộn bài: " + currentState.isShuffling());
                    break;
                default:
                    // Bỏ qua
            }
        }
        
        // Cập nhật lại thời gian/tiến trình giả lập
        // (Trong thực tế, điều này do JS client xử lý, nhưng Server cần trạng thái logic)
        currentState.setCurrentTime("0:45");
        currentState.setProgressPercent(30);

        // Chuẩn bị dữ liệu Model và chuyển hướng đến trang chính
       
        request.setAttribute("playerState", currentState);
        
        // Chuyển hướng đến trang chính (ví dụ: home.jsp) để làm mới giao diện
        // Lưu ý: Trong ứng dụng thực tế, các yêu cầu này thường là AJAX để chỉ cập nhật Player Bar.
        request.getRequestDispatcher("/home.jsp").forward(request, response);
    }
}
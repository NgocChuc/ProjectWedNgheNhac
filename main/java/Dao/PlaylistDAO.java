package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import Model_Layer.*;

public class PlaylistDAO {
	public boolean addSongToPlaylist(int playlistId, int songId) {
	    String sql = "INSERT INTO playlist_songs (playlist_id, song_id) VALUES (?, ?)";
	    
	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	         
	        ps.setInt(1, playlistId);
	        ps.setInt(2, songId);
	        
	        int rows = ps.executeUpdate();
	        return rows > 0; // Trả về true nếu thêm thành công
	        
	    } catch (Exception e) {
	        // Nếu lỗi (ví dụ bài hát đã tồn tại trong playlist), in ra log
	        e.printStackTrace();
	    }
	    return false;
	}
}

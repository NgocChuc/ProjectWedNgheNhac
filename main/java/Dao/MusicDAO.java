package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import Model_Layer.DBUtil;
import Model_Layer.Song; 
public class MusicDAO {
	//1, 2, 3 được sử dụng cho profile hiển thị lịch sử bài hát và nghệ sĩ nghe nhiều nhất
    // 1. Lấy Top 5 bài hát mà User này nghe nhiều nhất
    public List<Song> getPersonalTopSongs(int userId) {
        List<Song> list = new ArrayList<>();
        String sql = "SELECT TOP 5 s.*, COUNT(h.song_id) as play_count " +
                     "FROM Songs s " +
                     "JOIN UserMusicHistory h ON s.id = h.song_id " +
                     "WHERE h.user_id = ? " +
                     "GROUP BY s.id, s.title, s.artist, s.genre, s.filename, s.lyrics, s.cover_image, s.views " +
                     "ORDER BY play_count DESC";
        
        try (Connection conn = DBUtil.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Song s = new Song();
                s.setId(rs.getInt("id"));
                s.setTitle(rs.getString("title"));
                s.setArtist(rs.getString("artist"));
                s.setCoverImage(rs.getString("cover_image"));
                // Bạn có thể thêm trường play_count vào Model Song nếu muốn hiển thị con số
                list.add(s);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // 2. Lấy danh sách nghệ sĩ mà User thường xuyên nghe
    public List<String> getFavoriteArtists(int userId) {
        List<String> artists = new ArrayList<>();
        String sql = "SELECT DISTINCT TOP 5 s.artist " +
                     "FROM Songs s " +
                     "JOIN UserMusicHistory h ON s.id = h.song_id " +
                     "WHERE h.user_id = ? " +
                     "GROUP BY s.artist " +
                     "ORDER BY COUNT(h.id) DESC";
        
        try (Connection conn = DBUtil.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                artists.add(rs.getString("artist"));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return artists;
    }

    // 3. Hàm ghi lại lịch sử khi User nhấn nghe nhạc
    public void recordListenHistory(int userId, int songId) {
        String sql = "INSERT INTO UserMusicHistory (user_id, song_id) VALUES (?, ?)";
        try (Connection conn = DBUtil.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, songId);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }
    
    
    // Được sử dụng trong danh sach bài hát yêu thích LikedSongsServlet.java	
    //Danh sách bài hát yêu thích
    public List<Song> getLikedSongs(int userId) {
        List<Song> list = new ArrayList<>();
        // Câu lệnh JOIN giữa bảng Songs và Favorites
        String sql = "SELECT s.* FROM Songs s " +
                     "JOIN Favorites f ON s.id = f.song_id " +
                     "WHERE f.user_id = ? ORDER BY f.id DESC"; // Mới like hiện lên đầu
        
        try (Connection conn = DBUtil.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Song s = new Song();
                s.setId(rs.getInt("id"));
                s.setTitle(rs.getString("title"));
                s.setArtist(rs.getString("artist"));
                s.setCoverImage(rs.getString("cover_image"));
                s.setFilename(rs.getString("filename"));
                // s.setDuration(rs.getString("duration")); // Nếu có cột duration
                list.add(s);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
    

    //Được sử dụng trong tập bài hát YourEpisodesServlet.java
    public List<Song> getSavedEpisodes(int userId) {
        List<Song> list = new ArrayList<>();
        // Truy vấn các bài hát/tập podcast mà user đã "bookmark" (lưu)
        String sql = "SELECT s.* FROM Songs s " +
                     "JOIN SavedEpisodes e ON s.id = e.song_id " +
                     "WHERE e.user_id = ? ORDER BY e.id DESC";
        
        try (Connection conn = DBUtil.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Song s = new Song();
                s.setId(rs.getInt("id"));
                s.setTitle(rs.getString("title"));
                s.setArtist(rs.getString("artist"));
                s.setCoverImage(rs.getString("cover_image"));
                s.setFilename(rs.getString("filename"));
                list.add(s);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
}
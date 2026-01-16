package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import Model_Layer.DBUtil;
import Model_Layer.Song;

public class FavoriteDAO {

    // 1. Kiểm tra xem bài hát đã được like chưa
    public boolean isLiked(int userId, int songId) {
        String query = "SELECT COUNT(*) FROM Favorites WHERE user_id = ? AND song_id = ?";
        try (Connection conn = new DBUtil().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            ps.setInt(2, songId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 2. Thêm vào yêu thích
    public void addFavorite(int userId, int songId) {
        String query = "INSERT INTO Favorites (user_id, song_id) VALUES (?, ?)";
        try (Connection conn = new DBUtil().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            ps.setInt(2, songId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 3. Xóa khỏi yêu thích
    public void removeFavorite(int userId, int songId) {
        String query = "DELETE FROM Favorites WHERE user_id = ? AND song_id = ?";
        try (Connection conn = new DBUtil().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            ps.setInt(2, songId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
 // 4. Lấy danh sách tất cả bài hát mà user đã thích (Dùng cho trang liked_songs.jsp)
    public List<Song> getLikedSongs(int userId) {
        List<Song> list = new ArrayList<>();
        // Thực hiện JOIN để lấy thông tin chi tiết bài hát
        String sql = "SELECT s.* FROM Songs s " +
                     "JOIN Favorites f ON s.id = f.song_id " +
                     "WHERE f.user_id = ? ORDER BY f.id DESC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Song s = new Song();
                s.setId(rs.getInt("id"));
                s.setTitle(rs.getString("title"));
                s.setArtist(rs.getString("artist"));
                s.setGenre(rs.getString("genre"));
                s.setCoverImage(rs.getString("cover_image"));
                s.setFilename(rs.getString("filename"));
                s.setLyrics(rs.getString("lyrics"));
                list.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Model_Layer.DBUtil;
import Model_Layer.Playlist;
import Model_Layer.Song;

public class PlaylistDAO {

	// 1. Hàm thêm Playlist mới vào Database
	public void insertPlaylist(String name, String coverImage, int userId) {
		// Câu lệnh SQL (Cột description cho phép NULL nên mình chưa cần insert ở đây)
		String query = "INSERT INTO Playlists (name, description, cover_image, user_id) VALUES (?, ?, ?, ?)";

		// Sử dụng try-with-resources để tự động đóng kết nối
		try (Connection conn = new DBUtil().getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {

			// 1. Tên Playlist
			ps.setString(1, name);

			// 2. Mô tả (Mặc định để NULL hoặc chuỗi rỗng)
			ps.setNull(2, java.sql.Types.NVARCHAR);

			// 3. Ảnh bìa (Xử lý nếu không có ảnh thì lưu NULL)
			if (coverImage == null || coverImage.trim().isEmpty()) {
				ps.setNull(3, java.sql.Types.NVARCHAR);
			} else {
				ps.setString(3, coverImage);
			}

			// 4. ID người tạo
			ps.setInt(4, userId);

			// Thực thi lệnh
			ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 2. Hàm lấy danh sách Playlist của 1 User
	public List<Playlist> getPlaylistsByUserId(int userId) {
		List<Playlist> list = new ArrayList<>();
		// Sắp xếp giảm dần (DESC) để playlist mới tạo hiện lên đầu
		String query = "SELECT * FROM Playlists WHERE user_id = ? ORDER BY id DESC";

		try (Connection conn = new DBUtil().getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {

			ps.setInt(1, userId);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				Playlist p = new Playlist();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescription(rs.getString("description"));
				p.setCoverImage(rs.getString("cover_image"));

				p.setUserId(rs.getInt("user_id"));

				list.add(p);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// Hàm thêm bài hát vào playlist
	public boolean addSongToPlaylist(int playlistId, int songId) {
		String sql = "INSERT INTO Playlist_Songs (playlist_id, song_id) VALUES (?, ?)";
		try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, playlistId);
			ps.setInt(2, songId);
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// Lấy danh sách bài hát CỦA một Playlist (để hiện ở trang playlist_detail.jsp)
	public List<Song> getSongsByPlaylistId(int playlistId) {
		List<Song> list = new ArrayList<>();
		// JOIN giữa bảng bài hát và bảng trung gian
		String sql = "SELECT s.* FROM Songs s " + "JOIN Playlist_Songs ps ON s.id = ps.song_id "
				+ "WHERE ps.playlist_id = ?";
		try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, playlistId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Song s = new Song();
				s.setId(rs.getInt("id"));
				s.setTitle(rs.getString("title"));
				s.setArtist(rs.getString("artist"));
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

	public boolean isSongInPlaylist(int playlistId, int songId) {
		String sql = "SELECT COUNT(*) FROM Playlist_Songs WHERE playlist_id = ? AND song_id = ?";

		try (Connection conn = DBUtil.getConnection(); // Sử dụng lớp kết nối DB của bạn
				PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, playlistId);
			ps.setInt(2, songId);

			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					// Nếu count > 0 nghĩa là đã tồn tại
					return rs.getInt(1) > 0;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean deletePlaylist(int playlistId) {
	    String sqlDeleteSongs = "DELETE FROM Playlist_Songs WHERE playlist_id = ?";
	    String sqlDeletePlaylist = "DELETE FROM Playlists WHERE id = ?";
	    
	    try (Connection conn = new Model_Layer.DBUtil().getConnection()) { // Đảm bảo khởi tạo đúng
	        conn.setAutoCommit(false);
	        try (PreparedStatement ps1 = conn.prepareStatement(sqlDeleteSongs);
	             PreparedStatement ps2 = conn.prepareStatement(sqlDeletePlaylist)) {
	            
	            ps1.setInt(1, playlistId);
	            ps1.executeUpdate();
	            
	            ps2.setInt(1, playlistId);
	            int rows = ps2.executeUpdate();
	            
	            conn.commit();
	            return rows > 0;
	        } catch (Exception e) {
	            conn.rollback();
	            e.printStackTrace();
	            return false;
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}
	public boolean renamePlaylist(int playlistId, String newName) {
		String sql = "UPDATE Playlists SET name = ? WHERE id = ?";

		// Sử dụng try-with-resources để tự động đóng connection
		try (Connection conn = new DBUtil().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setString(1, newName);
			ps.setInt(2, playlistId);

			int rows = ps.executeUpdate();
			return rows > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}
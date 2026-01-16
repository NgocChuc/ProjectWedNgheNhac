package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import Model_Layer.DBUtil;
import Model_Layer.Song;

// Import class DBUtil của bạn (hoặc DBContext tùy tên bạn đặt)
// import context.DBUtil; 

public class SongDAO {

	public List<Song> getPersonalTopSongs(int userId) {
		List<Song> list = new ArrayList<>();
		String sql = "SELECT TOP 5 s.*, COUNT(h.song_id) as play_count " + "FROM Songs s "
				+ "JOIN UserMusicHistory h ON s.id = h.song_id " + "WHERE h.user_id = ? "
				+ "GROUP BY s.id, s.title, s.artist, s.genre, s.filename, s.lyrics, s.cover_image, s.views "
				+ "ORDER BY play_count DESC";

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
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// 2. Lấy danh sách nghệ sĩ mà User thường xuyên nghe
	public List<String> getFavoriteArtists(int userId) {
		List<String> artists = new ArrayList<>();
		String sql = "SELECT DISTINCT TOP 5 s.artist " + "FROM Songs s "
				+ "JOIN UserMusicHistory h ON s.id = h.song_id " + "WHERE h.user_id = ? " + "GROUP BY s.artist "
				+ "ORDER BY COUNT(h.id) DESC";

		try (Connection conn = DBUtil.getConnection()) {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, userId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				artists.add(rs.getString("artist"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
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
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// Được sử dụng trong danh sach bài hát yêu thích LikedSongsServlet.java
	// Danh sách bài hát yêu thích
	public List<Song> getLikedSongs(int userId) {
		List<Song> list = new ArrayList<>();
		// Câu lệnh JOIN giữa bảng Songs và Favorites
		String sql = "SELECT s.* FROM Songs s " + "JOIN Favorites f ON s.id = f.song_id "
				+ "WHERE f.user_id = ? ORDER BY f.id DESC"; // Mới like hiện lên đầu

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
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// Được sử dụng trong tập bài hát YourEpisodesServlet.java
	public List<Song> getSavedEpisodes(int userId) {
		List<Song> list = new ArrayList<>();
		// Truy vấn các bài hát/tập podcast mà user đã "bookmark" (lưu)
		String sql = "SELECT s.* FROM Songs s " + "JOIN SavedEpisodes e ON s.id = e.song_id "
				+ "WHERE e.user_id = ? ORDER BY e.id DESC";

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
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// 1. Lấy tất cả bài hát
	public List<Song> getAllSongs() {
		List<Song> list = new ArrayList<>();
		// Đảm bảo tên bảng là Songs (check kỹ chữ hoa thường trong SQL của bạn)
		String sql = "SELECT * FROM Songs";

		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				Song s = new Song();
				s.setId(rs.getInt("id"));
				s.setTitle(rs.getString("title"));
				s.setArtist(rs.getString("artist"));
				s.setGenre(rs.getString("genre"));
				s.setViews(rs.getInt("views"));
				s.setLyrics(rs.getString("lyrics"));
				s.setFilename(rs.getString("filename"));

				// 2. Cột cover_image (Database có dấu gạch dưới _)
				// Phải gõ đúng tên cột trong SQL vào đây
				s.setCoverImage(rs.getString("cover_image"));

				list.add(s);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// 2. Lấy bài hát theo ID
	public Song getSongById(int id) {
		Song s = null;
		String sql = "SELECT * FROM songs WHERE id = ?";

		try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, id);

			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					s = new Song();
					s.setId(rs.getInt("id"));
					s.setTitle(rs.getString("title"));
					s.setArtist(rs.getString("artist"));
					s.setLyrics(rs.getString("lyrics")); // Quan trọng: Lấy cột lyrics
					s.setCoverImage(rs.getString("coverImage"));
					// Map thêm các trường khác nếu có (genre, views...)
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return s;
	}

	// 3. Lấy Top bài hát (theo views)
	public List<Song> getTopSongs() {
		List<Song> list = new ArrayList<>();
		// MySQL: LIMIT 10
		// SQL Server: SELECT TOP 10 * ...
		String sql = "SELECT * FROM songs ORDER BY views DESC LIMIT 10";

		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				list.add(mapRowToSong(rs));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// --- HÀM 4: LẤY BÀI HÁT NGẪU NHIÊN (Cho mục Đề xuất) ---
	public List<Song> getRandomSongs(int top) {
		List<Song> list = new ArrayList<>();
		// SQL Server query: Lấy ngẫu nhiên
		String sql = "SELECT TOP (?) * FROM Songs ORDER BY NEWID()";

		try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, top); // Số lượng bài muốn lấy (ví dụ 6)
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				Song s = new Song();
				s.setId(rs.getInt("id"));
				s.setTitle(rs.getString("title"));
				s.setArtist(rs.getString("artist"));
				s.setGenre(rs.getString("genre"));
				s.setFilename(rs.getString("filename"));
				s.setCoverImage(rs.getString("cover_image"));
				s.setViews(rs.getInt("views"));
				s.setLyrics(rs.getString("lyrics"));

				list.add(s);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// 5. Tìm kiếm bài hát
	public List<Song> searchSongs(String keyword) {
		List<Song> list = new ArrayList<>();
		String sql = "SELECT * FROM songs WHERE title LIKE ? OR artist LIKE ?";

		try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setString(1, "%" + keyword + "%");
			ps.setString(2, "%" + keyword + "%");

			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					list.add(mapRowToSong(rs));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// Lấy bài hát theo tên
	public Song getSongByTitle(String title) {
		Song s = null;
		String sql = "SELECT * FROM Songs WHERE LTRIM(RTRIM(title)) = LTRIM(RTRIM(?))";

		try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setString(1, title);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					s = mapRowToSong(rs);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return s;
	}

	// 6. Xóa bài hát
	public void deleteSong(int id) {
		String sql = "DELETE FROM songs WHERE id=?";
		try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, id);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// lấy bài hát theo genre trong csdl
	public List<Song> getSongsByGenre(String genreCode) {
		List<Song> list = new ArrayList<>();
		// Giả sử cột trong DB tên là 'genre' và lưu 'V', 'K', 'U'
		String sql = "SELECT * FROM Songs WHERE genre = ?";

		try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setString(1, genreCode);
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

	// --- HÀM PHỤ (Helper) ---
	private Song mapRowToSong(ResultSet rs) throws java.sql.SQLException {
		return new Song(rs.getInt("id"), rs.getString("title"), rs.getString("artist"), rs.getString("genre"),
				rs.getString("filename"), rs.getString("lyrics"), rs.getString("cover_image"), rs.getInt("views"));
	}

	public int getTotalSongs() {
		String sql = "SELECT COUNT(*) FROM Songs";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	public void addSong(String title, String artist, String genre, String coverImage, String songUrl, String lyrics) {
		// Chú ý: Tên cột phải là cover_image và filename để khớp với hàm getAllSongs
		// của bạn
		String sql = "INSERT INTO Songs (title, artist, genre, cover_image, filename, lyrics, views) VALUES (?, ?, ?, ?, ?, ?, 0)";
		try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, title);
			ps.setString(2, artist);
			ps.setString(3, genre);
			ps.setString(4, coverImage);
			ps.setString(5, songUrl);
			ps.setString(6, lyrics);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/* === YÊU THÍCH == */
	// 1. Thêm vào yêu thích
	public boolean addFavorite(int userId, int songId) {
	    String sql = "INSERT INTO Favorites (user_id, song_id) VALUES (?, ?)";
	    try (Connection conn = DBUtil.getConnection(); 
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setInt(1, userId);
	        ps.setInt(2, songId);
	        return ps.executeUpdate() > 0;
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return false;
	}

	// 2. Xóa khỏi yêu thích
	public boolean removeFavorite(int userId, int songId) {
	    String sql = "DELETE FROM Favorites WHERE user_id = ? AND song_id = ?";
	    try (Connection conn = DBUtil.getConnection(); 
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setInt(1, userId);
	        ps.setInt(2, songId);
	        return ps.executeUpdate() > 0;
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return false;
	}

	// 3. Kiểm tra bài hát đã được thích chưa
	public boolean isFavourite(int userId, int songId) {
	    String sql = "SELECT * FROM Favorites WHERE user_id = ? AND song_id = ?";
	    try (Connection conn = DBUtil.getConnection(); 
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setInt(1, userId);
	        ps.setInt(2, songId);
	        ResultSet rs = ps.executeQuery();
	        return rs.next();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return false;
	}
}

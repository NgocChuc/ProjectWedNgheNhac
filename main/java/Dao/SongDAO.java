package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import Model_Layer.DBUtil;
import Model_Layer.Song;

public class SongDAO {
	public List<Song> getAllSongs() {
		List<Song> list = new ArrayList<Song>();
		try (Connection conn = DBUtil.getConnection()) {
			String sql = "SELECT * FROM Songs ORDER BY id DESC";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Song s = new Song(
					rs.getInt("id"),
	                rs.getString("title"),
	                rs.getString("artist"),
	                rs.getString("genre"),
	                rs.getString("filename"),
	                rs.getString("lyrics"),
	                rs.getString("cover_image"),
	                rs.getInt("views")
				);
				list.add(s);
			} 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
    public Song getSongById(int id) {
        Song s = null;
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT * FROM Songs WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                s = new Song(
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getString("artist"),
                    rs.getString("genre"),
                    rs.getString("filename"),
                    rs.getString("lyrics"),
                    rs.getString("cover_image"),
                    rs.getInt("views")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return s;
    }

    public List<Song> getTopSongs() {
        List<Song> list = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT * FROM Songs ORDER BY views DESC LIMIT 10";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Song s = new Song(
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getString("artist"),
                    rs.getString("genre"),
                    rs.getString("filename"),
                    rs.getString("lyrics"),
                    rs.getString("cover_image"),
                    rs.getInt("views")
                );
                list.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

	public List<Song> searchSongs(String keyword) {
		// TODO Auto-generated method stub
		List<Song> list = new ArrayList<Song>();
		try (Connection conn = DBUtil.getConnection()) {
			String sql = "SELECT * FROM Songs WHERE title LIKE ? OR artist LIKE ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			
			ps.setString(1, "%" + keyword + "%");
			ps.setString(2, "%" + keyword + "%");
			
			ResultSet rs = ps.executeQuery();
			
			while (rs.next()) {
	            Song s = new Song(
	                rs.getInt("id"),
	                rs.getString("title"),
	                rs.getString("artist"),
	                rs.getString("genre"),
	                rs.getString("filename"),
	                rs.getString("lyrics"),
	                rs.getString("cover_image"),
	                rs.getInt("views")
	            );
	            list.add(s);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
		
	}

	public void deleteSong(int id) {
		// TODO Auto-generated method stub
		try (Connection conn = DBUtil.getConnection()) {
			String sql = "DELETE FROM Songs WHERE id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	// --- [MỚI] HÀM 4: LẤY BÀI HÁT NGẪU NHIÊN (Cho mục Đề xuất) ---
    public List<Song> getRandomSongs(int limit) {
        List<Song> list = new ArrayList<>();
        // SQL Server dùng NEWID() để random
        String sql = "SELECT TOP (?) * FROM Songs ORDER BY NEWID()";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, limit);
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
}

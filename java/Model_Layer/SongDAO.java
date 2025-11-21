package Model_Layer;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class SongDAO {
	public List<Song> getAllSongs() {
		List<Song> list = new ArrayList<Song>();
		try (Connection conn = DBUtil.getConnection()) {
			String sql = "SELECT * FROM songs ORDER BY id DESC";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Song s = new Song(
					rs.getInt("id"),
	                rs.getString("title"),
	                rs.getString("artist"),
	                rs.getString("genre"),
	                rs.getString("filename"),
	                rs.getString("mv_link"),
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
            String sql = "SELECT * FROM songs WHERE id=?";
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
                    rs.getString("mv_link"),
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
            String sql = "SELECT * FROM songs ORDER BY views DESC LIMIT 10";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Song s = new Song(
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getString("artist"),
                    rs.getString("genre"),
                    rs.getString("filename"),
                    rs.getString("mv_link"),
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
			String sql = "SELECT * FROM songs WHERE title LIKE ? OR artist LIKE ?";
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
	                rs.getString("mv_link"),
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
			String sql = "DELETE FROM songs WHERE id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}

package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import Model_Layer.DBUtil;
import Model_Layer.Song;

public class FavoriteDAO {
	public List<Song> getFavoritesByUser(int userId) {
		List<Song> list = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT s.* FROM favorites f JOIN songs s ON f.song_id = s.id WHERE f.user_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Song(
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getString("artist"),
                    rs.getString("genre"),
                    rs.getString("filename"),
                    rs.getString("lyrics"),
                    rs.getString("cover_image"),
                    rs.getInt("views")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
	}
	
	public boolean addFavorite(int userId, int songId) {
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "INSERT INTO favorites(user_id, song_id) VALUES(?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, songId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

}

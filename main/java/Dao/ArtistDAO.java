package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import Model_Layer.*;

public class ArtistDAO {

	public List<Artist> getRandomArtists(int limit) {
        List<Artist> list = new ArrayList<>();
        // Tương tự, dùng NEWID() nếu là SQL Server
        String sql = "SELECT * FROM artists ORDER BY RAND() LIMIT ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                list.add(new Artist(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("role"),
                    rs.getString("image_url")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}

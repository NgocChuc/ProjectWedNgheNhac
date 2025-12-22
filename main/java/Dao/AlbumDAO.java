package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import Model_Layer.*;

public class AlbumDAO {

	public List<Album> getRandomAlbums(int limit) {
        List<Album> list = new ArrayList<>();
        // MySQL: dùng RAND()
        // SQL Server: đổi "RAND()" thành "NEWID()" và bỏ "LIMIT ?", dùng "SELECT TOP ..."
        String sql = "SELECT * FROM albums ORDER BY RAND() LIMIT ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                list.add(new Album(
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getString("artist_name"),
                    rs.getString("image_url")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}

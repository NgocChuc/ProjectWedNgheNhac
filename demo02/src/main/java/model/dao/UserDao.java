package model.dao;

import model.user.User; // Import lớp User từ package model.user
import util.DBUtil; // Giả định lớp tiện ích kết nối DB
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException; // Luôn import SQLException

public class UserDao {
    
    /**
     * Kiểm tra thông tin đăng nhập của người dùng. 
     * CHỈ DÙNG CHO DEMO: XÁC THỰC DÙNG PLAINTEXT (KHÔNG BẢO MẬT)
     * @param username - tên đăng nhập
     * @param password - mật khẩu (plaintext)
     * @return User nếu đúng, null nếu sai
     */
    public User checkLogin(String username, String password) {
        User user = null;
        // Lấy 3 cột cần thiết để gọi Constructor 3 tham số
        String sql = "SELECT id, username, role FROM users WHERE username=? AND password=?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, username);
            ps.setString(2, password); 
            ResultSet rs = ps.executeQuery();
            
            // Nếu có kết quả, tạo đối tượng User
            if (rs.next()) {
                user = new User(
                    rs.getInt("id"),
                    rs.getString("username"),
                    rs.getString("role")
                    // LƯU Ý: Nếu lớp User chỉ có Constructor 4 tham số,
                    // dòng này sẽ bị lỗi.
                );
            }
        } catch (SQLException e) { // Bắt lỗi SQL cụ thể
            e.printStackTrace();
        }
        return user;
    }
    
    
    /**
     * Đăng ký tài khoản người dùng mới.
     * CHỈ DÙNG CHO DEMO: LƯU MẬT KHẨU PLAINTEXT
     * @param username - tên đăng nhập
     * @param password - mật khẩu (plaintext)
     * @return true nếu thêm thành công
     */
    public boolean insertUser(String username, String password) {
        boolean result = false;
        String sql = "INSERT INTO users(username, password, role) VALUES(?, ?, 'user')";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, username);
            ps.setString(2, password);
            result = ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
}
package Model_Layer;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Lớp UserDAO dùng để thao tác với bảng 'user' trong database.
 * Gồm các chức năng: đăng nhập, đăng ký.
 */

public class UserDao {
	public User checkLogin(String email, String password) {
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT * FROM users WHERE email=? AND password=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
            	User u = new User();
                u.setId(rs.getInt("id"));
                u.setUserName(rs.getString("username"));
                u.setEmail(rs.getString("email"));
                u.setPassword(rs.getString("password"));
                u.setRole(rs.getString("role"));
                u.setAvatarUrl(rs.getString("avatarUrl"));
                return u;
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    public boolean checkEmailExists(String email) {
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT id FROM users WHERE email=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public boolean insertUser(User user) {
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "INSERT INTO users(username, email, password, role) VALUES (?, ?, ?, 'user')";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user.getUserName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());

            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }


	public void registerUser(User user) {
		// TODO Auto-generated method stub
		insertUser(user);
	}

	public User getUserByEmail(String email) {
		 try (Connection conn = DBUtil.getConnection()) {
		        String sql = "SELECT * FROM users WHERE email = ?";
		        PreparedStatement ps = conn.prepareStatement(sql);
		        ps.setString(1, email);

		        ResultSet rs = ps.executeQuery();
		        if (rs.next()) {
		            User u = new User();
		            u.setId(rs.getInt("id"));
		            u.setUserName(rs.getString("username"));
		            u.setEmail(rs.getString("email"));
		            u.setPassword(rs.getString("password"));
		            u.setRole(rs.getString("role"));
		            u.setAvatarUrl(rs.getString("avatarUrl"));
		            return u;
		        }

		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		    return null; 
	}

}

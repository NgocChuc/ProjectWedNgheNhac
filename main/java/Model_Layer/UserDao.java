package Model_Layer;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Lớp UserDAO dùng để thao tác với bảng 'user' trong database.
 * Gồm các chức năng: đăng nhập, đăng ký.
 */

public class UserDao {
	/**
	 * Kiểm tra thông tin đăng nhập của người dùng.
	 * @param username - tên đăng nhập
	 * @param password - mật khẩu
	 * @return User nếu đúng, null nếu sai
	 */
	public User checkLogin(String username, String password) {
		User user = null;
		try (Connection conn = DBUtil.getConnection()) {
			String sql = "SELECT * FROM users WHERE username=? AND password=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			ps.setString(2, password);
			ResultSet rs = ps.executeQuery();
			
			//Nếu tìm thấy user -> tạo đối tượng User để trả về
			if(rs.next()) {
				user = new User(
					rs.getInt("id"),
					rs.getString("username"),
					rs.getString("password"),
					rs.getString("role")
				);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}
	
	
	/**
     * Đăng ký tài khoản người dùng mới.
     * @param user - đối tượng User cần thêm
     * @return true nếu thêm thành công
     */
    public boolean insertUser(User user) {
        boolean result = false;
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "INSERT INTO users(username, password, role) VALUES(?, ?, 'user')";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user.getUserName());
            ps.setString(2, user.getPassword());
            result = ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

}

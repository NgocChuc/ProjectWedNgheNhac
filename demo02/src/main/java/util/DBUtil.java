package util; // Đề xuất đặt trong package 'util'

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Lớp tiện ích quản lý và cung cấp kết nối đến cơ sở dữ liệu.
 */
public class DBUtil {
    
    // --- THÔNG SỐ KẾT NỐI CƠ SỞ DỮ LIỆU CỦA BẠN ---
    
    // Ví dụ cho MySQL (Sử dụng JDBC driver phù hợp với DB của bạn)
    private static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    // Thay đổi thông tin DB_URL, DatabaseName, Port
    private static final String DB_URL = "jdbc:mysql://localhost:3306/ten_database_cua_ban"; 
    private static final String DB_USERNAME = "root"; // Tên người dùng DB
    private static final String DB_PASSWORD = "password_cua_ban"; // Mật khẩu DB

    // -------------------------------------------------------------------

    /**
     * Tải JDBC Driver khi lớp được khởi tạo.
     * Cần thiết để đảm bảo Driver được đăng ký trong môi trường Tomcat cũ.
     */
    static {
        try {
            Class.forName(JDBC_DRIVER);
            System.out.println("JDBC Driver đã được tải.");
        } catch (ClassNotFoundException e) {
            System.err.println("Lỗi: Không tìm thấy JDBC Driver: " + JDBC_DRIVER);
            e.printStackTrace();
        }
    }

    /**
     * Mở và trả về một đối tượng Connection mới.
     * @return Connection đến cơ sở dữ liệu.
     * @throws SQLException nếu có lỗi kết nối.
     */
    public static Connection getConnection() throws SQLException {
        // Trả về kết nối đến DB
        return DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
    }

    /**
     * Đóng kết nối.
     * @param conn Đối tượng Connection cần đóng.
     */
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                System.err.println("Lỗi khi đóng kết nối: " + e.getMessage());
            }
        }
    }
}
package Model_Layer;

import java.sql.*;
import java.sql.DriverManager;
import java.sql.SQLException;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

public class DBUtil {
	private static final HikariDataSource dataSource;
	
	private static final String URL = "jdbc:sqlserver://localhost:1435;databaseName=MusicDB;encrypt=false";
	private static final String USER = "sa";
	private static final String PASS = "Admin@123";
	
	 static {
	        HikariConfig config = new HikariConfig();

	        // Cấu hình kết nối
	        config.setJdbcUrl(URL);
	        config.setUsername(USER);
	        config.setPassword(PASS);

	        // Driver SQL Server
	        config.setDriverClassName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

	        // Cấu hình Pool (tùy chỉnh)
	        config.setMaximumPoolSize(10);       // tối đa 10 kết nối
	        config.setMinimumIdle(2);            // tối thiểu 2 kết nối nhàn rỗi
	        config.setConnectionTimeout(30000);  // 30 giây
	        config.setIdleTimeout(600000);       // 10 phút
	        config.setMaxLifetime(1800000);      // 30 phút

	        // Khởi tạo pool
	        dataSource = new HikariDataSource(config);
	        System.out.println("HikariCP Connection Pool initialized successfully!");
	    }

	    // 4. Lấy Connection từ pool
	    public static Connection getConnection() throws SQLException {
	        return dataSource.getConnection(); // Lấy connection từ pool
	    }

	    // 5. Đóng pool khi ứng dụng tắt
	    public static void closePool() {
	        if (dataSource != null) {
	            dataSource.close();
	            System.out.println("HikariCP Connection Pool closed.");
	        }
	    }

}

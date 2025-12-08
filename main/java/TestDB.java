import java.sql.Connection;
import Model_Layer.DBUtil;

public class TestDB {
	public static void main(String[] args) {
		try (Connection conn = DBUtil.getConnection()) { // try-with-resources tự đóng connection
            System.out.println("Connected via pool: " + (conn != null));
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.closePool(); // Đóng pool khi không dùng nữa
        }
    }

}

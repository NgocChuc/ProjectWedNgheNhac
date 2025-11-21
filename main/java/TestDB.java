import java.sql.Connection;
import Model_Layer.DBUtil;

public class TestDB {
	public static void main(String[] args) {
        Connection conn = DBUtil.getConnection();
        if (conn != null) {
            System.out.println("✅ Kết nối CSDL thành công!");
        } else {
            System.out.println("❌ Kết nối thất bại!");
        }
    }

}

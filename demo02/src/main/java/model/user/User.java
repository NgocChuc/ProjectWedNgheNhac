package model.user;

public class User {
	private int id;
	private String username;
	private String role;
	// Thêm các thuộc tính cần thiết cho tính năng mở rộng sau này
	private String avatarUrl;

	public User(int id, String username, String role, String avatarUrl) {
		this.id = id;
		this.username = username;
		this.role = role;
		this.avatarUrl = avatarUrl;
	}

	// Constructor 3 tham số: Dùng khi khởi tạo từ UserDao
	public User(int id, String username, String role) {
		this.id = id;
		this.username = username;
		this.role = role;
		this.avatarUrl = null; // Khởi tạo avatarUrl là null
	}

	public int getId() {
		return id;
	}

	public String getUsername() {
		return username;
	}

	public String getRole() {
		return role;
	}

	public String getAvatarUrl() {
		return avatarUrl;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setAvatarUrl(String avatarUrl) {
		this.avatarUrl = avatarUrl;
	}
}
package Model_Layer;

public class Playlist {
    // 1. Các thuộc tính (Phải khớp kiểu dữ liệu với Database)
    private int id;                 // DB: INT
    private String name;            // DB: NVARCHAR(100)
    private String description;     // DB: NVARCHAR(500)
    private String coverImage;      // DB: NVARCHAR(255) 
    private int userId;             // DB: INT

    // 2. Constructor rỗng (Bắt buộc để khởi tạo trong DAO)
    public Playlist() {
    }

    // 3. Constructor đầy đủ (Dùng khi cần tạo nhanh)
    public Playlist(int id, String name, String description, String coverImage, int userId) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.coverImage = coverImage;
        this.userId = userId;
    }

    // 4. Getter và Setter (Dùng để truy xuất dữ liệu từ JSP)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCoverImage() {
        return coverImage;
    }

    public void setCoverImage(String coverImage) {
        this.coverImage = coverImage;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
}
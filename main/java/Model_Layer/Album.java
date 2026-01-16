package Model_Layer;

public class Album {
	private int id;
    private String title;
    private String artistName;
    private String imageUrl;

    public Album(int id, String title, String artistName, String imageUrl) {
        this.id = id;
        this.title = title;
        this.artistName = artistName;
        this.imageUrl = imageUrl;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getArtistName() { return artistName; }
    public void setArtistName(String artistName) { this.artistName = artistName; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
}

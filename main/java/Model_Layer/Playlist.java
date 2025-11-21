package Model_Layer;

public class Playlist {
	private int id;
	private String name;
	private String coverImage;
	
	public Playlist() { }
	
	public Playlist(int id, String name, String coverImage) {
		super();
		this.id = id;
		this.name = name;
		this.coverImage = coverImage;
	}

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

	public String getCoverImage() {
		return coverImage;
	}

	public void setCoverImage(String coverImage) {
		this.coverImage = coverImage;
	}
	
	

}

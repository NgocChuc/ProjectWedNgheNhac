package Model_Layer;

public class Favorite {
	private int id;
	private int userId;
	private int songId;
	
	public Favorite() { }

	public Favorite(int id, int userId, int songId) {
		super();
		this.id = id;
		this.userId = userId;
		this.songId = songId;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getSongId() {
		return songId;
	}

	public void setSongId(int songId) {
		this.songId = songId;
	}
	
	

}

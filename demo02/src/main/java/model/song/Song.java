package model.song;

public class Song {
	private int id;
	private String title;
	private String artist;
	private String coverUrl; // Link ảnh bìa
	private String duration; // Thời lượng (VD: "3:45")

	public Song(int id, String title, String artist, String coverUrl, String duration) {
		this.id = id;
		this.title = title;
		this.artist = artist;
		this.coverUrl = coverUrl;
		this.duration = duration;
	}

	// --- Getters & Setters ---
	public int getId() {
		return id;
	}

	public String getTitle() {
		return title;
	}

	public String getArtist() {
		return artist;
	}

	public String getCoverUrl() {
		return coverUrl;
	}

	public String getDuration() {
		return duration;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public void setArtist(String artist) {
		this.artist = artist;
	}

	public void setCoverUrl(String coverUrl) {
		this.coverUrl = coverUrl;
	}

	public void setDuration(String duration) {
		this.duration = duration;
	}

}
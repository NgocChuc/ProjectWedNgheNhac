package Model_Layer;

public class Song {
	private int id;
	private String title;
	private String artist;
	private String genre;
	private String filename;
	private String mvLink;
	private String lyrics;
	private String coverImage;
	private int views;
	
	public Song() { }
	
	public Song(int id, String title, String artist, String genre, String filename, String mvLink, String lyrics,
			String coverImage, int views) {
		super();
		this.id = id;
		this.title = title;
		this.artist = artist;
		this.genre = genre;
		this.filename = filename;
		this.mvLink = mvLink;
		this.lyrics = lyrics;
		this.coverImage = coverImage;
		this.views = views;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getArtist() {
		return artist;
	}

	public void setArtist(String artist) {
		this.artist = artist;
	}

	public String getGenre() {
		return genre;
	}

	public void setGenre(String genre) {
		this.genre = genre;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getMvLink() {
		return mvLink;
	}

	public void setMvLink(String mvLink) {
		this.mvLink = mvLink;
	}

	public String getLyrics() {
		return lyrics;
	}

	public void setLyrics(String lyrics) {
		this.lyrics = lyrics;
	}

	public String getCoverImage() {
		return coverImage;
	}

	public void setCoverImage(String coverImage) {
		this.coverImage = coverImage;
	}

	public int getViews() {
		return views;
	}

	public void setViews(int views) {
		this.views = views;
	}
	
	

}

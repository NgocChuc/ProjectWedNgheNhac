import java.util.List;

import Model_Layer.Song;
import Model_Layer.SongDAO;

public class TestDao {
	public static void main(String[] args) {
		 SSongDAO dao = new SongDAO();
        List<Song> songs = dao.getAllSongs();

        // In tiêu đề bảng
        System.out.printf("%-5s %-30s %-20s %-15s %-6s%n", "ID", "Title", "Artist", "Genre", "Views");
        System.out.println("-------------------------------------------------------------------------------");

        // In từng bài hát
        for (Song song : songs) {
            System.out.printf("%-5d %-30s %-20s %-15s %-6d%n",
                    song.getId(),
                    song.getTitle(),
                    song.getArtist(),
                    song.getGenre(),
                    song.getViews()
            );
        }
	}
}

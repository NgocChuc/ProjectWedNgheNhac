import java.util.List;

import Model_Layer.Song;
import Model_Layer.SongDAO;

public class TestDao {
	public static void main(String[] args) {
		 SongDAO dao = new SongDAO();
	        dao.getAllSongs().forEach(song -> System.out.println(song.getTitle()));
    }

}

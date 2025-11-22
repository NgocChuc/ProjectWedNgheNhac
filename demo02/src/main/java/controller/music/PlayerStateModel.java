package controller.music;

/**
 * Đại diện cho trạng thái hiện tại của trình phát nhạc (Play/Pause, Loop, Shuffle).
 * Dữ liệu này sẽ được cập nhật thông qua AJAX call tới PlayerController.
 */
public class PlayerStateModel {
    private boolean isPlaying;
    private boolean isLooping;
    private boolean isShuffling;
    private String currentTime; // Định dạng chuỗi (ví dụ: "0:35")
    private int progressPercent; // Phần trăm tiến trình (0-100)

    public PlayerStateModel(boolean isPlaying, boolean isLooping, boolean isShuffling, String currentTime, int progressPercent) {
        this.isPlaying = isPlaying;
        this.isLooping = isLooping;
        this.isShuffling = isShuffling;
        this.currentTime = currentTime;
        this.progressPercent = progressPercent;
    }

    // --- Getters ---
    public boolean isPlaying() { return isPlaying; }
    public boolean isLooping() { return isLooping; }
    public boolean isShuffling() { return isShuffling; }
    public String getCurrentTime() { return currentTime; }
    public int getProgressPercent() { return progressPercent; }

    // --- Setters ---
    public void setPlaying(boolean playing) { isPlaying = playing; }
    public void setLooping(boolean looping) { isLooping = looping; }
    public void setShuffling(boolean shuffling) { isShuffling = shuffling; }
    public void setCurrentTime(String currentTime) { this.currentTime = currentTime; }
    public void setProgressPercent(int progressPercent) { this.progressPercent = progressPercent; }
}
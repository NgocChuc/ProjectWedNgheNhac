<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- Lấy thông tin bài hát từ Request Scope (được gửi từ HomeServlet) --%>
<%
    model.song.Song song = (model.song.Song) request.getAttribute("currentSong");
    // Nếu chưa có bài hát nào, tạo dữ liệu giả mặc định để không bị lỗi giao diện
    if (song == null) {
        song = new model.song.Song(0, "Chưa chọn bài hát", "Unknown", "https://placehold.co/200", "0:00");
    }
%>

<div class="music-player-container">
    <div class="song-info-music-player">
        <div class="song-cover">
            <img src="<%=song.getCoverUrl()%>" alt="Song Cover">
        </div>
        <div class="song-infor-mp">
            <div id="SongIDTitle" class="song-title-mp"><%=song.getTitle()%></div>
            <div id="SongIDArtist" class="song-artist-mp">
                <span><%=song.getArtist()%></span>
                <span class="material-symbols-outlined verified-icon" style="font-size: 14px;">verified</span>
            </div>
        </div>
        <button class="control-btn favorite-icon-mp" id="favoriteBtn-mp">
           <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="currentColor">
                <path d="m480-120-58-52q-101-91-167-157T150-447.5Q111-500 95.5-544T80-634q0-94 63-157t157-63q52 0 99 22t81 62q34-40 81-62t99-22q94 0 157 63t63 157q0 46-15.5 90T810-447.5Q771-395 705-329T538-172l-58 52Z" />
            </svg>
        </button>
    </div>

    <div class="control-bar-mp">
        <div class="controls-mp">
            <button class="control-btn" id="shuffleBtn">
                <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="currentColor"><path d="M560-160v-80h104L537-367l57-57 126 126v-102h80v240H560Zm-344 0-56-56 504-504H560v-80h240v240h-80v-104L216-160Zm151-377L160-744l56-56 207 207-56 56Z" /></svg>
            </button>

            <button class="control-btn" id="prevBtn">
                <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="currentColor"><path d="M220-240v-480h80v480h-80Zm520 0L380-480l360-240v480Z" /></svg>
            </button>

            <button class="control-btn play-btn" id="playBtn">
                <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#000"><path d="M320-203v-560l440 280-440 280Z" /></svg>
            </button>

            <button class="control-btn" id="nextBtn">
                 <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="currentColor"><path d="M660-240v-480h80v480h-80Zm-440 0v-480l360 240-360 240Z" /></svg>
            </button>

            <button class="control-btn" id="repeatBtn">
                <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="currentColor"><path d="M280-80 120-240l160-160 56 58-62 62h406v-160h80v240H274l62 62-56 58Zm-80-440v-240h486l-62-62 56-58 160 160-160 160-56-58 62-62H280v160h-80Z" /></svg>
            </button>
        </div>

        <div class="progress-container-mp">
            <span class="time-mp" id="currentTime">0:00</span>
            <div class="progress-bar" id="progressBar">
                <div class="progress-fill" id="progressFill" style="width: 0%;"></div>
            </div>
            <span class="time-mp" id="totalTime"><%=song.getDuration()%></span>
        </div>
    </div>

    <div class="extra-controls">
        <button class="control-btn"><svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="currentColor"><path d="M80-80v-720q0-33 23.5-56.5T160-880h440q33 0 56.5 23.5T680-800v17q-24 11-44 27t-36 36v-80H160v527l47-47h393v-160q16 20 36 36t44 27v97q0 33-23.5 56.5T600-240H240L80-80Z"/></svg></button>
    </div>
</div>
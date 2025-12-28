<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<footer class="player-bar">
    <div class="now-playing">
        <img src="https://picsum.photos/id/90/60/60" alt="album">
        <div class="track-info">
            <strong>Levitating</strong>
            <span>Dua Lipa</span>
        </div>
        <span class="material-symbols-outlined">favorite</span>
    </div>
    
    <div class="player-controls">
        <div class="buttons">
            <span class="material-symbols-outlined">shuffle</span>
            <span class="material-symbols-outlined">skip_previous</span>
            <button class="play-btn"><span class="material-symbols-outlined">pause</span></button>
            <span class="material-symbols-outlined">skip_next</span>
            <span class="material-symbols-outlined">repeat</span>
        </div>
        <div class="progress-area">
            <span>1:15</span>
            <div class="bar"><div class="fill"></div></div>
            <span>3:23</span>
        </div>
    </div>

    <div class="extra-controls">
        <span class="material-symbols-outlined">queue_music</span>
        <span class="material-symbols-outlined">volume_up</span>
        <div class="volume-bar"><div class="volume-fill"></div></div>
    </div>
</footer>

<audio id="main-audio" src="${pageContext.request.contextPath}/assets/music/your-song.mp3"></audio>
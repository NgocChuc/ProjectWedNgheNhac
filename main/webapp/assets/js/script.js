/* ==========================================================================
   1. KHAI BÁO BIẾN TOÀN CỤC & TRẠNG THÁI
   ========================================================================== */
let songs = [];
let songIndex = 0;
let isPlaying = false;
let currentSongId = null;
let isShuffle = false;
let isRepeat = false;

/* ==========================================================================
   2. CÁC HÀM ĐIỀU KHIỂN GIAO DIỆN (UI)
   ========================================================================== */

// Chức năng đóng/mở thanh Sidebar
function toggleSidebar() {
    const wrapper = document.querySelector('.main-content-wrapper');
    const arrowBtn = document.getElementById('toggleArrowBtn');

    if (wrapper) {
        wrapper.classList.toggle('collapsed');
        if (arrowBtn) {
            const icon = arrowBtn.querySelector('.arrow-icon');
            if (icon) {
                icon.style.transform = wrapper.classList.contains('collapsed') ? 'rotate(180deg)' : 'rotate(0deg)';
            }
        }
        const isCollapsed = wrapper.classList.contains('collapsed');
        localStorage.setItem('sidebarState', isCollapsed ? 'collapsed' : 'expanded');
    }
}

// Chức năng cuộn các thẻ bài hát (Carousel)
function scrollCards(button, direction) {
    const wrapper = button.parentElement;
    const container = wrapper.querySelector('.scroll-container');
    if (container) {
        const scrollAmount = container.offsetWidth * 0.7;
        container.scrollBy({ left: direction * scrollAmount, behavior: 'smooth' });
    }
}

// Chức năng định dạng thời gian bài hát (mm:ss)
function formatTime(time) {
    let min = Math.floor(time / 60);
    let sec = Math.floor(time % 60);
    if (sec < 10) sec = `0${sec}`;
    return `${min}:${sec}`;
}

/* ==========================================================================
   3. LOGIC XỬ LÝ NHẠC CHÍNH (PLAYER CORE)
   ========================================================================== */

// Chức năng nạp thông tin bài hát lên thanh Player
function loadSong(index) {
    if (!songs || songs.length === 0) return;
    const song = songs[index];

    const playerTitle = document.getElementById("player-title");
    const playerArtist = document.getElementById("player-artist");
    const playerCover = document.getElementById("player-cover");
    const audio = document.getElementById("main-audio");

    if (playerTitle) playerTitle.innerText = song.title;
    if (playerArtist) playerArtist.innerText = song.artist;
    if (playerCover) playerCover.style.backgroundImage = `url('${song.cover}')`;
    if (audio) {
        audio.src = song.src;
    }
}

// Chức năng nhận yêu cầu phát nhạc từ danh sách
function loadAndPlay(id, title, artist, coverPath, musicPath) {
    console.log("Play:", title);
    window.currentSongId = id;
    currentSongId = id;

    let lyricsText = "";
    const lyricsElement = document.getElementById("lyrics-data-" + id);
    if (lyricsElement) {
        lyricsText = lyricsElement.value;
    }

    // Xử lý danh sách phát
    if (typeof currentListOnPage !== 'undefined' && currentListOnPage.length > 0) {
        songs = currentListOnPage;
        songIndex = songs.findIndex(s => s.id == id);
    } else {
        const existingIndex = songs.findIndex(s => s.src === musicPath);
        if (existingIndex !== -1) {
            songIndex = existingIndex;
        } else {
            const newSong = { id, title, artist, cover: coverPath, src: musicPath, lyrics: lyricsText };
            songs.unshift(newSong);
            songIndex = 0;
        }
    }
	

    loadSong(songIndex);
    playSong();

    // Cập nhật giao diện phụ (Lyrics, Like)
    if (typeof LyricsManager !== 'undefined' && LyricsManager.isOpen) {
        LyricsManager.show(id);
    }
    
    if (typeof window.isLoggedIn !== 'undefined' && window.isLoggedIn) {
        fetch(`${window.location.origin}${window.contextPath || ''}/api/favorite?check=true&songId=${id}`)
            .then(res => res.text())
            .then(status => {
                const btnLike = document.getElementById('btn-like');
                if (btnLike) status.trim() === "liked" ? btnLike.classList.add('active') : btnLike.classList.remove('active');
            });
    }

    if (typeof checkFavoriteStatus === 'function') checkFavoriteStatus(id);
}

// Chức năng phát nhạc
function playSong() {
    const audio = document.getElementById("main-audio");
    const playPauseBtn = document.getElementById("btn-play-pause");
    if (!audio) return;
    isPlaying = true;
    audio.play().then(_ => {
        if (playPauseBtn) playPauseBtn.innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" height="32" viewBox="0 96 960 960" width="32"><path d="M560 776V376h80v400h-80ZM320 776V376h80v400h-80Z"/></svg>`;
    }).catch(e => console.error("Error:", e));
}

// Chức năng tạm dừng nhạc
function pauseSong() {
    const audio = document.getElementById("main-audio");
    const playPauseBtn = document.getElementById("btn-play-pause");
    if (!audio) return;
    isPlaying = false;
    audio.pause();
    if (playPauseBtn) playPauseBtn.innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" height="32" viewBox="0 96 960 960" width="32"><path d="M320 853V293l440 280-440 280Z"/></svg>`;
}

/* ==========================================================================
   4. ĐIỀU KHIỂN DANH SÁCH PHÁT (NEXT, PREV, SHUFFLE, REPEAT)
   ========================================================================== */

// Chức năng chuyển bài kế tiếp
function nextSong() {
    if (songs.length === 0) return;
    if (isShuffle) {
        let newIndex;
        do {
            newIndex = Math.floor(Math.random() * songs.length);
        } while (newIndex === songIndex && songs.length > 1);
        songIndex = newIndex;
    } else {
        songIndex = (songIndex + 1) % songs.length;
    }
    loadSong(songIndex);
    playSong();
    updateUIAfterChange();
}

// Chức năng quay lại bài trước
function prevSong() {
    if (songs.length === 0) return;
    songIndex = (songIndex - 1 + songs.length) % songs.length;
    loadSong(songIndex);
    playSong();
    updateUIAfterChange();
}

// Chức năng cập nhật UI khi thay đổi bài hát
function updateUIAfterChange() {
    const currentId = songs[songIndex].id;
    window.currentSongId = currentId;
    if (typeof checkFavoriteStatus === 'function') checkFavoriteStatus(currentId);
    if (typeof LyricsManager !== 'undefined' && LyricsManager.isOpen) LyricsManager.show(currentId);
}

/* ==========================================================================
   5. KHỞI TẠO SỰ KIỆN KHI TRANG SẴN SÀNG (DOM CONTENT LOADED)
   ========================================================================== */
document.addEventListener('DOMContentLoaded', function() {

    // Khôi phục trạng thái Sidebar
    const savedState = localStorage.getItem('sidebarState');
    const wrapper = document.querySelector('.main-content-wrapper');
    if (savedState === 'collapsed' && wrapper) {
        wrapper.classList.add('collapsed');
        const icon = document.querySelector('#toggleArrowBtn .arrow-icon');
        if (icon) icon.style.transform = 'rotate(180deg)';
    }

    // Xử lý Menu Dropdown (Thông báo & Tài khoản)
    const notificationBtn = document.getElementById('notificationBtn');
    const notificationsDropdown = document.getElementById('notificationsDropdown');
    const userAvatarBtn = document.querySelector('.useraccount-btn');
    const userDropdown = document.getElementById('userDropdown');

    if (notificationBtn) {
        notificationBtn.addEventListener('click', e => {
            e.stopPropagation();
            notificationsDropdown.classList.toggle('show');
            if (userDropdown) userDropdown.classList.remove('show');
        });
    }
    if (userAvatarBtn) {
        userAvatarBtn.addEventListener('click', e => {
            e.preventDefault(); e.stopPropagation();
            userDropdown.classList.toggle('show');
            if (notificationsDropdown) notificationsDropdown.classList.remove('show');
        });
    }
    document.addEventListener('click', () => {
        if (notificationsDropdown) notificationsDropdown.classList.remove('show');
        if (userDropdown) userDropdown.classList.remove('show');
    });

    // Carousel tự động chạy
    const track = document.getElementById('carouselTrack');
    const items = track ? track.getElementsByClassName('carousel-item') : [];
    if (items.length > 0) {
        let currentIndex = 0;
        setInterval(() => {
            currentIndex = (currentIndex + 1) % items.length;
            track.style.transform = `translateX(${-currentIndex * (100 / items.length)}%)`;
        }, 3000);
    }

    // Sự kiện kéo chuột để cuộn danh sách (Drag scroll)
    const containers = document.querySelectorAll('.scroll-container');
    containers.forEach(container => {
        let isDown = false, startX, scrollLeft;
        container.addEventListener('mousedown', e => {
            isDown = true; container.classList.add('active-drag');
            startX = e.pageX - container.offsetLeft; scrollLeft = container.scrollLeft;
        });
        container.addEventListener('mouseleave', () => { isDown = false; container.classList.remove('active-drag'); });
        container.addEventListener('mouseup', () => { isDown = false; container.classList.remove('active-drag'); });
        container.addEventListener('mousemove', e => {
            if (!isDown) return;
            e.preventDefault();
            const walk = (e.pageX - container.offsetLeft - startX) * 1.5;
            container.scrollLeft = scrollLeft - walk;
        });
    });

    // CÁC SỰ KIỆN ĐIỀU KHIỂN PLAYER
    const audio = document.getElementById("main-audio");
    const playPauseBtn = document.getElementById("btn-play-pause");
    const progressArea = document.getElementById("progress-area");
    const progressFill = document.getElementById("progress-fill");

    // Nút Play/Pause
    if (playPauseBtn) {
        playPauseBtn.addEventListener("click", () => {
            if (songs.length === 0) return;
            isPlaying ? pauseSong() : playSong();
        });
    }

    // Xử lý tiến trình bài hát
    if (audio) {
        audio.addEventListener("timeupdate", e => {
            const { currentTime, duration } = e.target;
            if (!isNaN(duration) && progressFill) {
                progressFill.style.width = `${(currentTime / duration) * 100}%`;
                document.getElementById("current-time").innerText = formatTime(currentTime);
                document.getElementById("total-duration").innerText = formatTime(duration);
            }
        });
        audio.addEventListener("ended", () => {
            if (isRepeat && !isShuffle) {
                loadSong(songIndex); playSong();
            } else {
                nextSong();
            }
        });
    }

    // Click thanh tiến trình để tua
    if (progressArea) {
        progressArea.addEventListener("click", e => {
            if (!audio) return;
            audio.currentTime = (e.offsetX / progressArea.clientWidth) * audio.duration;
            playSong();
        });
    }

    // Nút điều khiển danh sách
    document.getElementById("btn-next")?.addEventListener("click", nextSong);
    document.getElementById("btn-prev")?.addEventListener("click", prevSong);
    document.getElementById("btn-repeat")?.addEventListener("click", function() {
        isRepeat = !isRepeat;
        this.classList.toggle("active-btn", isRepeat);
        this.style.color = isRepeat ? "#86B6F6" : "#fff";
    });
    document.getElementById("btn-shuffle")?.addEventListener("click", function() {
        isShuffle = !isShuffle;
        this.classList.toggle("active-btn", isShuffle);
        this.style.color = isShuffle ? "#86B6F6" : "#fff";
    });

    // Nút mở Lyrics
    document.getElementById("btn-lyrics")?.addEventListener("click", () => {
        if (typeof LyricsManager !== 'undefined') {
            LyricsManager.toggle(window.currentSongId);
        }
    });

});
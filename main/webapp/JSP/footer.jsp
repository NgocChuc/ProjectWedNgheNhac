<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/style.css">


<audio id="main-audio" src=""></audio>

<footer class="player-footer">
	<div class="footer-left">
		<div id="player-cover" class="footer-img"
            style='background-image: url("${pageContext.request.contextPath}/assets/img/default.png");'>
        </div>
		<div class="footer-track-info">
            <p id="player-title" class="track-name">Chưa chọn bài hát</p>
            <p id="player-artist" class="track-artist">...</p>
        </div>
		<svg class="icon-subtle icon-hover svg-icon"
			xmlns="http://www.w3.org/2000/svg" height="24px"
			viewBox="0 -960 960 960" width="24px">
            <path
				d="m480-120-58-52q-101-91-167-157T150-447.5Q111-500 95.5-544T80-634q0-94 63-157t157-63q52 0 99 22t81 62q34-40 81-62t99-22q94 0 157 63t63 157q0 46-15.5 90T810-447.5Q771-395 705-329T538-172l-58 52Z" />
        </svg>
	</div>

	<div class="footer-center">
		<div class="controls-row">
			<svg class="icon-subtle icon-hover svg-icon"
				xmlns="http://www.w3.org/2000/svg" height="24px"
				viewBox="0 -960 960 960" width="24px">
                <path
					d="M560-160v-80h104L537-367l57-57 126 126v-102h80v240H560Zm-344 0-56-56 504-504H560v-80h240v240h-80v-104L216-160Zm151-377L160-744l56-56 207 207-56 56Z" />
            </svg>
			<svg class="icon-subtle icon-hover icon-large svg-icon"
				xmlns="http://www.w3.org/2000/svg" height="36"
				viewBox="0 96 960 960" width="36">
                <path
					d="M220 776V376h80v400h-80Zm520 0-280-200 280-200v400Z" />
            </svg>
			<button class="btn-play-pause">
				<svg class="icon-large svg-icon" xmlns="http://www.w3.org/2000/svg"
					height="36" viewBox="0 96 960 960" width="36">
                    <path
						d="M520 776V376h160v400H520Zm-240 0V376h160v400H280Z" />
                </svg>
			</button>
			<svg class="icon-subtle icon-hover icon-large svg-icon"
				xmlns="http://www.w3.org/2000/svg" height="36"
				viewBox="0 96 960 960" width="36">
                <path
					d="M660 776V376h80v400h-80ZM220 776V376l280 200-280 200Z" />
            </svg>
			<svg class="icon-subtle icon-hover svg-icon"
				xmlns="http://www.w3.org/2000/svg" height="24px"
				viewBox="0 -960 960 960" width="24px">
                <path
					d="M280-80 120-240l160-160 56 58-62 62h406v-160h80v240H274l62 62-56 58Zm-80-440v-240h486l-62-62 56-58 160 160-160 160-56-58 62-62H280v160h-80Z" />
            </svg>
		</div>
		<div class="progress-bar-container">
			<span id="current-time" class="time-label">0:00</span>

			<div class="progress-bg" id="progress-area" onclick="seekSong(event)">
				<div id="progress-fill" class="progress-fill" style="width: 0%"></div>
			</div>

			<span id="total-duration" class="time-label">0:00</span>
		</div>
	</div>

	<div class="footer-right">
		<svg class="icon-subtle icon-hover svg-icon"
			xmlns="http://www.w3.org/2000/svg" height="24px"
			viewBox="0 -960 960 960" width="24px">
            <path
				d="M120-320v-80h280v80H120Zm0-160v-80h440v80H120Zm0-160v-80h440v80H120Zm520 480v-160H480v-80h160v-160h80v160h160v80H720v160h-80Z" />
        </svg>
		<svg class="icon-subtle icon-hover svg-icon"
			xmlns="http://www.w3.org/2000/svg" height="24px"
			viewBox="0 -960 960 960" width="24px">
            <path
				d="M80-80v-720q0-33 23.5-56.5T160-880h440q33 0 56.5 23.5T680-800v17q-24 11-44 27t-36 36v-80H160v527l47-47h393v-160q16 20 36 36t44 27v97q0 33-23.5 56.5T600-240H240L80-80Zm160-320h160v-80H240v80Zm520-80q-50 0-85-35t-35-85q0-50 35-85t85-35q11 0 21 2t19 5v-207h160v80h-80v240q0 50-35 85t-85 35Zm-520-40h280v-80H240v80Zm0-120h280v-80H240v80Zm-80 320v-480 480Z" />
        </svg>
		<svg class="icon-subtle icon-hover svg-icon"
			xmlns="http://www.w3.org/2000/svg" height="24px"
			viewBox="0 -960 960 960" width="24px">
            <path
				d="M640-160q-50 0-85-35t-35-85q0-50 35-85t85-35q11 0 21 1.5t19 6.5v-328h200v80H760v360q0 50-35 85t-85 35ZM120-320v-80h320v80H120Zm0-160v-80h480v80H120Zm0-160v-80h480v80H120Z" />
        </svg>
		<svg class="icon-subtle icon-hover svg-icon"
			xmlns="http://www.w3.org/2000/svg" height="24px"
			viewBox="0 -960 960 960" width="24px">
            <path
				d="M560-131v-82q90-26 145-100t55-168q0-94-55-168T560-749v-82q124 28 202 125.5T840-481q0 127-78 224.5T560-131ZM120-360v-240h160l200-200v640L280-360H120Zm440 40v-322q47 22 73.5 66t26.5 96q0 51-26.5 94.5T560-320ZM400-606l-86 86H200v80h114l86 86v-252ZM300-480Z" />
        </svg>
		<div class="volume-bg">
			<div class="volume-fill" style="width: 70%"></div>
		</div>
	</div>
</footer>

<script>
    // 1. Khai báo biến trỏ tới các thẻ HTML
    const audio = document.getElementById("main-audio");
    
    // Phần hiển thị thông tin
    const playerTitle = document.getElementById("player-title");
    const playerArtist = document.getElementById("player-artist");
    const playerCover = document.getElementById("player-cover");
    
    // Phần nút Play/Pause
    const btnPlayPause = document.getElementById("btn-play-pause");
    const iconPlay = document.getElementById("icon-play");
    const iconPause = document.getElementById("icon-pause");
    
    // Phần thanh tiến độ
    const progressFill = document.getElementById("progress-fill");
    const progressArea = document.getElementById("progress-area");
    const timeCurrent = document.getElementById("current-time");
    const timeTotal = document.getElementById("total-duration");

    // Biến trạng thái
    let isPlaying = false;

    // --- HÀM 1: GỌI TỪ TRANG CHỦ KHI CLICK BÀI HÁT ---
    function loadAndPlay(title, artist, coverUrl, songUrl) {
        // Cập nhật text
        playerTitle.innerText = title;
        playerArtist.innerText = artist;
        
        // Cập nhật ảnh nền (Cover)
        playerCover.style.backgroundImage = "url('" + coverUrl + "')";

        // Nạp nguồn nhạc vào thẻ Audio ẩn
        audio.src = songUrl;
        
        // Chạy nhạc
        playSong();
    }

    // --- HÀM 2: LOGIC PLAY ---
    function playSong() {
        audio.play();
        isPlaying = true;
        // Ẩn icon Tam giác, Hiện icon 2 vạch
        iconPlay.style.display = "none";
        iconPause.style.display = "block";
    }

    // --- HÀM 3: LOGIC PAUSE ---
    function pauseSong() {
        audio.pause();
        isPlaying = false;
        // Hiện icon Tam giác, Ẩn icon 2 vạch
        iconPlay.style.display = "block";
        iconPause.style.display = "none";
    }

    // --- HÀM 4: SỰ KIỆN CLICK NÚT TRÒN ---
    btnPlayPause.addEventListener("click", () => {
        // Kiểm tra đường dẫn nhạc có trống không
        if (!audio.src) return; 

        if (isPlaying) {
            pauseSong();
        } else {
            playSong();
        }
    });

    // --- HÀM 5: CẬP NHẬT THANH THỜI GIAN (CHẠY LIÊN TỤC) ---
    audio.addEventListener("timeupdate", (e) => {
        const currentTime = e.target.currentTime; 
        const duration = e.target.duration;

        if (duration) {
            // Tính % chiều rộng thanh màu trắng
            let progressPercent = (currentTime / duration) * 100;
            progressFill.style.width = `${progressPercent}%`;

            // Cập nhật số phút:giây
            timeCurrent.innerText = formatTime(currentTime);
            timeTotal.innerText = formatTime(duration);
        }
    });

    // --- HÀM 6: TUA NHẠC KHI CLICK VÀO THANH ---
    function seekSong(e) {
        if (!audio.src) return; // Nếu chưa có bài hát thì không cho tua
        
        let width = progressArea.clientWidth; // Chiều dài thanh
        let clickX = e.offsetX;               // Vị trí click chuột
        let duration = audio.duration;        // Tổng thời gian
        
        // Gán thời gian hiện tại mới cho audio
        audio.currentTime = (clickX / width) * duration;
    }
    
    // --- HÀM PHỤ: ĐỊNH DẠNG SỐ GIÂY (VD: 125s -> 02:05) ---
    function formatTime(seconds) {
        let min = Math.floor(seconds / 60);
        let sec = Math.floor(seconds % 60);
        if (sec < 10) {
            sec = `0${sec}`;
        }
        return `${min}:${sec}`;
    }
    
    // Khi hát xong thì tự động chuyển về trạng thái Pause
    audio.addEventListener("ended", () => {
        isPlaying = false;
        iconPlay.style.display = "block";
        iconPause.style.display = "none";
        progressFill.style.width = "0%";
    });

</script>

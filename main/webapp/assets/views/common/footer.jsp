<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/style.css">

<audio id="main-audio" src=""></audio>
<footer class="player-footer">
	<div class="footer-left">
		<div id="player-cover" class="footer-img"
			style='background-image: url("${pageContext.request.contextPath}/assets/default.png");'></div>
		<div class="footer-track-info">
			<p id="player-title" class="track-name">ABhChưa chọn bài hát</p>
			<p id="player-artist" class="track-artist">...</p>
		</div>
		<button id="btn-like" class="btn-icon" title="Yêu thích">
			<svg xmlns="http://www.w3.org/2000/svg" height="24px"
				viewBox="0 -960 960 960" width="24px">
                <path
					d="m480-120-58-52q-101-91-167-157T150-447.5Q111-500 95.5-544T80-634q0-94 63-157t157-63q52 0 99 22t81 62q34-40 81-62t99-22q94 0 157 63t63 157q0 46-15.5 90T810-447.5Q771-395 705-329T538-172l-58 52Z" />
            </svg>
		</button>
	</div>

	<div class="footer-center">
		<div class="controls-row">
			<button id="btn-shuffle" class="btn-icon" title="Trộn bài">
				<svg xmlns="http://www.w3.org/2000/svg" height="24px"
					viewBox="0 -960 960 960" width="24px">
                    <path
						d="M560-160v-80h104L537-367l57-57 126 126v-102h80v240H560Zm-344 0-56-56 504-504H560v-80h240v240h-80v-104L216-160Zm151-377L160-744l56-56 207 207-56 56Z" />
                </svg>
			</button>
			<button id="btn-prev" class="btn-icon" title="Bài trước">
				<svg xmlns="http://www.w3.org/2000/svg" height="32"
					viewBox="0 96 960 960" width="32">
                    <path
						d="M220 776V376h80v400h-80Zm520 0-280-200 280-200v400Z" />
                </svg>
			</button>
			<button id="btn-play-pause" class="btn-play-main"
				title="Phát/Tạm dừng">
				<svg xmlns="http://www.w3.org/2000/svg" height="32"
					viewBox="0 96 960 960" width="32">
                    <path d="M320 853V293l440 280-440 280Z" />
                </svg>
			</button>
			<button id="btn-next" class="btn-icon" title="Bài tiếp theo">
				<svg xmlns="http://www.w3.org/2000/svg" height="32"
					viewBox="0 96 960 960" width="32">
                    <path
						d="M660 776V376h80v400h-80ZM220 776V376l280 200-280 200Z" />
                </svg>
			</button>
			<button id="btn-repeat" class="btn-icon" title="Lặp lại">
				<svg xmlns="http://www.w3.org/2000/svg" height="24px"
					viewBox="0 -960 960 960" width="24px">
                    <path
						d="M280-80 120-240l160-160 56 58-62 62h406v-160h80v240H274l62 62-56 58Zm-80-440v-240h486l-62-62 56-58 160 160-160 160-56-58 62-62H280v160h-80Z" />
                </svg>
			</button>
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
		<button id="btn-add-playlist" class="btn-icon"
			title="Thêm vào danh sách">
			<svg xmlns="http://www.w3.org/2000/svg" height="22"
				viewBox="0 -960 960 960" width="22">
                <path
					d="M120-320v-80h280v80H120Zm0-160v-80h440v80H120Zm0-160v-80h440v80H120Zm520 480v-160H480v-80h160v-160h80v160h160v80H720v160h-80Z" />
            </svg>
		</button>
		<button id="btn-lyrics" class="btn-icon" title="Lời bài hát">
			<svg xmlns="http://www.w3.org/2000/svg" height="22"
				viewBox="0 -960 960 960" width="22">
                <path
					d="M80-80v-720q0-33 23.5-56.5T160-880h440q33 0 56.5 23.5T680-800v17q-24 11-44 27t-36 36v-80H160v527l47-47h393v-160q16 20 36 36t44 27v97q0 33-23.5 56.5T600-240H240L80-80Zm160-320h160v-80H240v80Zm520-80q-50 0-85-35t-35-85q0-50 35-85t85-35q11 0 21 2t19 5v-207h160v80h-80v240q0 50-35 85t-85 35Zm-520-40h280v-80H240v80Zm0-120h280v-80H240v80Zm-80 320v-480 480Z" />
            </svg>
		</button>
		
		<div class="volume-container">
			<button id="btn-volume" class="btn-icon" title="Âm lượng">
				<svg xmlns="http://www.w3.org/2000/svg" height="22"
					viewBox="0 -960 960 960" width="22">
                    <path
						d="M560-131v-82q90-26 145-100t55-168q0-94-55-168T560-749v-82q124 28 202 125.5T840-481q0 127-78 224.5T560-131ZM120-360v-240h160l200-200v640L280-360H120Zm440 40v-322q47 22 73.5 66t26.5 96q0 51-26.5 94.5T560-320ZM400-606l-86 86H200v80h114l86 86v-252ZM300-480Z" />
                </svg>
			</button>
			<div class="volume-bg"
				style="width: 100px; height: 5px; background: #555; cursor: pointer; display: flex; align-items: center;">
				<div class="volume-fill"
					style="width: 70%; height: 100%; background: #fff;"></div>
			</div>
			

		</div>
	</div>
	
	
</footer>

<div id="loginWarningModal" class="modal-overlay"
	onclick="closeModal(event)">
	<div class="modal-box" onclick="event.stopPropagation()">

		<button class="btn-close-x"
			onclick="document.getElementById('loginWarningModal').style.display='none'">
			<svg width="24" height="24" viewBox="0 0 24 24" fill="none"
				stroke="currentColor" stroke-width="2">
                <path d="M18 6L6 18M6 6l12 12"></path>
            </svg>
		</button>

		<h3 class="modal-title">SoundWave</h3>
		<p class="modal-subtitle">Đăng nhập để trải nghiệm đầy đủ</p>

		<div class="modal-features">
			<div class="feature-item">
				<span class="feature-text">Lưu bài hát yêu thích</span>
			</div>
			<div class="feature-item">
				<span class="feature-text">Tạo playlist riêng</span>
			</div>
			
		</div>

		<button class="btn-login"
			onclick="window.location.href='${pageContext.request.contextPath}/login'">
			<span>Đăng Nhập Ngay</span>
			<svg width="20" height="20" viewBox="0 0 24 24" fill="none"
				stroke="currentColor" stroke-width="2">
                <path d="M5 12h14M12 5l7 7-7 7"></path>
            </svg>
		</button>
	</div>
</div>
<div id="addToPlaylistModal" class="modal-overlay" onclick="closeAddModal(event)">
    <div class="modal-box playlist-selector-box" onclick="event.stopPropagation()">
        <button class="btn-close-x" onclick="document.getElementById('addToPlaylistModal').style.display='none'">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M18 6L6 18M6 6l12 12"></path></svg>
        </button>
        
        <h3 class="modal-title" style="font-size: 24px;">Thêm vào Playlist</h3>
        <p class="modal-subtitle">Chọn danh sách phát bạn muốn thêm bài hát này vào</p>

        <div id="user-playlists-list" class="modal-features playlist-scroll-list">
            </div>
    </div>
</div>
<style>
.active-btn {
    color: #86B6F6 !important;
}

.active-btn svg {
    fill: #86B6F6 !important;
}
    /* CSS CHO OVERLAY */
    .lyrics-overlay {
        position: fixed;
        top: 0; left: 0;
        width: 100%; height: 100vh;
        background: linear-gradient(180deg, #1e3a5f 0%, #121212 100%);
        z-index: 100; 
        display: none; 
        flex-direction: column;
        animation: slideUp 0.3s ease-out;
        padding-bottom: 90px; /* Chừa chỗ cho thanh Player */
    }

    /* Hiệu ứng trượt lên */
    @keyframes slideUp {
        from { transform: translateY(100%); }
        to { transform: translateY(0); }
    }

    .overlay-header {
        padding: 20px;
        display: flex;
        align-items: center;
    }

    .btn-close-lyrics {
        background: none; border: none; color: white;
        font-size: 16px; cursor: pointer; display: flex; align-items: center; gap: 5px;
        padding: 10px 20px; border-radius: 20px; transition: 0.3s;
    }
    .btn-close-lyrics:hover { background: rgba(255,255,255,0.1); }

    .overlay-content {
        flex: 1;
        overflow-y: auto; /* Cuộn dọc */
        text-align: center;
        padding: 0 20px;
        /* Scroll đẹp */
        scrollbar-width: thin;
    }
    
    .overlay-cover {
        width: 200px; height: 200px; border-radius: 10px;
        object-fit: cover; margin-bottom: 20px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.5);
    }
    
    #overlay-title { font-size: 28px; color: white; margin-bottom: 5px; }
    #overlay-artist { font-size: 18px; color: #b3b3b3; margin-bottom: 30px; }

    .overlay-lyrics-box {
        color: #b3b3b3; font-size: 24px; line-height: 1.8;
        white-space: pre-wrap; /* Giữ xuống dòng */
        padding-bottom: 50px;
    }
    
    /* Responsive Mobile */
    @media (max-width: 768px) {
        .overlay-cover { width: 150px; height: 150px; }
        .overlay-lyrics-box { font-size: 18px; }
    }
 /* --- 1. LỚP PHỦ MỜ TOÀN MÀN HÌNH --- */ 
 .modal-overlay {
	display: none; /* Mặc định ẩn */
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.7); /* Màu đen mờ làm nền tối */
	z-index: 10000; /* Luôn nằm trên cùng */
	justify-content: center;
	align-items: center;
	animation: fadeIn 0.3s ease-out;
}

@
keyframes fadeIn {from { opacity:0;
	
}

to {
	opacity: 1;
}

}

/* Hỗ trợ display flex qua JS */
.modal-overlay[style*="display: flex"] {
	display: flex !important;
}

/* --- 2. KHUNG MODAL CHÍNH (CONTAINER) --- */
.modal-box {
	position: relative;
	/* Xóa nền màu cứng, để trong suốt chờ lớp giả (pseudo) hiển thị ảnh */
	background: none;
	padding: 60px 40px 50px 40px; /* Tăng padding top vì đã bỏ icon */
	border-radius: 24px;
	box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
	max-width: 420px;
	width: 90%;
	text-align: center;
	overflow: hidden; /* Cắt bỏ phần ảnh chuyển động bị thừa ra ngoài */
	/* Animation nảy lên khi xuất hiện */
	animation: slideUp 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
}

@
keyframes slideUp {from { opacity:0;
	transform: translateY(40px) scale(0.95);
}

to {
	opacity: 1;
	transform: translateY(0) scale(1);
}

}

/* --- 3. HIỆU ỨNG ẢNH NỀN CHUYỂN ĐỘNG (QUAN TRỌNG) --- */
.modal-box::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	z-index: -1;
	background: linear-gradient(to bottom, rgba(20, 20, 30, 0.6),
		rgba(0, 0, 0, 0.95)),
		url('${pageContext.request.contextPath}/assets/ima/av08.jpg');
	background-size: 120% auto;
	background-position: center;
	animation: moveBackgroundSlowly 20s ease-in-out infinite alternate;
}

/* Định nghĩa chuyển động Zoom và Pan */
@
keyframes moveBackgroundSlowly { 0% {
	transform: scale(1);
	background-position: center top;
}

50
%
{
transform
:
scale(
1.1
);
background-position
:
center
center;
}
100
%
{
transform
:
scale(
1
);
background-position
:
center
bottom;
}
}
.modal-title {
	color: #ffffff;
	font-size: 36px;
	font-weight: 800;
	margin: 0 0 10px 0;
	text-transform: uppercase;
	letter-spacing: 2px;
	text-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
}

.modal-subtitle {
	color: rgba(255, 255, 255, 0.8);
	font-size: 16px;
	margin: 0 0 30px 0;
	font-weight: 400;
}

.modal-features {
	background: rgba(255, 255, 255, 0.1);
	backdrop-filter: blur(5px);
	border-radius: 16px;
	padding: 20px;
	margin-bottom: 30px;
	border: 1px solid rgba(255, 255, 255, 0.1);
	text-align: left;
}

.feature-item {
	display: flex;
	align-items: center;
	gap: 15px;
	padding: 8px 0;
	color: white;
	font-size: 15px;
}

.feature-item:not(:last-child) {
	border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.btn-login {
	width: 50%;
	background: #86B6F6;
	color: #000;
	border: none;
	padding: 16px;
	border-radius: 50px;
	font-size: 16px;
	font-weight: 700;
	cursor: pointer;
	transition: transform 0.2s, background 0.2s;
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 8px;
	text-transform: uppercase;
}

.btn-login:hover {
	background: #abe0f9;
	transform: scale(1.03);
}

.btn-close-x {
	position: absolute;
	top: 20px;
	right: 20px;
	background: rgba(255, 255, 255, 0.1);
	border: none;
	width: 36px;
	height: 36px;
	border-radius: 50%;
	color: white;
	cursor: pointer;
	display: flex;
	align-items: center;
	justify-content: center;
	transition: background 0.2s;
	backdrop-filter: blur(4px);
}

.btn-close-x:hover {
	background: rgba(255, 255, 255, 0.3);
}
/* button trái tim */
#btn-like svg {
    fill: none;
    stroke: #ffffff;stroke-width: 2;
    transition: all 0.3s ease;
}
#btn-like.active svg {
    fill: #86B6F6 !important;
    stroke: #86B6F6 !important; 
    filter: drop-shadow(0 0 8px rgba(134, 182, 246, 0.6));
    transform: scale(1.1);
}

#btn-like:active {
    transform: scale(0.5);
}
.playlist-scroll-list {
    max-height: 300px;
    overflow-y: auto;
    padding: 10px;
    text-align: left;
}

.playlist-select-item {
    display: flex;
    align-items: center;
    gap: 15px;
    padding: 10px;
    margin-bottom: 8px;
    border-radius: 8px;
    cursor: pointer;
    transition: background 0.2s;
    background: rgba(255,255,255,0.05);
}

.playlist-select-item:hover {
    background: rgba(255,255,255,0.15);
}

.pl-select-img {
    width: 50px;
    height: 50px;
    border-radius: 4px;
    object-fit: cover;
}

.pl-select-name {
    color: white;
    font-weight: 600;
    font-size: 16px;
}
</style>
<script>
// Khai báo trạng thái đăng nhập toàn cục
window.isLoggedIn = ${not empty sessionScope.user ? "true" : "false"};

document.addEventListener('DOMContentLoaded', function() {
    const btnLike = document.getElementById('btn-like');

    if (btnLike) {
        btnLike.addEventListener('click', function() {
            if (!window.isLoggedIn) {
                showLoginWarning(); 
                return;
            }

            const songId = window.currentSongId;
            if (!songId) {
                alert("Vui lòng chọn một bài hát!");
                return;
            }

            // Gửi yêu cầu tới Servlet
            fetch('${pageContext.request.contextPath}/api/favorite', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'songId=' + songId
            })
            .then(response => response.text())
            .then(data => {
                const result = data.trim();
                if (result === "added") {
                    btnLike.classList.add('active');
                } else if (result === "removed") {
                    btnLike.classList.remove('active');
                }
            })
            .catch(err => console.error("Lỗi yêu thích:", err));
        });
    }
});

// HÀM QUAN TRỌNG: Kiểm tra xem bài hát mới load đã được Like chưa
function checkFavoriteStatus(songId) {
    if (!window.isLoggedIn || !songId) return;

    // Tận dụng chính Servlet api/favorite nhưng dùng phương thức GET (hoặc tạo API check riêng)
    // Ở đây ta giả sử Servlet của bạn xử lý kiểm tra nếu gọi GET
    fetch('${pageContext.request.contextPath}/api/favorite?check=true&songId=' + songId)
        .then(res => res.text())
        .then(status => {
            const btnLike = document.getElementById('btn-like');
            if (status.trim() === "liked") {
                btnLike.classList.add('active');
            } else {
                btnLike.classList.remove('active');
            }
        });
}

function showLoginWarning() {
    const modal = document.getElementById('loginWarningModal');
    if (modal) modal.style.display = 'flex';
}

function closeModal(event) {
    const modal = document.getElementById('loginWarningModal');
    if (event.target === modal) modal.style.display = 'none';
}
document.addEventListener('DOMContentLoaded', function() {
    const btnAddPlaylist = document.getElementById('btn-add-playlist');

    if (btnAddPlaylist) {
        btnAddPlaylist.addEventListener('click', function() {
            if (!window.isLoggedIn) {
                showLoginWarning();
                return;
            }

            const songId = window.currentSongId;
            if (!songId) {
                alert("Vui lòng phát một bài hát trước!");
                return;
            }

            // Mở modal và load danh sách playlist
            openAddSongToPlaylistModal();
        });
    }
});

function openAddSongToPlaylistModal() {
    const modal = document.getElementById('addToPlaylistModal');
    const container = document.getElementById('user-playlists-list');
    
    modal.style.display = 'flex';
    container.innerHTML = '<div style="text-align:center; padding:20px;">Đang tải danh sách...</div>';

    // Gọi đến Servlet vừa tạo ở trên
    fetch('${pageContext.request.contextPath}/api/user-playlists')
        .then(res => {
            if (!res.ok) throw new Error("Lỗi Server");
            return res.json();
        })
        .then(data => {
            container.innerHTML = ""; // Xóa dòng chữ đang tải

            if (data.length === 0) {
                container.innerHTML = '<div style="text-align:center; padding:20px; color:#b3b3b3;">Bạn chưa có playlist nào.</div>';
                return;
            }

            data.forEach(pl => {
                const item = document.createElement('div');
                item.className = 'playlist-select-item';
                // Sử dụng ảnh mặc định a08.jpg như bạn yêu cầu
                const imgSrc = '${pageContext.request.contextPath}/assets/ima/a08.jpg';
                
                item.innerHTML = `
                    <img src="${imgSrc}" class="pl-select-img">
                    <span class="pl-select-name">${pl.name}</span>
                `;
                
                item.onclick = function() {
                    addSongToSelectedPlaylist(window.currentSongId, pl.id);
                };
                container.appendChild(item);
            });
        })
        .catch(err => {
            console.error("Lỗi:", err);
            container.innerHTML = '<div style="text-align:center; padding:20px; color:red;">Không thể tải danh sách.</div>';
        });
}
function addSongToSelectedPlaylist(songId, playlistId) {
    fetch('${pageContext.request.contextPath}/api/add-to-playlist', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: 'songId=' + songId + '&playlistId=' + playlistId
    })
    .then(res => res.text())
    .then(data => {
        if (data.trim() === "success") {
            alert("Đã thêm vào danh sách phát!");
            document.getElementById('addToPlaylistModal').style.display = 'none';
        } else if (data.trim() === "exists") {
            alert("Bài hát đã có trong playlist này rồi.");
        } else {
            alert("Lỗi khi thêm vào playlist.");
        }
    });
}

function closeAddModal(event) {
    if (event.target.id === 'addToPlaylistModal') {
        document.getElementById('addToPlaylistModal').style.display = 'none';
    }
}
document.addEventListener('DOMContentLoaded', function() {
    const audio = document.getElementById('main-audio');
    const volumeBg = document.querySelector('.volume-bg');
    const volumeFill = document.querySelector('.volume-fill');
    const btnVolume = document.getElementById('btn-volume');

    // Thiết lập âm lượng mặc định (ví dụ 70%)
    audio.volume = 0.7;

    // Hàm cập nhật âm lượng
    function updateVolume(e) {
        const rect = volumeBg.getBoundingClientRect();
        const width = rect.width;
        const x = e.clientX - rect.left; // Vị trí click chuột so với lề trái của thanh volume
        
        let volumePercent = x / width;
        
        // Giới hạn trong khoảng [0, 1]
        if (volumePercent < 0) volumePercent = 0;
        if (volumePercent > 1) volumePercent = 1;

        // Cập nhật cho thẻ audio
        audio.volume = volumePercent;

        // Cập nhật giao diện thanh fill
        volumeFill.style.width = (volumePercent * 100) + '%';
        
        // Cập nhật icon nếu cần (ví dụ: mute nếu volume = 0)
        updateVolumeIcon(volumePercent);
    }

    // Sự kiện click vào thanh volume
    volumeBg.addEventListener('click', updateVolume);

    // (Tùy chọn) Kéo chuột để chỉnh âm lượng
    let isDraggingVolume = false;
    volumeBg.addEventListener('mousedown', () => isDraggingVolume = true);
    document.addEventListener('mousemove', (e) => {
        if (isDraggingVolume) updateVolume(e);
    });
    document.addEventListener('mouseup', () => isDraggingVolume = false);

    // Hàm thay đổi icon âm lượng theo mức độ
    function updateVolumeIcon(percent) {
        // Bạn có thể thay đổi path của SVG ở đây tùy theo mức percent
        if (percent === 0) {
            btnVolume.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" height="22" viewBox="0 -960 960 960" width="22"><path d="M792-56l-64-64-528-528-64-64 56-56 64 64 528 528 64 64-56 56Zm-152-232-58-58q17-22 26.5-47.5t9.5-52.5q0-75-43-134.5T460-664v-85q114 30 187 116.5T720-446q0 40-10.5 78.5T640-288ZM460-406v-150l-86-86H280v240h56l124 124v-112l-56-56Z"/></svg>';
        } else {
            // Trả về icon loa bình thường
            btnVolume.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" height="22" viewBox="0 -960 960 960" width="22"><path d="M560-131v-82q90-26 145-100t55-168q0-94-55-168T560-749v-82q124 28 202 125.5T840-481q0 127-78 224.5T560-131ZM120-360v-240h160l200-200v640L280-360H120Zm440 40v-322q47 22 73.5 66t26.5 96q0 51-26.5 94.5T560-320ZM400-606l-86 86H200v80h114l86 86v-252ZM300-480Z" /></svg>';
        }
    }

    // Click vào nút loa để Mute/Unmute
    let lastVolume = 0.7;
    btnVolume.addEventListener('click', function() {
        if (audio.volume > 0) {
            lastVolume = audio.volume;
            audio.volume = 0;
            volumeFill.style.width = '0%';
        } else {
            audio.volume = lastVolume;
            volumeFill.style.width = (lastVolume * 100) + '%';
        }
        updateVolumeIcon(audio.volume);
    });
});
</script>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/style.css">

<div class="sidebar" id="library-sidebar">
	<div class="sidebar-header">
		<div class="header-left" onclick="toggleSidebar()"
			title="Thu gọn / Mở rộng">
			<svg class="library-icon" xmlns="http://www.w3.org/2000/svg"
				height="24px" viewBox="0 -960 960 960" width="24px" fill="#e3e3e3">
                <path
					d="M500-360q42 0 71-29t29-71v-220h120v-80H560v220q-13-10-28-15t-32-5q-42 0-71 29t-29 71q0 42 29 71t71 29ZM320-240q-33 0-56.5-23.5T240-320v-480q0-33 23.5-56.5T320-880h480q33 0 56.5 23.5T880-800v480q0 33-23.5 56.5T800-240H320Zm0-80h480v-480H320v480ZM160-80q-33 0-56.5-23.5T80-160v-560h80v560h560v80H160Zm160-720v480-480Z" />
            </svg>
			<span class="header-title">Thư viện của bạn</span>
		</div>
	</div>

	<div class="library-list">
		<div class="list-item" onclick="handleCheckLikedSongsAction()">
			<div class="img-box liked-songs">
				<img src="${pageContext.request.contextPath}/assets/ima/flist2.jpg"
					alt="Liked" onerror="this.style.display='none'"> <i
					class="fa-solid fa-heart" style="margin: auto; display: none;"></i>
			</div>
			<div class="text-info">
				<div class="main-title highlight">Bài hát đã thích</div>
				<div class="sub-title">
					<i class="fa-solid fa-thumbtack"></i> Danh sách phát
				</div>
			</div>
		</div>

		<div class="list-item" onclick="handleCheckLoginAction()">

			<div class="img-box your-playlist">
				<img src="${pageContext.request.contextPath}/assets/ima/av2.jpg"
					alt="Liked" onerror="this.style.display='none'"> <i
					class="fa-solid fa-heart" style="margin: auto; display: none;"></i>

			</div>
			<div class="text-info">
				<div class="main-title">Danh sách của bạn</div>
				<div class="sub-title">Thư viện cá nhân</div>
			</div>
		</div>

		<hr class="list-divider">

		<div class="sidebar-bottom-action" onclick="openCreatePlaylistModal()"
			style="cursor: pointer;">
			<div class="create-playlist-link">
				<svg class="playlist-action-svg" xmlns="http://www.w3.org/2000/svg"
					height="40px" viewBox="0 -960 960 960" width="40px" fill="#72ceff">
                    <path
						d="M412-74v-338H74v-136h338v-338h136v338h338v136H548v338H412Z" />
                </svg>
				<span class="btn-text">Tạo Playlist mới</span>
			</div>
		</div>

		<button id="toggleArrowBtn" class="toggle-arrow-btn"
			onclick="toggleSidebar()" title="Thu gọn / Mở rộng">
			<svg class="arrow-icon" viewBox="0 0 24 24" width="24" height="24">
                <path
					d="M15.41 16.59L10.83 12L15.41 7.41L14 6L8 12L14 18L15.41 16.59Z"
					fill="#b3b3b3"></path>
            </svg>
		</button>

	</div>
</div>

<div id="createPlaylistModal" class="modal-overlay">
	<div class="modal-container">
		<div class="modal-header">
			<h2>Tạo danh sách phát</h2>
			<button class="btn-close-modal" onclick="closeCreatePlaylistModal()">
				<span class="material-symbols-outlined"><svg
						xmlns="http://www.w3.org/2000/svg" height="24px"
						viewBox="0 -960 960 960" width="24px" fill="#e3e3e3">
						<path
							d="m256-200-56-56 224-224-224-224 56-56 224 224 224-224 56 56-224 224 224 224-56 56-224-224-224 224Z" /></svg></span>
			</button>
		</div>

		<form action="create-playlist" method="post"
			enctype="multipart/form-data" class="modal-body">

			<div class="modal-left">
				<div class="image-upload-box"
					onclick="document.getElementById('playlistImageInput').click()">
					<img id="playlistPreview"
						src="${pageContext.request.contextPath}/assets/image/default_playlist.png"
						onerror="this.src='https://via.placeholder.com/180/282828/b3b3b3?text=Music'"
						alt="Preview">
					<div class="upload-overlay">
						<span class="material-symbols-outlined">edit</span> <span>Chọn
							ảnh</span>
					</div>
					<input type="file" name="coverImage" id="playlistImageInput"
						accept="image/*" style="display: none;"
						onchange="previewImage(this)">
				</div>
			</div>

			<div class="modal-right">
				<div class="form-group">
					<input type="text" name="playlistName" class="modal-input-title"
						placeholder="Tên danh sách phát" required autocomplete="off">
				</div>

			</div>

			<div class="modal-footer">
				<button type="submit" class="btn-save-playlist">Lưu</button>
			</div>
		</form>
	</div>
</div>

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
<style>
<
style> /* --- 1. LỚP PHỦ MỜ TOÀN MÀN HÌNH --- */ .modal-overlay {
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
</style>

<script>
    /* --- BƯỚC 1: LẤY TRẠNG THÁI ĐĂNG NHẬP TỪ SESSION --- */
    const isLoggedIn = ${not empty sessionScope.user};

    /* --- BƯỚC 2: CÁC HÀM XỬ LÝ SỰ KIỆN --- */

    // 1. Xử lý khi bấm vào "Bài hát đã thích"
    function handleCheckLikedSongsAction() {
        console.log("Hành động: Xem bài hát đã thích. Đăng nhập:", isLoggedIn);
        if (isLoggedIn) {
            // Chuyển đến Servlet đã có: LikedSongsServlet (@WebServlet("/liked_songs"))
            window.location.href = '${pageContext.request.contextPath}/liked_songs';
        } else {
            showLoginWarning();
        }
    }

    // 2. Xử lý khi bấm vào "Danh sách của bạn"
    function handleCheckLoginAction() {
        console.log("Hành động: Xem thư viện. Đăng nhập:", isLoggedIn);
        if (isLoggedIn) {
            // Chuyển đến Servlet đã có: LibraryServlet (@WebServlet("/your_episodes"))
            window.location.href = '${pageContext.request.contextPath}/my-library';
        } else {
            showLoginWarning();
        }
    }

    // 3. Xử lý khi bấm "Tạo Playlist mới"
    function openCreatePlaylistModal() {
        if (isLoggedIn) {
            const modal = document.getElementById('createPlaylistModal');
            if(modal) modal.style.display = 'flex';
        } else {
            showLoginWarning();
        }
    }

    // 4. Hàm hiển thị bảng thông báo đăng nhập
    function showLoginWarning() {
        const modal = document.getElementById('loginWarningModal');
        if (modal) {
            modal.style.display = 'flex';
        } else {
            console.error("Lỗi: Không tìm thấy ID 'loginWarningModal' trong HTML");
        }
    }

    /* --- CÁC HÀM BỔ TRỢ --- */

    function closeCreatePlaylistModal() {
        document.getElementById('createPlaylistModal').style.display = 'none';
    }

    function previewImage(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById('playlistPreview').src = e.target.result;
            }
            reader.readAsDataURL(input.files[0]);
        }
    }

    // Đóng modal khi click ra ngoài vùng box
    window.addEventListener('click', function(event) {
        const createModal = document.getElementById('createPlaylistModal');
        const loginModal = document.getElementById('loginWarningModal');
        
        if (event.target === createModal) {
            createModal.style.display = 'none';
        }
        if (event.target === loginModal) {
            loginModal.style.display = 'none';
        }
    });
</script>
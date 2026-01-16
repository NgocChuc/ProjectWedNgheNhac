<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/style.css">

<header class="headerA">
	<div class="headerA-left-logo">
		<a href="${pageContext.request.contextPath}/home" class="logo-link">
			<span class="site-logo-text">SoundWave</span>
		</a>
	</div>

	<div class="headerA-center">
		<%-- 2 mui ten tien lui --%>
		<div class="header-navigation">
			<button class="nav-btn" onclick="window.history.back()"
				title="Quay lại">
				<svg xmlns="http://www.w3.org/2000/svg" height="24px"
					viewBox="0 -960 960 960" width="24px" fill="#e3e3e3">
					<path d="M400-80 0-480l400-400 71 71-329 329 329 329-71 71Z" /></svg>
			</button>
			<button class="nav-btn" onclick="window.history.forward()"
				title="Tiếp theo">
				<svg xmlns="http://www.w3.org/2000/svg" height="24px"
					viewBox="0 -960 960 960" width="24px" fill="#e3e3e3">
					<path d="m321-80-71-71 329-329-329-329 71-71 400 400L321-80Z" /></svg>
			</button>
		</div>
		<%-- thanh tim kiem --%>
		<div class="search-wrapper" style="position: relative;">

			<form class="search-headerA" action="#" onsubmit="return false;">
				<input id="inputSrchH" class="input-search-header" name="query"
					placeholder="Tìm kiếm bài hát, nghệ sĩ,..." autocomplete="off"
					oninput="handleSearch(this.value)" />

				<button class="input-sreach-headerA_btn" type="button">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"
						width="22" height="22">
                    <path
							d="M18.031 16.6168L22.3137 20.8995L20.8995 22.3137L16.6168 18.031C15.0769 19.263 13.124 20 11 20C6.032 20 2 15.968 2 11C2 6.032 6.032 2 11 2C15.968 2 20 6.032 20 11C20 13.124 19.263 15.0769 18.031 16.6168ZM16.0247 15.8748C17.2475 14.6146 18 12.8956 18 11C18 7.1325 14.8675 4 11 4C7.1325 4 4 7.1325 4 11C4 14.8675 7.1325 18 11 18C12.8956 18 14.6146 17.2475 15.8748 16.0247L16.0247 15.8748Z"
							fill="#efeff1"></path>
                </svg>
				</button>
			</form>

			<div id="search-dropdown" class="search-dropdown-result"></div>

		</div>
	</div>

	<div class="headerA-right">

		<%--Chưa Đăng Nhập--%>
		<c:if test="${empty sessionScope.user}">
			<div class="auth-buttons">
				<a
					href="${pageContext.request.contextPath}/assets/views/auth/login.jsp"
					class="btn-login-header"> Đăng Nhập </a>
			</div>
		</c:if>


		<%--Đã Đăng Nhập--%>
		<c:if test="${not empty sessionScope.user}">
			<div class="headerA-right-notifications">
				<button id="notificationBtn"
					class="headerA-right-button-notifications">
					<svg viewBox="0 0 448 512" class="bell-noti">
                    <path
							d="M224 0c-17.7 0-32 14.3-32 32V49.9C119.5 61.4 64 124.2 64 200v33.4c0 45.4-15.5 89.5-43.8 124.9L5.3 377c-5.8 7.2-6.9 17.1-2.9 25.4S14.8 416 24 416H424c9.2 0 17.6-5.3 21.6-13.6s2.9-18.2-2.9-25.4l-14.9-18.6C399.5 322.9 384 278.8 384 233.4V200c0-75.8-55.5-138.6-128-150.1V32c0-17.7-14.3-32-32-32zm0 96h8c57.4 0 104 46.6 104 104v33.4c0 47.9 13.9 94.6 39.7 134.6H72.3C98.1 328 112 281.3 112 233.4V200c0-57.4 46.6-104 104-104h8zm64 352H224 160c0 17 6.7 33.3 18.7 45.3s28.3 18.7 45.3 18.7s33.3-6.7 45.3-18.7s18.7-28.3 18.7-45.3z"></path>
                </svg>
				</button>
				<div id="notificationsDropdown" class="notifications-dropdown">
					<div class="notifications-header">
						<h3 class="notifications-title">Có gì mới!!!</h3>
					</div>
					<div class="notifications-content">
						<p class="notifications-empty-message">
							Chưa có thông báo mới.<br> Hãy Theo dõi 1 nghệ sĩ yêu thích!
						</p>
					</div>
				</div>
			</div>

			<%-- avt --%>
			<div class="header-right-icon avatar">
				<a href="javascript:void(0)" class="useraccount-btn"
					id="avatarToggleButton"> <c:choose>
						<c:when test="${not empty sessionScope.user.avatarUrl}">
							<img src="${sessionScope.user.avatarUrl}" alt="Avatar"
								class="header-avatar-img">
						</c:when>
						<c:otherwise>
							<img src="${pageContext.request.contextPath}/assets/img/avt2.jpg"
								alt="Default Avatar" class="header-avatar-img">
						</c:otherwise>
					</c:choose>
				</a>

				<div id="userDropdown" class="user-dropdown-menu">
					<ul class="user-menu-list">
						<li class="user-menu-item"><a
							href="${pageContext.request.contextPath}/profile"
							class="menu-link">Hồ sơ</a></li>
						<li class="user-menu-item"><a
							href="${pageContext.request.contextPath}/setting"
							class="menu-link">Cài đặt</a></li>
						<li class="user-menu-item divider"></li>
						<li class="user-menu-item"><a
							href="${pageContext.request.contextPath}/logout"
							class="menu-link" style="color: #ff5e5e;">Đăng xuất</a></li>
					</ul>
				</div>
			</div>
		</c:if>
	</div>


</header>
<style>
/* --- USER DROPDOWN CSS --- */

/* Định vị container cha để dropdown con bám theo */
.header-right-icon.avatar {
	position: relative;
	display: flex;
	align-items: center;
}

/* Ảnh Avatar tròn */
.header-avatar-img {
	width: 40px;
	height: 40px;
	border-radius: 50%;
	object-fit: cover;
	cursor: pointer;
	border: 2px solid transparent;
	transition: 0.2s;
}

.header-avatar-img:hover {
	border-color: #878787; /* Viền xám khi hover avatar */
}

/* Khung Dropdown (Mặc định ẩn) */
.user-dropdown-menu {
	display: none; /* Ẩn */
	position: absolute;
	top: 50px; /* Cách top 50px */
	right: 0; /* Căn phải thẳng hàng với avatar */
	background-color: #282828; /* Màu nền xám đậm */
	min-width: 180px;
	border-radius: 4px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.5); /* Bóng đổ */
	padding: 4px;
	z-index: 10000;
}

/* Class này sẽ được JS thêm vào để hiện menu */
.user-dropdown-menu.show {
	display: block;
	animation: fadeIn 0.2s ease-out;
}

/* Danh sách menu */
.user-menu-list {
	list-style: none;
	padding: 0;
	margin: 0;
}

/* Link trong menu */
.menu-link {
	display: block;
	padding: 10px 12px;
	color: #e0e0e0; /* Màu chữ trắng xám */
	text-decoration: none;
	font-size: 14px;
	font-weight: 500;
	border-radius: 2px;
	transition: background-color 0.2s;
	font-family: 'Inter', sans-serif;
}

/* Hiệu ứng hover từng dòng */
.user-menu-item:hover .menu-link {
	background-color: #3e3e3e; /* Sáng hơn chút khi hover */
	color: #ffffff;
}

/* Đường kẻ phân cách */
.user-menu-item.divider {
	height: 1px;
	background-color: #404040;
	margin: 4px 0;
}

/* Hiệu ứng xuất hiện */
@
keyframes fadeIn {from { opacity:0;
	transform: translateY(-10px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
.auth-buttons {
	display: flex;
	justify-content: flex-end;
}

.btn-login-header {
	text-decoration: none;
	padding: 10px 22px;
	border-radius: 30px;
	background-color: #fff; /* sửa chính tả */
	color: #000;
	font-weight: 600;
	font-size: 14px;
	transition: all 0.3s ease;
}

.btn-login-header:hover {
	transform: scale(1.05);
	box-shadow: 0 6px 15px rgba(90, 157, 254, 0.4);
}

/*style cho tìm kiếm*/
/* Container bao ngoài */
.search-wrapper {
	position: relative;
	width: 100%;
	max-width: 400px; /* Điều chỉnh tùy giao diện bạn */
}

/* Bảng kết quả đổ xuống */
.search-dropdown-result {
	position: absolute;
	top: 100%; /* Nằm ngay dưới ô input */
	left: 0;
	width: 100%;
	background-color: #282828; /* Màu nền tối */
	border-radius: 0 0 8px 8px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.5);
	z-index: 1000; /* Đè lên các thành phần khác */
	display: none; /* Mặc định ẩn */
	max-height: 400px;
	overflow-y: auto; /* Cho phép cuộn */
	border: 1px solid #333;
	border-top: none;
}

/* Từng dòng kết quả */
.s-result-item {
	display: flex;
	align-items: center;
	padding: 10px;
	cursor: pointer;
	border-bottom: 1px solid #333;
	transition: background 0.2s;
}

.s-result-item:hover {
	background-color: #3e3e3e;
}

.s-img {
	width: 40px;
	height: 40px;
	border-radius: 4px;
	object-fit: cover;
	margin-right: 12px;
}

.s-info {
	display: flex;
	flex-direction: column;
}

.s-title {
	color: white;
	font-weight: 500;
	font-size: 14px;
}

.s-artist {
	color: #b3b3b3;
	font-size: 12px;
}

/* Loại kết quả (Label Nghệ sĩ / Bài hát) */
.s-type-label {
	font-size: 10px;
	padding: 2px 6px;
	border-radius: 4px;
	margin-left: auto; /* Đẩy sang phải cùng */
	background: #333;
	color: #ccc;
}
</style>

<script>
    /* --- CẤU HÌNH --- */
    // Lấy đường dẫn gốc của dự án (Ví dụ: /MusicApp)
    const CONTEXT_PATH = '${pageContext.request.contextPath}';

    /* ===  SỰ KIỆN TÌM KIẾM === */
    let searchTimeout = null;

    function handleSearch(keyword) {
        const dropdown = document.getElementById("search-dropdown");
        
        // Nếu ô tìm kiếm rỗng thì ẩn bảng
        if (!keyword || keyword.trim() === "") {
            dropdown.style.display = "none";
            dropdown.innerHTML = "";
            return;
        }

        // Debounce: Chờ 300ms sau khi ngừng gõ mới gọi API
        clearTimeout(searchTimeout);
        searchTimeout = setTimeout(() => {
            fetchSearchResults(keyword);
        }, 300);
    }

    function fetchSearchResults(keyword) {
        // API Servlet
        fetch(CONTEXT_PATH + '/api/search?term=' + encodeURIComponent(keyword))
            .then(response => response.json())
            .then(data => {
                renderDropdown(data);
            })
            .catch(err => console.error("Lỗi tìm kiếm:", err));
    }

    function renderDropdown(songs) {
        const dropdown = document.getElementById("search-dropdown");
        dropdown.innerHTML = "";

        if (!songs || songs.length === 0) {
            dropdown.style.display = "block";
            dropdown.innerHTML = '<div style="padding:15px; color:#b3b3b3; text-align:center">Không tìm thấy kết quả</div>';
            return;
        }

        let html = "";
        songs.forEach(function(s) {
            // Chuẩn bị đường dẫn
            var imgPath = CONTEXT_PATH + '/assets/' + (s.coverImage ? s.coverImage : 'default.png');
            var audioPath = CONTEXT_PATH + '/assets/' + s.filename;

            // Xử lý dấu nháy đơn để tránh lỗi chuỗi
            var safeTitle = s.title.replace(/'/g, "\\'");
            var safeArtist = s.artist.replace(/'/g, "\\'");
            var safeLyrics = s.lyrics ? s.lyrics.replace(/'/g, "\\'").replace(/\n/g, "\\n") : "";
            
            // Sử dụng cộng chuỗi thay vì dấu `` để tránh lỗi JSP EL
            html += '<div class="s-result-item" onclick="playAudioSearch(\'' + s.id + '\', \'' + safeTitle + '\', \'' + safeArtist + '\', \'' + imgPath + '\', \'' + audioPath + '\')">' +
                        '<img src="' + imgPath + '" class="s-img" onerror="this.src=\'' + CONTEXT_PATH + '/assets/default.png\'">' +
                        '<div class="s-info">' +
                            '<span class="s-title">' + s.title + '</span>' +
                            '<span class="s-artist">Nghệ sĩ: ' + s.artist + '</span>' +
                        '</div>' +
                    '</div>';
        });

        dropdown.innerHTML = html;
        dropdown.style.display = "block";
    }

    /* === PHẦN 2: TRUYỀN DỮ LIỆU XUỐNG PLAYER FOOTER === */
    function playAudioSearch(id, filename, title, artist, coverName) {
        // 1. Ẩn bảng kết quả tìm kiếm sau khi chọn
        document.getElementById("search-dropdown").style.display = "none";

        // 2. Lấy các thẻ HTML dưới Footer (Dựa vào ID trong code footer.jsp bạn gửi)
        const audioPlayer = document.getElementById("main-audio"); 
        const pTitle = document.getElementById("player-title");    
        const pArtist = document.getElementById("player-artist");  
        const pCover = document.getElementById("player-cover");    
        const btnPlay = document.getElementById("btn-play-pause"); // Nút play/pause

        if(audioPlayer) {
            // --- Cập nhật nguồn nhạc ---
            // Nối đường dẫn: /MusicApp/assets/audio/ten_bai_hat.mp3
            audioPlayer.src = CONTEXT_PATH + "/assets/" + filename;

            // --- Cập nhật thông tin ---
            if(pTitle) pTitle.innerText = title;
            if(pArtist) pArtist.innerText = artist;

            // --- Cập nhật ảnh bìa Footer ---
            // Vì footer dùng background-image nên ta set style
            if(pCover) {
                let coverPath = CONTEXT_PATH + "/assets/" + (coverName ? coverName : "default.png");
                pCover.style.backgroundImage = "url('" + coverPath + "')";
            }
            if (typeof playAudio === "function") {
                playAudio(id, filename, title, artist, coverName);
            }
            
            // --- Phát nhạc ---
            audioPlayer.play().then(() => {
                // Đổi icon nút Play thành Pause (Nếu bạn có logic đổi icon)
                // Đoạn SVG icon Pause
                if(btnPlay) btnPlay.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" height="32" viewBox="0 96 960 960" width="32"><path d="M560 736H680V416H560V736ZM280 736H400V416H280V736Z"/></svg>';
            }).catch(e => console.error("Lỗi phát nhạc:", e));

        } else {
            console.error("Không tìm thấy Footer Player (ID: main-audio)");
        }
    }

    /* === PHẦN 3: XỬ LÝ CLICK RA NGOÀI ĐỂ ĐÓNG BẢNG === */
    document.addEventListener('click', function(e) {
        const wrapper = document.querySelector('.search-wrapper');
        const dropdown = document.getElementById('search-dropdown');
        if (dropdown && wrapper && !wrapper.contains(e.target)) {
            dropdown.style.display = 'none';
        }
    });
    
    /* === PHẦN 4: LOGIC USER DROPDOWN === */
    document.addEventListener('DOMContentLoaded', function() {
        const avatarBtn = document.getElementById('avatarClickZone');
        const userDropdown = document.getElementById('userDropdown');

        if (avatarBtn && userDropdown) {
            // Khi click vào Avatar
            avatarBtn.addEventListener('click', function(e) {
                e.preventDefault();
                e.stopPropagation(); // Ngăn sự kiện nổi bọt lên document
                userDropdown.classList.toggle('show');
            });

            // Khi click ra ngoài menu hoặc avatar thì đóng menu
            document.addEventListener('click', function(e) {
                if (!userDropdown.contains(e.target) && !avatarBtn.contains(e.target)) {
                    userDropdown.classList.remove('show');
                }
            });
        }
    });
</script>
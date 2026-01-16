<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Bài Hát Yêu Thích - SOUNDWAVE</title>

<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700;900&display=swap"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap"
	rel="stylesheet" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/style.css">

<style>
/* --- CSS RIÊNG CHO TRANG LIKED SONGS --- */
/* --- CSS TỔNG HỢP: TRANG BÀI HÁT YÊU THÍCH --- */
:root {
	--bg-dark: #121212;
	--primary-color: #5ae9ff;
	--text-white: #ffffff;
	--border-color: rgba(255, 255, 255, 0.1);
}

/* 1. Bố cục chung */
.app-wrapper-liked {
	display: flex;
	flex-direction: column;
	min-height: 100%;
	position: relative;
}

.playlist-header-liked {
	padding: 60px 30px 30px;
	display: flex;
	align-items: flex-end;
	gap: 30px;
	background: transparent;
}

.liked-songs-cover {
	width: 232px;
	height: 232px;
	border-radius: 4px;
	background: linear-gradient(135deg, #450af5, #c4efd9);
	display: flex;
	justify-content: center;
	align-items: center;
	box-shadow: 0 8px 40px rgba(0, 0, 0, 0.5);
}

.cover-image-liked {
	width: 100%;
	height: 100%;
	object-fit: cover;
	border-radius: 4px;
}

.header-info h1 {
	font-size: 4.5rem;
	font-weight: 900;
	margin: 10px 0;
	line-height: 1;
	color: #fff;
}

/* 2. Cấu trúc bảng bài hát */
.song-table {
	width: 100%;
	border-collapse: separate;
	border-spacing: 0;
	margin-top: 20px;
}

.song-table th {
	text-align: left;
	padding: 12px 15px;
	color: #b3b3b3;
	border-bottom: 1px solid rgba(255, 255, 255, 0.1);
	font-size: 0.8rem;
	font-weight: 500;
	text-transform: uppercase;
}

/* 3. HIỆU ỨNG SÁNG RỰC NGUYÊN DÒNG KHI HOVER (QUAN TRỌNG) */
.song-row {
	transition: all 0.2s ease;
	cursor: pointer;
	position: relative;
}

.song-row:hover {
	/* Làm sáng nền dòng bài hát */
	background-color: rgba(255, 255, 255, 0.1) !important;
	/* Bí quyết làm sáng rực toàn bộ nội dung (chữ, ảnh, icon) */
	filter: brightness(1.3);
	/* Đổ bóng lan tỏa nhẹ để tạo hiệu ứng phát sáng (glow) */
	box-shadow: 0 0 15px rgba(255, 255, 255, 0.05);
}

.song-row td {
	padding: 12px 15px;
	vertical-align: middle;
	color: #fff;
}

/* Bo góc tinh tế cho dòng khi hover */
.song-row:hover td:first-child {
	border-top-left-radius: 8px;
	border-bottom-left-radius: 8px;
}

.song-row:hover td:last-child {
	border-top-right-radius: 8px;
	border-bottom-right-radius: 8px;
}

/* 4. Chi tiết bên trong dòng */
.song-info-wrapper {
	display: flex;
	align-items: center;
	gap: 15px;
}

.song-thumb-small {
	width: 40px;
	height: 40px;
	border-radius: 4px;
	object-fit: cover;
}

.song-title {
	font-weight: 600;
	font-size: 1rem;
	color: #fff;
}

.song-artist {
	color: #b3b3b3;
	font-size: 0.85rem;
	transition: color 0.2s;
}

.song-row:hover .song-artist {
	color: #fff; /* Tên nghệ sĩ cũng sáng lên khi hover */
}

/* 5. Nút More và Menu hành động */
.btn-more {
	background: transparent;
	border: none;
	color: #b3b3b3;
	cursor: pointer;
	padding: 8px;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	opacity: 0; /* Ẩn mặc định */
	transition: all 0.2s;
}

.song-row:hover .btn-more {
	opacity: 1; /* Hiện khi hover vào dòng */
}

.btn-more:hover {
	color: #fff;
	background-color: rgba(255, 255, 255, 0.1);
}

.col-action {
	position: relative; /* Làm gốc tọa độ cho .action-menu */
}

.action-menu {
	display: none;
	position: absolute;
	top: 50%;
	right: 45px; /* Hiển thị bên trái nút 3 chấm */
	transform: translateY(-50%);
	background: #282828;
	border: 1px solid rgba(255, 255, 255, 0.1);
	border-radius: 4px;
	padding: 4px;
	z-index: 1000;
	min-width: 190px;
	box-shadow: 0 16px 24px rgba(0, 0, 0, 0.4);
}

.action-menu.show {
	display: block;
	animation: fadeInMenu 0.2s ease-out;
}

@
keyframes fadeInMenu {from { opacity:0;
	transform: translateY(-50%) scale(0.95);
}

to {
	opacity: 1;
	transform: translateY(-50%) scale(1);
}

}
.action-item {
	padding: 12px 16px;
	display: flex;
	align-items: center;
	gap: 12px;
	color: #eaeaea;
	font-size: 0.85rem;
	cursor: pointer;
	border-radius: 2px;
}

.action-item:hover {
	background: rgba(255, 255, 255, 0.1);
}

.action-item span {
	font-size: 20px;
	color: #b3b3b3;
}
/* 6. Trạng thái bài đang phát (Active) */
.song-row.active-row .song-title {
	color: var(--primary-color);
}

.song-row.active-row .col-index {
	color: var(--primary-color);
}

.play-button-liked {
	width: 56px;
	height: 56px;
	border-radius: 50%;
	background-color: #86B6F6; /* Màu chủ đạo bạn chọn */
	border: none;
	display: flex;
	justify-content: center;
	align-items: center;
	cursor: pointer;
	transition: all 0.3s ease;
	box-shadow: 0 8px 15px rgba(0, 0, 0, 0.3); /* Tạo độ nổi */
	margin-right: 10px;
}

/* Icon bên trong nút */
.play-button-liked .material-symbols-outlined {
	color: #000000; /* Màu đen để tương phản tốt trên nền xanh */
	font-size: 32px;
	font-variation-settings: 'FILL' 1, 'wght' 400, 'GRAD' 0, 'opsz' 48;
}
/* Hiệu ứng khi nhấn vào (Active) */
.play-button-liked:active {
	transform: scale(0.95); /* Nhấn lún xuống */
}

/* Tùy chỉnh thanh điều khiển chứa nút */
.controls-bar-liked {
	display: flex;
	align-items: center;
	gap: 24px;
	padding: 20px 30px;
}
</style>
</head>

<body>
	<jsp:include page="/assets/views/common/header.jsp" />

	<div class="main-content-wrapper layout-with-sidebar">

		<jsp:include page="/assets/views/common/sidebar.jsp" />

		<div class="main-content"
			style="background: linear-gradient(360deg, rgba(18, 18, 18, 1) 0%, rgba(31, 21, 56, 1) 50%, rgba(69, 42, 165, 1) 100%) !important; padding: 0 !important; overflow: hidden; position: relative;">

			<div id="main-view-container" style="height: 100%; overflow-y: auto;">

				<div class="app-wrapper-liked">

					<div class="playlist-header-liked">
						<div class="liked-songs-cover">
							<img class="cover-image-liked"
								src="${pageContext.request.contextPath}/assets/ima/flist2.jpg"
								alt="Cover">
						</div>
						<div class="header-info">
							<p class="playlist-type-liked">Playlist</p>
							<h1 class="playlist-title-liked">Bài Hát Yêu Thích</h1>
							<div class="playlist-metadata-liked">
								<span class="metadata-user-liked">${sessionScope.user != null ? sessionScope.user.userName : 'Bạn'}</span>
								• <span class="metadata-count-liked">${likedSongs.size()}
									bài hát</span>
							</div>
						</div>
					</div>

					<div class="list-content-wrapper">

						<div class="controls-bar-liked">
							<button class="play-button-liked" onclick="playAllLikedSongs()">
								<span class="material-symbols-outlined">play_arrow</span>
							</button>
						</div>

						<div class="song-list-table-container-liked">
							<table class="song-table">
								<thead>
									<tr>
										<th style="width: 50px">#</th>
										<th>Tiêu đề</th>
										<th>Nghệ sĩ</th>
										<th style="text-align: right; width: 100px;"><span
											class="material-symbols-outlined">schedule</span></th>
										<th style="width: 50px"></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${likedSongs}" var="s" varStatus="loop">
										<tr class="song-row"
											onclick="loadAndPlay('${s.id}', '${s.title}', '${s.artist}', '${pageContext.request.contextPath}/assets/${s.coverImage}', '${pageContext.request.contextPath}/assets/${s.filename}')">

											<td class="col-index">${loop.index + 1}</td>

											<td>
												<div class="song-info-wrapper">
													<%-- Thẻ chứa lời ẩn --%>
													<textarea id="lyrics-data-${s.id}" style="display: none;">${s.lyrics}</textarea>

													<img
														src="${pageContext.request.contextPath}/assets/${s.coverImage}"
														class="song-thumb-small"
														onerror="this.src='${pageContext.request.contextPath}/assets/default.png'">
													<div class="song-title">${s.title}</div>
												</div>
											</td>

											<td><div class="song-artist">${s.artist}</div></td>

											<td style="text-align: right; color: #b3b3b3;">--:--</td>

											<td class="col-action">
												<button id="btn-more-${loop.index}" class="btn-more"
													onclick="toggleMenu(event, 'menu-${loop.index}', 'btn-more-${loop.index}')">
													<span class="material-symbols-outlined">more_horiz</span>
												</button>

												<div id="menu-${loop.index}" class="action-menu">
													<div class="action-item"
														onclick="removeFromFavorite(event, '${s.id}')">
														<span class="material-symbols-outlined">heart_minus</span>
														Xóa khỏi yêu thích
													</div>
												</div>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>

				<div style="height: 100px;"></div>

			</div>
			<jsp:include page="/assets/views/main/lyrics.jsp" />

		</div>
	</div>
	<jsp:include page="/assets/views/common/footer.jsp" />

	<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
	<script>
	
	// Tạo danh sách bài hát hiện có trên trang này
    var currentListOnPage = [
        <c:forEach items="${likedSongs != null ? likedSongs : listRandom}" var="s" varStatus="status">
        {
            id: '${s.id}',
            title: '${s.title}',
            artist: '${s.artist}',
            cover: '${pageContext.request.contextPath}/assets/${s.coverImage}',
            src: '${pageContext.request.contextPath}/assets/${s.filename}',
            lyrics: `${s.lyrics}`
        }${!status.last ? ',' : ''}
        </c:forEach>
    ];
		// Hàm phát tất cả (Logic đơn giản: Phát bài đầu tiên)
		function playAllLikedSongs() {
			const firstRow = document.querySelector('.song-row-liked');
			if (firstRow) {
				firstRow.click();
			} else {
				alert("Danh sách trống!");
			}
		}
		
		
		// 1. Hàm bật/tắt menu
		function toggleMenu(event, menuId, btnId) {
		    event.stopPropagation(); // Ngăn sự kiện phát nhạc của dòng (tr)
		    
		    const menu = document.getElementById(menuId);
		    const btn = document.getElementById(btnId);
		    
		    // Đóng tất cả các menu khác đang mở trước khi mở menu mới
		    document.querySelectorAll('.action-menu').forEach(m => {
		        if (m.id !== menuId) m.classList.remove('show');
		    });

		    // Toggle class show
		    menu.classList.toggle('show');
		}

		// 2. Đóng menu khi click bất kỳ đâu bên ngoài menu
		document.addEventListener('click', function(event) {
		    if (!event.target.closest('.action-menu') && !event.target.closest('.btn-more')) {
		        document.querySelectorAll('.action-menu').forEach(m => m.classList.remove('show'));
		    }
		});
		
		function removeFromFavorite(event, songId) {
		    event.stopPropagation(); // Không phát nhạc
		    
		    if (!confirm("Bạn muốn xóa bài hát này khỏi danh sách yêu thích?")) return;

		    // Gửi yêu cầu xóa tới Servlet (Tận dụng API toggle đã viết)
		    fetch('${pageContext.request.contextPath}/api/favorite', {
		        method: 'POST',
		        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
		        body: 'songId=' + songId
		    })
		    .then(res => res.text())
		    .then(data => {
		        if (data.trim() === "removed") {
		            // Tìm dòng (tr) chứa bài hát này và thực hiện hiệu ứng biến mất
		            const row = event.target.closest('.song-row');
		            row.style.opacity = '0';
		            row.style.transform = 'translateX(20px)';
		            
		            setTimeout(() => {
		                row.remove();
		                // Cập nhật lại số lượng bài hát trên header nếu cần
		                updateCountHeader();
		            }, 300);
		        }
		    })
		    .catch(err => console.error("Lỗi:", err));
		}

		function updateCountHeader() {
		    const countEl = document.querySelector('.metadata-count-liked');
		    const currentRows = document.querySelectorAll('.song-row').length;
		    if (countEl) countEl.innerText = currentRows + " bài hát";
		}
		function playAllLikedSongs() {
		    // 1. Kiểm tra xem danh sách bài hát trên trang có tồn tại và có bài nào không
		    if (typeof currentListOnPage !== 'undefined' && currentListOnPage.length > 0) {
		        
		        // 2. Gán toàn bộ danh sách bài hát yêu thích vào biến toàn cục 'songs' của Player
		        songs = currentListOnPage;
		        
		        // 3. Đặt chỉ số bài hát về 0 (bài đầu tiên)
		        songIndex = 0;
		        
		        // 4. Cập nhật ID bài hát hiện tại để đồng bộ hệ thống
		        window.currentSongId = songs[songIndex].id;

		        // 5. Gọi hàm load bài hát và phát nhạc (hàm đã có trong script.js)
		        loadSong(songIndex);
		        playSong();

		        // 6. Cập nhật trạng thái Like và Lời bài hát cho bài đầu tiên
		        if (typeof checkFavoriteStatus === 'function') checkFavoriteStatus(songs[songIndex].id);
		        if (typeof LyricsManager !== 'undefined' && LyricsManager.isOpen) LyricsManager.show(songs[songIndex].id);

		        console.log("Đang phát tất cả bài hát trong danh sách yêu thích.");
		    } else {
		        alert("Danh sách yêu thích của bạn hiện đang trống!");
		    }
		}
	</script>

</body>
</html>
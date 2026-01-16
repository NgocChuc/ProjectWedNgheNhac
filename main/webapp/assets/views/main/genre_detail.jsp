<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${playlistName}-SOUNDWAVE</title>

<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Spline+Sans:wght@300;500;700&display=swap"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined"
	rel="stylesheet" />

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/style.css">

<style>
/* CSS riêng cho bảng danh sách bài hát */
.song-info-wrapper {
	display: flex;
	align-items: center;
	gap: 15px;
}

.song-thumb-small {
	width: 40px;
	height: 40px;
	object-fit: cover;
	border-radius: 4px;
	flex-shrink: 0;
}

.col-action {
	width: 50px;
	text-align: center;
	position: relative;
}

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
	opacity: 0;
	visibility: hidden;
	transition: all 0.2s ease;
}

.song-row:hover .btn-more, .btn-more.active {
	opacity: 1;
	visibility: visible;
}

.action-menu {
	display: none;
	position: absolute;
	right: 40px;
	top: 50%;
	transform: translateY(-20%);
	background-color: #282828;
	border-radius: 4px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.5);
	padding: 4px;
	z-index: 100;
	min-width: 200px;
}

.action-menu.show {
	display: block;
}

.action-item {
	display: flex;
	align-items: center;
	gap: 12px;
	padding: 10px 12px;
	color: #eaeaea;
	text-decoration: none;
	font-size: 0.9rem;
	border-radius: 2px;
	transition: background 0.2s;
	cursor: pointer;
}

.action-item:hover {
	background-color: rgba(255, 255, 255, 0.1);
	color: #fff;
}

.action-item span {
	font-size: 20px;
	color: #b3b3b3;
}

.playlist-detail-container {
	width: 100%;
	/* Padding dưới để nội dung không bị Footer che */
	padding-bottom: 120px;
	box-sizing: border-box;
}

.song-table {
	width: 100%;
	border-collapse: separate;
	border-spacing: 0 8px;
}

.song-table th, .song-table td {
	padding: 12px 15px;
	vertical-align: middle;
	text-align: left;
}

.song-table th:nth-child(2), .song-table td:nth-child(2) {
	width: 45%;
}

.song-table th:nth-child(3), .song-table td:nth-child(3) {
	width: 30%;
}

.col-time {
	width: 100px;
	text-align: right;
}

.song-artist {
	color: #b3b3b3;
	font-size: 0.9rem;
	transition: color 0.2s ease;
}

.song-row:hover .song-artist {
	color: #ffffff;
}
</style>
</head>

<body>
	<c:set var="mainColor" value="#535353" />
	<c:choose>
		<c:when test="${param.type == 'V' || playlistName.contains('V-Pop')}">
			<c:set var="mainColor" value="#d81c1b" />
			<c:set var="playlistImg" value="v.jpg" />
		</c:when>
		<c:when test="${param.type == 'K' || playlistName.contains('K-Pop')}">
			<c:set var="mainColor" value="#d914eb" />
			<c:set var="playlistImg" value="k.jpg" />
		</c:when>
		<c:when test="${param.type == 'U' || playlistName.contains('US-UK')}">
			<c:set var="mainColor" value="#E2E2E2" />
			<c:set var="playlistImg" value="u.jpg" />
		</c:when>
	</c:choose>

	<jsp:include page="/assets/views/common/header.jsp" />

	<div class="main-content-wrapper layout-with-sidebar">

		<jsp:include page="/assets/views/common/sidebar.jsp" />

		<div class="main-content"
			style="background: linear-gradient(180deg, ${mainColor} 0%, #121212 500px) !important; padding: 0 !important; overflow: hidden; height: 100vh; position: relative;">

			<div id="main-view-container" style="height: 100%; overflow-y: auto;">

				<div class="playlist-detail-container">

					<div class="playlist-header-info">
						<div class="playlist-cover-big">
							<c:choose>
								<c:when test="${not empty songList}">
									<img
										src="${pageContext.request.contextPath}/assets/ima/${playlistImg}"
										onerror="this.src='${pageContext.request.contextPath}/assets/ima/default.png'"
										alt="${playlistName}">
								</c:when>
								<c:otherwise>
									<img
										src="${pageContext.request.contextPath}/assets/default.png"
										alt="Default">
								</c:otherwise>
							</c:choose>
						</div>

						<div class="playlist-text-info">
							<p>Playlist Đề Xuất</p>
							<h1>${playlistName}</h1>
							<p class="playlist-desc">${songList.size()}bàihát • Cập nhật
								hôm nay</p>
						</div>
					</div>

					<div class="song-list-container">
						<table class="song-table">
							<thead>
								<tr>
									<th class="col-index">#</th>
									<th>Tiêu đề</th>
									<th>Nghệ sĩ</th>
									<th class="col-time"><span
										class="material-symbols-outlined" style="font-size: 18px">schedule</span></th>
									<th class="col-action"></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${songList}" var="s" varStatus="loop">


									<tr class="song-row"
										onclick="loadAndPlay('${s.id}', '${s.title}', '${s.artist}', '${pageContext.request.contextPath}/assets/${s.coverImage}', '${pageContext.request.contextPath}/assets/${s.filename}')">

										<td class="col-index">${loop.index + 1}</td>

										<td>
											<div class="song-info-wrapper">
												<textarea id="lyrics-data-${s.id}" style="display: none;">${s.lyrics}</textarea>

												<img
													src="${pageContext.request.contextPath}/assets/${s.coverImage}"
													class="song-thumb-small"
													onerror="this.src='${pageContext.request.contextPath}/assets/image/default.png'">
												<div class="song-title">${s.title}</div>
											</div>
										</td>

										<td><div class="song-artist">${s.artist}</div></td>
										<td class="col-time">--:--</td>

										<td class="col-action">
											<button id="btn-more-${loop.index}" class="btn-more"
												onclick="toggleMenu(event, 'menu-${loop.index}', 'btn-more-${loop.index}')">
												<span class="material-symbols-outlined">more_horiz</span>
											</button>

											<div id="menu-${loop.index}" class="action-menu">
												<div class="action-item" onclick="addToPlaylist('${s.id}')">
													<span class="material-symbols-outlined">playlist_add</span>
													Thêm vào danh sách
												</div>
												<div class="action-item" onclick="addToFavorite('${s.id}')">
													<span class="material-symbols-outlined">favorite</span>
													Thêm vào mục yêu thích
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
			<jsp:include page="/assets/views/main/lyrics.jsp" />

		</div>
	</div>

	<jsp:include page="/assets/views/common/footer.jsp" />

	<script>
        function toggleMenu(event, menuId, btnId) {
            event.stopPropagation();
            var menu = document.getElementById(menuId);
            var btn = document.getElementById(btnId);
            
            var allMenus = document.querySelectorAll('.action-menu');
            var allBtns = document.querySelectorAll('.btn-more');
            
            allMenus.forEach(m => { if(m.id !== menuId) m.classList.remove('show'); });
            allBtns.forEach(b => { if(b.id !== btnId) b.classList.remove('active'); });

            if (menu.classList.contains('show')) {
                menu.classList.remove('show');
                btn.classList.remove('active');
            } else {
                menu.classList.add('show');
                btn.classList.add('active');
            }
        }

        function closeAllMenus() {
            document.querySelectorAll('.action-menu').forEach(m => m.classList.remove('show'));
            document.querySelectorAll('.btn-more').forEach(b => b.classList.remove('active'));
        }

        document.addEventListener('click', function() { closeAllMenus(); });

        function addToPlaylist(id) {
            event.stopPropagation();
            alert("Thêm vào playlist ID: " + id);
            closeAllMenus();
        }
        function addToFavorite(id) {
            event.stopPropagation();
            alert("Đã thích ID: " + id);
            closeAllMenus();
        }
        var currentListOnPage = [
            <c:forEach items="${songList}" var="s" varStatus="status">
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
        
        // Đảm bảo window.contextPath được định nghĩa để fetch API đúng
        window.contextPath = '${pageContext.request.contextPath}';
    </script>

	<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>
</html>
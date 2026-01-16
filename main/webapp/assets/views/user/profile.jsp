<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hồ sơ - SoundWave</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/CSS/main.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;900&display=swap"
	rel="stylesheet">

<style>
:root {
	--bg-base: #121212;
	--bg-sidebar: #000000;
	--header-height: 70px;
	--sidebar-width: 85px;
	--accent-color: #2bad7e;
}

body, html {
	margin: 0;
	padding: 0;
	height: 100%;
	width: 100%;
	font-family: 'Inter', sans-serif;
	background-color: var(--bg-base);
	color: white;
	overflow: hidden;
	/* Chặn scroll toàn trang để dùng scroll vùng nội dung */
}

/* Container tổng thể */
.app-layout {
	display: flex;
	height: 100vh;
	width: 100vw;
}


.static-sidebar {
	width: var(--sidebar-width);
	height: 100%;
	background-color: var(--bg-sidebar);
	display: flex;
	flex-direction: column;
	align-items: center;
	padding-top: 80px; /* Cách header */
	border-right: 1px solid rgba(255, 255, 255, 0.1);
	flex-shrink: 0;
	z-index: 100;
}

.nav-item {
	width: 50px;
	height: 50px;
	margin-bottom: 20px;
	border-radius: 12px;
	display: flex;
	align-items: center;
	justify-content: center;
	color: #b3b3b3;
	transition: 0.3s;
	text-decoration: none;
}

.nav-item:hover, .nav-item.active {
	background-color: #282828;
	color: white;
}

/* VÙNG NỘI DUNG CHÍNH */
.main-view {
	flex-grow: 1;
	display: flex;
	flex-direction: column;
	overflow: hidden;
	position: relative;
}

/* HEADER CỦA BẠN (ÉP CỐ ĐỊNH LÊN ĐẦU VÙNG MAIN) */
.header-wrapper {
	height: var(--header-height);
	width: 100%;
	z-index: 1000;
}

/* NỘI DUNG CÓ THỂ CUỘN */
.scroll-container {
	flex-grow: 1;
	overflow-y: auto;
	scrollbar-width: thin;
}

/* PROFILE HERO (GIAO DIỆN HIỆN ĐẠI) */
.profile-hero {
	padding: 40px;
	min-height: 340px;
	background: linear-gradient(to bottom, var(--accent-color),
		var(--bg-base));
	display: flex;
	align-items: flex-end;
	gap: 30px;
}

.profile-avatar {
	width: 232px;
	height: 232px;
	border-radius: 50%;
	box-shadow: 0 15px 50px rgba(0, 0, 0, 0.5);
	position: relative;
	overflow: hidden;
	cursor: pointer;
}

.profile-avatar img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.avatar-edit-overlay {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
	display: flex;
	justify-content: center;
	align-items: center;
	opacity: 0;
	transition: 0.3s;
}

.profile-avatar:hover .avatar-edit-overlay {
	opacity: 1;
}

.user-name {
	font-size: 6rem;
	font-weight: 900;
	margin: 10px 0;
	letter-spacing: -3px;
}

/* SONG LIST & ARTIST GRID */
.profile-section {
	padding: 30px 40px;
}

.section-title {
	font-size: 1.5rem;
	font-weight: 700;
	margin-bottom: 20px;
}

.song-item {
	display: flex;
	align-items: center;
	padding: 10px 15px;
	border-radius: 8px;
	transition: 0.2s;
	cursor: pointer;
}

.song-item:hover {
	background: rgba(255, 255, 255, 0.1);
}

.song-item img {
	width: 45px;
	height: 45px;
	border-radius: 4px;
	margin-right: 15px;
}

.song-info {
	flex-grow: 1;
}

.song-info h4 {
	margin: 0;
	font-size: 1rem;
}

.song-info p {
	margin: 0;
	font-size: 0.85rem;
	color: #b3b3b3;
}

.play-count {
	color: #b3b3b3;
	font-size: 0.9rem;
}

.music-grid {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
	gap: 20px;
}

.artist-card {
	background: #181818;
	padding: 20px;
	border-radius: 12px;
	text-align: center;
	transition: 0.3s;
	cursor: pointer;
}

.artist-card:hover {
	background: #282828;
	transform: translateY(-5px);
}

.circle-img {
	width: 100%;
	aspect-ratio: 1/1;
	border-radius: 50%;
	background-size: cover;
	background-position: center;
	margin-bottom: 15px;
	box-shadow: 0 8px 24px rgba(0, 0, 0, 0.5);
}
</style>
</head>
<body>
	<div class="app-layout">
		<nav class="static-sidebar">
			<a href="${pageContext.request.contextPath}/profile" class="nav-item active" title="Hồ sơ"> <span
				class="material-symbols-outlined">person</span>
			</a> <a href="${pageContext.request.contextPath}/setting"
				class="nav-item" title="Cài đặt"> <span
				class="material-symbols-outlined">settings</span>
			</a>
		</nav>

		<div class="main-view">
			<div class="header-wrapper">
				<jsp:include page="/assets/views/common/header.jsp" />
			</div>

			<div class="scroll-container">
				<div class="profile-hero">
					<div class="profile-avatar"
						onclick="document.getElementById('fileInput').click();">
						<img
							src="${sessionScope.user.avatarUrl != null ? sessionScope.user.avatarUrl : 'assets/image/default-avt.jpg'}"
							id="avatarPreview">
						<div class="avatar-edit-overlay">
							<span class="material-symbols-outlined" style="font-size: 40px;">edit</span>
						</div>
						<form id="avatarForm" action="update-avatar" method="post"
							enctype="multipart/form-data" style="display: none;">
							<input type="file" id="fileInput" name="avatar"
								onchange="this.form.submit()">
						</form>
					</div>

					<div class="profile-details">
						<span
							style="font-size: 13px; font-weight: 700; text-transform: uppercase;">Hồ
							sơ</span>
						<h1 class="user-name">${sessionScope.user.userName}</h1>
						
					</div>
				</div>

				<section class="profile-section">
					<h2 class="section-title">Bài hát nghe nhiều nhất tháng này</h2>
					<div class="song-list-vertical">
						<c:forEach var="song" items="${topSongs}">
							<div class="song-item">
								<img src="${song.coverImage}">
								<div class="song-info">
									<h4>${song.title}</h4>
									<p>${song.artist}</p>
								</div>
								<span class="play-count">${song.playCount} lượt nghe</span>
							</div>
						</c:forEach>
					</div>
				</section>

				<section class="profile-section">
					<h2 class="section-title">Nghệ sĩ bạn đã nghe</h2>
					<div class="music-grid">
						<c:forEach var="artist" items="${listenedArtists}">
							<div class="artist-card">
								<div class="circle-img"
									style="background-image: url('${artist.image}')"></div>
								<h4 style="margin: 0;">${artist.name}</h4>
								<p style="color: #b3b3b3; font-size: 0.8rem;">Nghệ sĩ</p>
							</div>
						</c:forEach>
					</div>
				</section>

				<div style="height: 100px;"></div>
			</div>
		</div>
	</div>
</body>

<script>
    document.querySelectorAll('.nav-item').forEach(item => {
        // Kiểm tra nếu href của item trùng với URL hiện tại
        if (window.location.href.includes(item.getAttribute('href'))) {
            document.querySelectorAll('.nav-item').forEach(nav => nav.classList.remove('active'));
            item.classList.add('active');
        }
    });
</script>
</html>
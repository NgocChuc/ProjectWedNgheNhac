<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SOUNDWAVE</title>

<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap"
	rel="stylesheet">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/style.css">

<style>
/* --- CSS CHO HOME VIEW & LYRICS VIEW --- */
<
style> /* --- CSS CHO HOME VIEW & LYRICS VIEW --- */ #lyrics-view {
	margin: -20px;
	width: calc(100% + 40px);
	height: calc(100% + 40px);
	animation: fadeIn 0.4s ease;
	position: relative;
	overflow: hidden;
	position: relative;
	z-index: 900;
	border-radius: 8px;
}

#lyrics-view[style*="display: flex"] {
	display: flex !important; @ keyframes fadeIn { from { opacity : 0;
	transform: translateY(20px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}

/* Container chính */
.lyrics-container-style {
	width: 100%;
	max-width: 1200px;
	margin: 0 auto;
	height: 100%;
	position: relative;
	display: flex;
	flex-direction: column;
}

/* --- LỜI BÀI HÁT (CUỘN ĐƯỢC) --- */
.lyrics-scroll-area-style {
	height: 100%;
	overflow-y: auto; /* Chỉ phần này cuộn */
	/* Style chữ */
	font-size: 40px;
	line-height: 1.8;
	font-weight: 600;
	color: #e0e0e0;
	text-align: left;
	white-space: pre-line;
	/* PADDING QUAN TRỌNG */
	/* Padding Top lớn để chừa chỗ cho Header Tag đứng yên */
	padding-top: 150px;
	padding-left: 20px;
	padding-right: 20px;
	/* Padding Bottom lớn để chừa chỗ cho Player Footer */
	padding-bottom: 150px;
	scroll-behavior: smooth;

	/* ĐÃ XÓA mask-image (Bỏ hiệu ứng mờ 2 đầu) */
}

/* Scrollbar đẹp */
.lyrics-scroll-area-style::-webkit-scrollbar {
	width: 6px;
}

.lyrics-scroll-area-style::-webkit-scrollbar-thumb {
	background: rgba(255, 255, 255, 0.1);
	border-radius: 4px;
}

.lyrics-scroll-area-style::-webkit-scrollbar-thumb:hover {
	background: rgba(255, 255, 255, 0.3);
}

/* --- CSS Music Card (Giữ nguyên) --- */
.music-card-item {
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.music-card-item:hover {
	background-color: rgba(255, 255, 255, 0.1);
}

.music-card-item:hover .card-title-text {
	color: #fff;
	text-decoration: underline;
}

.play-btn-overlay {
	cursor: pointer;
}

/* Responsive Mobile */
@media ( max-width : 768px) {
	.song-header-style {
		left: 50%;
		transform: translateX(-50%);
		width: 80%;
		text-align: center;
	}
	.lyrics-scroll-area-style {
		padding-top: 220px;
	}
}
</style>

</head>

<body>
	
	<input type="hidden" id="isLoggedIn" value="true">

	<jsp:include page="/assets/views/common/header.jsp" />

	<div class="main-content-wrapper layout-with-sidebar">

		<jsp:include page="/assets/views/common/sidebar.jsp" />

		<div class="main-content" id="home-layout" 
         style="background: #121212 !important; padding: 20px !important;">

			<div id="main-view-container">

				<div class="image-carousel">
					<div class="carousel-track" id="carouselTrack">
						<div class="carousel-item">
							<img class="banner-bg-blur"
								src="${pageContext.request.contextPath}/assets/banner/bn01.jpg"
								alt="Background">
							<div class="banner-content">
								<img class="banner-img-main"
									src="${pageContext.request.contextPath}/assets/banner/bn01.jpg"
									alt="Banner 1">
							</div>
						</div>
						<div class="carousel-item">
							<img class="banner-bg-blur"
								src="${pageContext.request.contextPath}/assets/banner/bn02.png"
								alt="Background">
							<div class="banner-content">
								<img class="banner-img-main"
									src="${pageContext.request.contextPath}/assets/banner/bn02.png"
									alt="Banner 2">
							</div>
						</div>
						<div class="carousel-item">
							<img class="banner-bg-blur"
								src="${pageContext.request.contextPath}/assets/banner/bn03.jpg"
								alt="Background">
							<div class="banner-content">
								<img class="banner-img-main"
									src="${pageContext.request.contextPath}/assets/banner/bn03.jpg"
									alt="Banner 3">
							</div>
						</div>
					</div>
				</div>

				<section class="grid-section">
					<h2 class="section-title">Bài hát đề xuất</h2>

					<div class="card-grid-container">
						<c:forEach items="${listRandom}" var="s">

							<textarea id="lyrics-data-${s.id}" style="display: none;">${s.lyrics}</textarea>

							<div class="music-card-item">
								<div class="card-img-wrapper">
									<img
										src="${pageContext.request.contextPath}/assets/${s.coverImage}"
										alt="${s.title}" class="card-img-content"
										onerror="this.src='${pageContext.request.contextPath}/assets/default.png'">

									<div class="play-btn-overlay"
										onclick="event.stopPropagation(); loadAndPlay(
                        '${s.id}',
                        '${s.title}', 
                        '${s.artist}', 
                        '${pageContext.request.contextPath}/assets/${s.coverImage}', 
                        '${pageContext.request.contextPath}/assets/${s.filename}'
                     )">
										<svg viewBox="0 0 24 24" width="24" height="24" fill="black">
                        <path d="M8 5v14l11-7z" />
                    </svg>
									</div>
								</div>

								<div class="card-text-wrapper">
									<div class="card-title-text" style="cursor: pointer;"
										onclick="event.stopPropagation(); loadAndPlay(
                        '${s.id}',
                        '${s.title}', 
                        '${s.artist}', 
                        '${pageContext.request.contextPath}/assets/${s.coverImage}', 
                        '${pageContext.request.contextPath}/assets/${s.filename}'
                     )">
										${s.title}</div>
									<div class="card-artist-text">${s.artist}</div>
								</div>
							</div>

						</c:forEach>
					</div>
				</section>

				

				<section class="grid-section">
					<h2 class="section-title">Khám phá thể loại</h2>

					<div class="card-grid-container">

						<div class="music-card-item"
							onclick="window.location.href='${pageContext.request.contextPath}/genre?type=V'">
							<div class="card-img-wrapper">
								<img
									src="${pageContext.request.contextPath}/assets/ima/v.jpg"
									class="card-img-content" alt="V-Pop">
								<div class="play-btn-overlay">
									<svg viewBox="0 0 24 24" width="24" height="24" fill="black">
										<path d="M8 5v14l11-7z" /></svg>
								</div>
							</div>
							<div class="card-text-wrapper">
								<div class="card-title-text">V-Pop</div>
								<div class="card-artist-text">Nhạc Việt</div>
							</div>
						</div>

						<div class="music-card-item"
							onclick="window.location.href='${pageContext.request.contextPath}/genre?type=K'">
							<div class="card-img-wrapper">
								<img
									src="${pageContext.request.contextPath}/assets/ima/k.jpg"
									class="card-img-content" alt="K-Pop">
								<div class="play-btn-overlay">
									<svg viewBox="0 0 24 24" width="24" height="24" fill="black">
										<path d="M8 5v14l11-7z" /></svg>
								</div>
							</div>
							<div class="card-text-wrapper">
								<div class="card-title-text">K-Pop</div>
								<div class="card-artist-text">Nhạc Hàn Quốc</div>
							</div>
						</div>

						<div class="music-card-item"
							onclick="window.location.href='${pageContext.request.contextPath}/genre?type=U'">
							<div class="card-img-wrapper">
								<img
									src="${pageContext.request.contextPath}/assets/ima/u.jpg"
									class="card-img-content" alt="US-UK">
								<div class="play-btn-overlay">
									<svg viewBox="0 0 24 24" width="24" height="24" fill="black">
										<path d="M8 5v14l11-7z" /></svg>
								</div>
							</div>
							<div class="card-text-wrapper">
								<div class="card-title-text">US-UK</div>
								<div class="card-artist-text">Âu Mỹ nổi bật</div>
							</div>
						</div>

					</div>
				</section>

				<section class="grid-section">
					<h2 class="section-title">Nghệ sĩ đề xuất</h2>
				</section>

			</div>
			 <jsp:include page="/assets/views/main/lyrics.jsp" />
			

		</div>
	</div>
   
	<jsp:include page="/assets/views/common/footer.jsp" />

   
	<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>
</html>

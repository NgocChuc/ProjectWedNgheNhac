<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="Model_Layer.*"%>
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
<link
	href="https://fonts.googleapis.com/css2?family=Spline+Sans:wght@300;500;700&display=swap"
	rel="stylesheet" />

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/CSS/style.css">
</head>

<body>

	<input type="hidden" id="isLoggedIn" value="true">

	<jsp:include page="JSP/hearder.jsp" />

	<div class="main-content-wrapper">

		<jsp:include page="JSP/sidebar.jsp" />

		<div class="main-content">

			<div class="image-carousel">
				<div class="carousel-track" id="carouselTrack">
					<div class="carousel-item">
						<img src="${pageContext.request.contextPath}/assets/img/b1.jpg"
							alt="Banner 1">
					</div>
					<div class="carousel-item">
						<img src="${pageContext.request.contextPath}/assets/img/b2.jpg"
							alt="Banner 2">
					</div>
					<div class="carousel-item">
						<img src="${pageContext.request.contextPath}/assets/img/b3.jpg"
							alt="Banner 3">
					</div>
				</div>
			</div>

			<section class="grid-section">
				<h2 class="section-title">Bài hát đề xuất</h2>

				<div class="card-grid-container">
					<c:forEach items="${listRandom}" var="s">

						<div class="music-card-item"
							onclick="loadAndPlay('${s.title}', '${s.artist}', '${pageContext.request.contextPath}/assets/${s.coverImage}', '${pageContext.request.contextPath}/assets/${s.filename}')">

							<div class="card-img-wrapper">
								<img
									src="${pageContext.request.contextPath}/assets/${s.coverImage}"
									alt="${s.title}" class="card-img-content">

								<div class="play-btn-overlay">
									<svg viewBox="0 0 24 24" width="24" height="24" fill="black">
                            <path d="M8 5v14l11-7z" />
                        </svg>
								</div>
							</div>

							<div class="card-text-wrapper">
								<div class="card-title-text">${s.title}</div>
								<div class="card-artist-text">${s.artist}</div>
							</div>
						</div>

					</c:forEach>
				</div>
			</section>

			<section class="grid-section">
				<h2 class="section-title">Bảng xếp hạng</h2>

			</section>

			<section class="grid-section">
				<h2 class="section-title">Khám phá thể loại</h2>
			</section>

			<section class="grid-section">
				<h2 class="section-title">Nghệ sĩ đề xuất</h2>

			</section>
		</div>
	</div>

	<jsp:include page="JSP/footer.jsp" />

	<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>
</html>

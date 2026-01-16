<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cài đặt - SoundWave</title>

<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;900&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/CSS/main.css">

<style>
/* --- 1. BIẾN CSS ĐỒNG BỘ TỪ PROFILE --- */
:root {
	--bg-base: #121212;
	--bg-sidebar: #000000;
	--header-height: 70px;
	--sidebar-width: 85px;
	--accent-color: #86B6F6; /* Màu xanh của bạn */
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
}

/* --- 2. LAYOUT CHUNG --- */
.app-layout {
	display: flex;
	height: 100vh;
	width: 100vw;
}

/* --- 3. SIDEBAR TĨNH (GIỐNG PROFILE) --- */
.static-sidebar {
	width: var(--sidebar-width);
	height: 100%;
	background-color: var(--bg-sidebar);
	display: flex;
	flex-direction: column;
	align-items: center;
	padding-top: 80px;
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

.nav-item.active {
	color: var(--accent-color);
}

/* --- 4. VÙNG NỘI DUNG CHÍNH (QUAN TRỌNG) --- */
.main-view {
	flex-grow: 1;
	display: flex;
	flex-direction: column;
	overflow: hidden;
	position: relative;
}

.header-wrapper {
	height: var(--header-height);
	width: 100%;
	z-index: 1000;
}

.scroll-container {
	flex-grow: 1;
	overflow-y: auto;
	scrollbar-width: thin;
	padding-bottom: 100px;
}

/* --- 5. CSS BOX NỘI DUNG CÀI ĐẶT --- */
.account-content-wrapper {
	width: 100%;
	max-width: 800px;
	margin: 40px auto;
	padding: 0 20px;
}

.box-section {
	background-color: #181818; /* Sáng hơn nền base chút */
	padding: 25px;
	margin-bottom: 25px;
	border-radius: 12px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
}

.box-section h2 {
	margin: 0 0 20px 0;
	font-size: 20px;
	border-bottom: 1px solid #333;
	padding-bottom: 15px;
}

.info-row {
	display: flex;
	justify-content: space-between;
	padding: 15px 0;
	border-bottom: 1px dashed #333;
}

.info-row:last-child {
	border-bottom: none;
}

.label {
	color: #b3b3b3;
	font-weight: 600;
}

.btn-change-pass {
	background-color: #333;
	color: white;
	padding: 10px 22px;
	text-decoration: none;
	border-radius: 30px;
	font-size: 14px;
	font-weight: 700;
	border: 1px solid #444;
	transition: 0.2s;
}

.btn-change-pass:hover {
	background-color: white;
	color: black;
}

/* Modal CSS giữ nguyên như cũ của bạn... */
</style>
</head>
<body>
	<div class="app-layout">
		<nav class="static-sidebar">
			<a href="${pageContext.request.contextPath}/profile" class="nav-item"
				title="Hồ sơ"> <span class="material-symbols-outlined">person</span>
			</a> <a href="${pageContext.request.contextPath}/setting"
				class="nav-item active" title="Cài đặt"> <span
				class="material-symbols-outlined">settings</span>
			</a>
		</nav>

		<div class="main-view">
			<div class="header-wrapper">
				<jsp:include page="/assets/views/common/header.jsp" />
			</div>

			<div class="scroll-container">
				<div class="account-content-wrapper">

					<div class="box-section">
						<h2>Thông tin tài khoản</h2>
						<div class="info-row">
							<span class="label">Họ và tên</span> <span class="value">${sessionScope.user.userName}</span>
						</div>
						<div class="info-row">
							<span class="label">Email</span> <span class="value">${sessionScope.user.email}</span>
						</div>
					</div>

					<div class="box-section">
						<h2>Bảo mật</h2>
						<div
							style="display: flex; justify-content: space-between; align-items: center;">
							<span style="color: #b3b3b3;">Mật khẩu: ******</span> <a
								href="${pageContext.request.contextPath}/forgot?email=${sessionScope.user.email}"
								class="btn-change-pass"> Thay đổi mật khẩu </a>
						</div>
					</div>

					<div class="box-section">
						<h2>Hỗ trợ</h2>
						<p style="color: #b3b3b3;">Email: support@soundwave.com</p>
						<p style="color: #b3b3b3;">Hotline: 1900 1234</p>
					</div>

				</div>
			</div>
		</div>
	</div>

</body>
</html>
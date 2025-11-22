<%-- home.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Trang Chủ</title>
<link rel="stylesheet" href="style.css">
<%-- Nếu bạn muốn tách CSS ra --%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/header.css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/layout.css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/player.css">

</head>

<style>
body {
	margin: 0;
	padding: 0;
	background-color: #000;
	font-family: 'Nunito', sans-serif;
	color: white;
	overflow: hidden; /* Ẩn scroll của body để layout tự cuộn */
}
</style>
<body>

	<jsp:include page="/header.jsp" />

	<div class="main_container expanded">

		<div class="left-menu-bar"></div>

		<div class="main-content"></div>

		<div class="right-bar"></div>
	</div>

	<jsp:include page="/player_bar.jsp" />

</body>
</html>

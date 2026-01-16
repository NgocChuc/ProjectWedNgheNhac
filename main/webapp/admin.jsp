<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard - SOUNDWAVE</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
body {
	background-color: #f8f9fa;
}

.sidebar {
	min-height: 100vh;
	background: #212529;
	color: white;
}

.sidebar a {
	color: #adb5bd;
	text-decoration: none;
	padding: 12px;
	display: block;
	border-radius: 4px;
}

.sidebar a:hover, .sidebar a.active {
	background: #0d6efd;
	color: white;
}

.stat-card {
	border: none;
	border-radius: 10px;
	transition: transform 0.3s;
}

.stat-card:hover {
	transform: translateY(-5px);
}
</style>
</head>
<body>
	<div class="d-flex">
		<div class="sidebar p-3 d-flex flex-column">
			<a href="${pageContext.request.contextPath}/admin/dashboard-data"
				class="active"> <i class="fas fa-chart-line me-2"></i> Tổng quan
			</a> <a href="${pageContext.request.contextPath}/adminSongs"> <i
				class="fas fa-music me-2"></i> Quản lý Bài hát
			</a> <a href="${pageContext.request.contextPath}/adminUser"> <i
				class="fas fa-users me-2"></i> Quản lý Người dùng
			</a>

			<hr class="text-secondary">
			<a href="${pageContext.request.contextPath}/logout"
				class="text-danger mt-auto"> <i class="fas fa-sign-out-alt me-2"></i>
				Đăng xuất
			</a>
		</div>

		<div class="container-fluid p-4">
			<h2 class="mb-4">Hệ thống quản trị</h2>
			<div class="row g-4">
				<div class="col-md-6 col-lg-4">
					<div class="card stat-card bg-primary text-white shadow-sm">
						<div class="card-body">
							<h5>Tổng bài hát</h5>
							<h2 class="fw-bold">${totalSongs}</h2>
							<i class="fas fa-music float-end opacity-50"
								style="font-size: 2rem;"></i>
						</div>
					</div>
				</div>
				<div class="col-md-6 col-lg-4">
					<div class="card stat-card bg-success text-white shadow-sm">
						<div class="card-body">
							<h5>Người dùng</h5>
							<h2 class="fw-bold">${totalUsers}</h2>
							<i class="fas fa-users float-end opacity-50"
								style="font-size: 2rem;"></i>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
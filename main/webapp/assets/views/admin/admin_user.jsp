<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản lý Người dùng - SOUNDWAVE</title>
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

.avatar-img {
	width: 40px;
	height: 40px;
	object-fit: cover;
	border-radius: 50%;
}
</style>
</head>
<body>
	<div class="d-flex">
		<div class="sidebar p-3 d-flex flex-column">
			<a href="${pageContext.request.contextPath}/admin/dashboard-data"
				class="${requestScope['javax.servlet.forward.servlet_path'] == '/admin/dashboard-data' ? 'active' : ''}">
				<i class="fas fa-chart-line me-2"></i> Tổng quan
			</a> <a href="${pageContext.request.contextPath}/adminSongs"
				class="${requestScope['javax.servlet.forward.servlet_path'] == '/adminSongs' ? 'active' : ''}">
				<i class="fas fa-music me-2"></i> Quản lý Bài hát
			</a> <a href="${pageContext.request.contextPath}/adminUser"
				class="${requestScope['javax.servlet.forward.servlet_path'] == '/adminUser' ? 'active' : ''}">
				<i class="fas fa-users me-2"></i> Quản lý Người dùng
			</a>

			<hr class="text-secondary">
			<a href="${pageContext.request.contextPath}/logout"
				class="text-danger mt-auto"> <i class="fas fa-sign-out-alt me-2"></i>
				Đăng xuất
			</a>
		</div>

		<div class="container-fluid p-4">
			<h2 class="mb-4">Quản lý người dùng hệ thống</h2>
			<div class="card shadow-sm border-0">
				<div class="card-body p-0">
					<table class="table table-hover align-middle mb-0">
						<thead class="table-dark">
							<tr>
								<th class="ps-4">ID</th>
								<th>Avatar</th>
								<th>Tên người dùng</th>
								<th>Email</th>
								<th>Quyền hạn</th>
								<th class="text-end pe-4">Thao tác</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="u" items="${userList}">
								<tr>
									<td class="ps-4">#${u.id}</td>
									<td><img
										src="${u.avatarUrl != null ? u.avatarUrl : 'https://via.placeholder.com/50'}"
										class="avatar-img"></td>
									<td class="fw-bold">${u.userName}</td>
									<td>${u.email}</td>
									<td><span
										class="badge ${u.role == 'admin' ? 'bg-danger' : 'bg-primary'}">${u.role}</span>
									</td>
									<td class="text-end pe-4">
										<form action="adminUser" method="post"
											onsubmit="return confirm('Xóa người dùng này?');">
											<input type="hidden" name="action" value="delete"> <input
												type="hidden" name="id" value="${u.id}">
											<button type="submit" class="btn btn-sm btn-outline-danger">
												<i class="fas fa-user-slash"></i>
											</button>
										</form>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
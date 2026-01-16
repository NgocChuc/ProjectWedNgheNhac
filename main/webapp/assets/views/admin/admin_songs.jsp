<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản lý Bài hát - SOUNDWAVE</title>
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

.cover-img {
	width: 50px;
	height: 50px;
	object-fit: cover;
	border-radius: 6px;
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
			<div class="d-flex justify-content-between align-items-center mb-4">
				<h2>Danh sách bài hát</h2>
				<button class="btn btn-primary" data-bs-toggle="modal"
					data-bs-target="#addSongModal">
					<i class="fas fa-plus me-2"></i>Thêm bài hát mới
				</button>
			</div>

			<div class="card shadow-sm border-0">
				<div class="card-body p-0">
					<table class="table table-hover align-middle mb-0">
						<thead class="table-dark">
							<tr>
								<th class="ps-4">ID</th>
								<th>Ảnh bìa</th>
								<th>Thông tin bài hát</th>
								<th>Ca sĩ</th>
								<th class="text-end pe-4">Thao tác</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="s" items="${song}">
								<tr>
									<td class="ps-4">#${s.id}</td>
									<td><img src="${s.coverImage}" class="cover-img"
										onerror="this.src='https://placehold.co/50x50?text=No+Image'"></td>
									<td>
										<div class="fw-bold">${s.title}</div>
										<div class="text-muted small">Thể loại: ${s.genre}</div>
									</td>
									<td>${s.artist}</td>
									<td class="text-end pe-4">
										<form action="adminSongs" method="post" class="d-inline"
											onsubmit="return confirm('Bạn có chắc muốn xóa bài hát này?');">
											<input type="hidden" name="action" value="delete"> <input
												type="hidden" name="id" value="${s.id}">
											<button type="submit" class="btn btn-sm btn-outline-danger">
												<i class="fas fa-trash"></i>
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

	<div class="modal fade" id="addSongModal" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<form action="adminSongs" method="post">
					<input type="hidden" name="action" value="add">
					<div class="modal-header">
						<h5 class="modal-title fw-bold">Thêm bài hát mới</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
					</div>
					<div class="modal-body">
						<div class="row">
							<div class="col-md-6 mb-3">
								<label class="form-label fw-bold">Tên bài hát <span
									class="text-danger">*</span></label> <input type="text" name="title"
									class="form-control" required>
							</div>
							<div class="col-md-6 mb-3">
								<label class="form-label fw-bold">Ca sĩ <span
									class="text-danger">*</span></label> <input type="text" name="artist"
									class="form-control" required>
							</div>
						</div>
						<div class="row">
							<div class="col-md-6 mb-3">
								<label class="form-label fw-bold">Thể loại</label> <input
									type="text" name="genre" class="form-control">
							</div>
							<div class="col-md-6 mb-3">
								<label class="form-label fw-bold">Đường dẫn file nhạc
									(.mp3) <span class="text-danger">*</span>
								</label> <input type="text" name="songUrl" class="form-control"
									placeholder="URL bài hát" required>
							</div>
						</div>
						<div class="mb-3">
							<label class="form-label fw-bold">Link ảnh bìa (URL)</label> <input
								type="text" name="coverImage" class="form-control"
								placeholder="https://...">
						</div>
						<div class="mb-3">
							<label class="form-label fw-bold">Lời bài hát (Không bắt
								buộc)</label>
							<textarea name="lyrics" class="form-control" rows="5"
								placeholder="Nhập lời bài hát tại đây..."></textarea>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Hủy</button>
						<button type="submit" class="btn btn-primary px-4">Lưu
							bài hát</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
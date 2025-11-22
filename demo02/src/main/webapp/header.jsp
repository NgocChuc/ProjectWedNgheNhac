<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
// Lấy thông tin người dùng từ request scope (do Controller gửi đến)
// Đã sửa: Thay UserModel thành User
model.user.User user = (model.user.User) request.getAttribute("user");
%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/header.css">
<header class="headerA">
	<%-- LOGO MỚI Ở BÊN TRÁI HEADER --%>
	<div class="headerA-left-logo">
		<a href="${pageContext.request.contextPath}/home" class="logo-link">
			<%-- Thay đổi link hình ảnh 'src' tại đây --%> <img
			src="${pageContext.request.contextPath}/img/avt2.jpg" alt="Logo"
			class="site-logo">
		</a>
	</div>
	<p style="color: red;">
		Context Path:
		<%=request.getContextPath()%></p>
	<div class="headerA-center">
		<div class="headerA-center-arrow">
			<button id="arrowBackHA" class="arrow-backHA_btn"
				onclick="window.history.back()">
				<svg xmlns="http://www.w3.org/2000/svg" height="40px"
					viewBox="0 -960 960 960" width="40px" fill="#F3F3F3">
                    <path
						d="M400-80 0-480l400-400 61 61.67L122.67-480 461-141.67 400-80Z" />
                </svg>
			</button>
			<button id="arrowForwardHA" class="arrow-forwardHA_btn"
				onclick="window.history.forward()">
				<svg xmlns="http://www.w3.org/2000/svg" height="40px"
					viewBox="0 -960 960 960" width="40px" fill="#F3F3F3">
                    <path
						d="m309.67-81.33-61-61.67L587-481.33 248.67-819.67l61-61.66 400 400-400 400Z" />
                </svg>
			</button>
		</div>

		<%-- Đã loại bỏ .headerA-center-home cũ --%>

		<%-- FORM SẼ GỬI YÊU CẦU ĐẾN SearchServlet --%>
		<form class="search-headerA"
			action="${pageContext.request.contextPath}/search" method="GET">
			<input id="inputSrchH" class="input-search-header" name="query"
				placeholder="tìm kiếm bào hát, nghệ sĩ,..." />
			<button class="input-sreach-headerA_btn" type="submit">
				<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"
					width="22" height="22">
                    <path
						d="M18.031 16.6168L22.3137 20.8995L20.8995 22.3137L16.6168 18.031C15.0769 19.263 13.124 20 11 20C6.032 20 2 15.968 2 11C2 6.032 6.032 2 11 2C15.968 2 20 6.032 20 11C20 13.124 19.263 15.0769 18.031 16.6168ZM16.0247 15.8748C17.2475 14.6146 18 12.8956 18 11C18 7.1325 14.8675 4 11 4C7.1325 4 4 7.1325 4 11C4 14.8675 7.1325 18 11 18C12.8956 18 14.6146 17.2475 15.8748 16.0247L16.0247 15.8748Z"
						fill="#efeff1"></path>
                </svg>
			</button>
		</form>
	</div>
	<%-- button thông báo --%>
	<div class="headerA-right">
		<div class="headerA-right-notifications">
			<button id="notificationBtn"
				class="headerA-right-button-notifications">
				<svg viewBox="0 0 448 512" class="bell-noti">
                    <path
						d="M224 0c-17.7 0-32 14.3-32 32V49.9C119.5 61.4 64 124.2 64 200v33.4c0 45.4-15.5 89.5-43.8 124.9L5.3 377c-5.8 7.2-6.9 17.1-2.9 25.4S14.8 416 24 416H424c9.2 0 17.6-5.3 21.6-13.6s2.9-18.2-2.9-25.4l-14.9-18.6C399.5 322.9 384 278.8 384 233.4V200c0-75.8-55.5-138.6-128-150.1V32c0-17.7-14.3-32-32-32zm0 96h8c57.4 0 104 46.6 104 104v33.4c0 47.9 13.9 94.6 39.7 134.6H72.3C98.1 328 112 281.3 112 233.4V200c0-57.4 46.6-104 104-104h8zm64 352H224 160c0 17 6.7 33.3 18.7 45.3s28.3 18.7 45.3 18.7s33.3-6.7 45.3-18.7s18.7-28.3 18.7-45.3z">
                    </path>
                </svg>
			</button>
			<%-- bảng thông báo --%>
			<div id="notificationsDropdown" class="notifications-dropdown">
				<div class="notifications-header">
					<h3 class="notifications-title">Có gì mới!!!</h3>
				</div>
				<div class="notifications-content">
					<%-- Nội dung khi chưa có thông báo --%>
					<p class="notifications-empty-message">
						Chưa có thông báo mới.<br> Hãy Theo dõi 1 nghệ sĩ
						yêu thích!
					</p>

					<%-- Sau này, các mục thông báo thực tế sẽ được thêm vào đây --%>
				</div>

			</div>
		</div>

		<%-- Kiểm tra trạng thái đăng nhập để hiển thị nút phù hợp --%>
		<%
		if (user != null) {
		%>
		<%-- Hiển thị Avatar nếu đã đăng nhập --%>
		<div class="header-right-icon avatar">
			<a href="${pageContext.request.contextPath}/profile"
				class="useraccount-btn"> <img src="<%=user.getAvatarUrl()%>"
				alt="Avatar" style="width: 40px; height: 40px; border-radius: 50%;">
			</a>
			
			<div id="userDropdown" class="user-dropdown-menu">
        <ul class="user-menu-list">
            <li class="user-menu-item"><a href="#" class="menu-link">Tài khoản</a></li>
            <li class="user-menu-item"><a href="${pageContext.request.contextPath}/profile" class="menu-link">Profile</a></li>
            <li class="user-menu-item"><a href="#" class="menu-link">Cài đặt</a></li>
            <li class="user-menu-item divider"></li> <%-- Đường phân cách --%>
            <li class="user-menu-item"><a href="${pageContext.request.contextPath}/logout" class="menu-link">Đăng Xuất</a></li> <%-- Thêm nút Đăng Xuất --%>
        </ul>
    </div>
    
		</div>
		<%
		} else {
		%>
		<%-- Hiển thị nút Đăng Nhập nếu chưa đăng nhập --%>
		<a href="${pageContext.request.contextPath}/login"
			class="headerA-register_btn"
			style="background-color: #2a2a2a; color: white; border: none; padding: 8px 15px; border-radius: 20px; text-decoration: none; font-weight: bold; margin-left: 10px; transition: background-color 0.2s ease;">
			Đăng Nhập </a>
		<%
		}
		%>
	</div>
</header>



<script src="${pageContext.request.contextPath}/js/header.js"></script>
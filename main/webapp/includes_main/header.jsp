<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<header class="top-bar">
    <div class="top-bar-left">
        <button class="nav-circle-btn">
        	<span class="material-symbols-outlined">chevron_left</span>
        </button>
        <button class="nav-circle-btn">
        	<span class="material-symbols-outlined">chevron_right</span>
        </button>
    </div>

    <div class="top-bar-center">
        <a href="${pageContext.request.contextPath}/home" style="text-decoration: none;">
	        <button class="home-circle-btn">
	            <span class="material-symbols-outlined">home</span>
	        </button>
    	</a>
    	
        <div class="search-box">
            <span class="material-symbols-outlined">search</span>
            <input type="text" placeholder="Bạn muốn phát nội dung gì?">
            <span class="material-symbols-outlined browse-icon">folder_open</span>
        </div>
    </div>

    <div class="top-bar-right">
        <button class="icon-btn"><span class="material-symbols-outlined">notifications</span></button>
        <div class="header-right-icon avatar" id="avatarContainer">
            <a href="javascript:void(0)" class="useraccount-btn" id="avatarBtn">
                <img src="${pageContext.request.contextPath}/assets/img/avt2.jpg" alt="A">
            </a>
            <div id="userDropdown" class="user-dropdown-menu">
                <ul class="user-menu-list">
                    <li class="user-menu-item"><a href="${pageContext.request.contextPath}/login" class="menu-link">Tài khoản</a></li>
                    <li class="user-menu-item"><a href="${pageContext.request.contextPath}/profile" class="menu-link">Profile</a></li>
                    <li class="user-menu-item divider"></li>
                    <li class="user-menu-item"><a href="${pageContext.request.contextPath}/logout" class="menu-link logout">Đăng Xuất</a></li>
                </ul>
            </div>
        </div>
    </div>
</header>
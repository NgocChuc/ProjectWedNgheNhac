<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
<div class="sidebar" id="library-sidebar">
    <div class="sidebar-header">
        <div class="header-left" onclick="toggleSidebar()" title="Thu gọn / Mở rộng">
            <svg class="library-icon" xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#e3e3e3">
                <path d="M500-360q42 0 71-29t29-71v-220h120v-80H560v220q-13-10-28-15t-32-5q-42 0-71 29t-29 71q0 42 29 71t71 29ZM320-240q-33 0-56.5-23.5T240-320v-480q0-33 23.5-56.5T320-880h480q33 0 56.5 23.5T880-800v480q0 33-23.5 56.5T800-240H320Zm0-80h480v-480H320v480ZM160-80q-33 0-56.5-23.5T80-160v-560h80v560h560v80H160Zm160-720v480-480Z" />
            </svg>
            <span class="header-title">Thư viện của bạn</span>
        </div>
    </div>

    <div class="library-list">

        <div class="list-item">
            <div class="img-box liked-songs">
                <img src="${pageContext.request.contextPath}/assets/img/flist2.jpg" alt="Liked" onerror="this.style.display='none'">
                <i class="fa-solid fa-heart" style="margin:auto; display: none;"></i>
            </div>
            <div class="text-info">
                <div class="main-title highlight">Bài hát đã thích</div>
                <div class="sub-title">
                    <i class="fa-solid fa-thumbtack"></i> Danh sách phát • 150 bài hát
                </div>
            </div>
        </div>

        <div class="list-item">
            <div class="img-box">
                <img src="${pageContext.request.contextPath}/assets/img/avt5.jpg" alt="Playlist">
            </div>
            <div class="text-info">
                <div class="main-title">Danh sách của bạn</div>
                <div class="sub-title">4 danh sách • User A</div>
            </div>
        </div>

        <hr class="list-divider">

        <div class="sidebar-bottom-action">
            <a href="${pageContext.request.contextPath}/create-playlist" class="create-playlist-link" title="Tạo Playlist mới">
                <svg xmlns="http://www.w3.org/2000/svg" height="40px" viewBox="0 -960 960 960" width="40px" fill="#72ceff">
                    <path d="M412-74v-338H74v-136h338v-338h136v338h338v136H548v338H412Z" />
                </svg>
                <span class="btn-text">Tạo Playlist mới</span>
            </a>
        </div>

        <button id="toggleArrowBtn" class="toggle-arrow-btn" onclick="toggleSidebar()" title="Thu gọn / Mở rộng">
            <svg class="arrow-icon" viewBox="0 0 24 24" width="24" height="24">
                <path d="M15.41 16.59L10.83 12L15.41 7.41L14 6L8 12L14 18L15.41 16.59Z" fill="#b3b3b3"></path>
            </svg>
        </button>

    </div>
</div>

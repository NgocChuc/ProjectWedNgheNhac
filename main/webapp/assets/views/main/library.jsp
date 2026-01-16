<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thư viện cá nhân - SOUNDWAVE</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700;900&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Spline+Sans:wght@300;500;700&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">

    <style>
        /* --- CSS GRID THƯ VIỆN --- */
        .grid-section { padding: 2rem 30px; margin-top: 20px; }
        .section-title { color: #ffffff; font-size: 1.8rem; font-weight: 700; margin-bottom: 2rem; }
        
        .card-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 24px;
        }

        .music-card {
            position: relative;
            display: flex;
            flex-direction: column;
            gap: 12px;
            padding: 16px;
            border-radius: 8px;
            background-color: #181818;
            transition: all 0.3s ease;
            cursor: pointer;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }

        .music-card:hover { background-color: #282828; transform: translateY(-5px); }
        
        /* Nút ba chấm */
        .more-options-btn {
            position: absolute;
            top: 20px;
            right: 20px;
            z-index: 5;
            color: #fff;
            background: rgba(0,0,0,0.6);
            border-radius: 50%;
            width: 32px;
            height: 32px;
            display: none; /* Hiện khi hover card */
            align-items: center;
            justify-content: center;
            border: none;
            cursor: pointer;
        }
        
        .music-card:hover .more-options-btn { display: flex; }

        .card-img {
            width: 100%;
            aspect-ratio: 1 / 1; 
            object-fit: cover; 
            border-radius: 6px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.5);
        }

        .card-title {
            color: #ffffff; font-weight: 700; font-size: 1.1rem; margin: 0;
            white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
        }

        .card-subtitle { color: #b3b3b3; font-size: 0.9rem; margin: 0; }

        /* Context Menu (Menu hiện ra khi bấm ba chấm) */
        .context-menu {
            display: none;
            position: absolute;
            background: #282828;
            border: 1px solid #404040;
            border-radius: 4px;
            min-width: 150px;
            z-index: 1000;
            box-shadow: 0 8px 16px rgba(0,0,0,0.5);
        }

        .context-menu ul { list-style: none; margin: 0; padding: 5px 0; }
        .context-menu li {
            padding: 10px 15px;
            color: #e0e0e0;
            font-size: 14px;
            cursor: pointer;
        }
        .context-menu li:hover { background: #3e3e3e; color: #fff; }
        .context-menu li.delete-opt { color: #ff5555; }

        /* Modal Chỉnh sửa */
        .modal {
            display: none;
            position: fixed;
            z-index: 9999;
            left: 0; top: 0; width: 100%; height: 100%;
            background-color: rgba(0,0,0,0.8);
            align-items: center; justify-content: center;
        }
        .modal-content {
            background-color: #282828;
            padding: 24px;
            border-radius: 8px;
            width: 400px;
            color: white;
        }
        .modal-header { font-size: 1.2rem; font-weight: 700; margin-bottom: 20px; }
        .modal-body input {
            width: 100%;
            padding: 12px;
            background: #3e3e3e;
            border: 1px solid transparent;
            border-radius: 4px;
            color: white;
            margin-bottom: 20px;
        }
        .modal-footer { display: flex; justify-content: flex-end; gap: 10px; }
        .btn-cancel { background: none; border: none; color: white; cursor: pointer; }
        .btn-save { background: #1db954; border: none; padding: 8px 20px; border-radius: 20px; font-weight: 700; cursor: pointer; }

        #main-view-container { padding-bottom: 120px; }
    </style>
</head>

<body>
    <jsp:include page="/assets/views/common/header.jsp" />

    <div class="main-content-wrapper layout-with-sidebar">
        <jsp:include page="/assets/views/common/sidebar.jsp" />

        <div class="main-content" style="background: linear-gradient(180deg, #222222 0%, #121212 400px); overflow-y: auto;">
            <div id="main-view-container">
                <section class="grid-section">
                    <h2 class="section-title">Thư viện của bạn</h2>
                    
                    <div class="card-grid">
                        <div class="music-card" onclick="location.href='${pageContext.request.contextPath}/liked_songs'">
                            <img class="card-img" src="${pageContext.request.contextPath}/assets/ima/flist2.jpg" alt="Liked Songs">
                            <div class="card-info">
                                <p class="card-title">Bài hát yêu thích</p>
                                <p class="card-subtitle">Playlist • Hệ thống</p>
                            </div>
                        </div>

                        <c:forEach items="${myPlaylists}" var="p">
                            <div class="music-card">
                                <button class="more-options-btn" onclick="showMenu(event, '${p.id}', '${p.name}')">
                                    <span class="material-symbols-outlined">more_vert</span>
                                </button>
                                
                                <div onclick="location.href='${pageContext.request.contextPath}/your_episodes?id=${p.id}'">
                                    <img class="card-img" src="${pageContext.request.contextPath}/assets/ima/a08.jpg" alt="${p.name}">
                                    <div class="card-info">
                                        <p class="card-title">${p.name}</p>
                                        <p class="card-subtitle">Tạo bởi ${sessionScope.user.userName}</p>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </section>
            </div>
            <jsp:include page="/assets/views/main/lyrics.jsp" />
        </div>
    </div>

    <div id="custom-menu" class="context-menu">
        <ul>
            <li onclick="handleEdit()">Đổi tên</li>
            <li class="delete-opt" onclick="handleDelete()">Xóa playlist</li>
        </ul>
    </div>

    <div id="editModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">Chỉnh sửa chi tiết</div>
            <div class="modal-body">
                <input type="text" id="newPlaylistName" placeholder="Tên playlist mới">
            </div>
            <div class="modal-footer">
                <button class="btn-cancel" onclick="closeModal()">Hủy</button>
                <button class="btn-save" onclick="saveRename()">Lưu</button>
            </div>
        </div>
    </div>

    <jsp:include page="/assets/views/common/footer.jsp" />

    <script>
        let selectedPlaylistId = null;
        let selectedPlaylistName = '';

        function showMenu(event, id, name) {
            event.preventDefault();
            event.stopPropagation();
            selectedPlaylistId = id;
            selectedPlaylistName = name;

            const menu = document.getElementById('custom-menu');
            menu.style.display = 'block';
            menu.style.left = event.pageX + 'px';
            menu.style.top = event.pageY + 'px';
        }

        // Đóng menu khi bấm ra ngoài
        window.addEventListener('click', function() {
            document.getElementById('custom-menu').style.display = 'none';
        });

        function handleEdit() {
            document.getElementById('newPlaylistName').value = selectedPlaylistName;
            document.getElementById('editModal').style.display = 'flex';
        }

        function closeModal() {
            document.getElementById('editModal').style.display = 'none';
        }

        function saveRename() {
            const newName = document.getElementById('newPlaylistName').value;
            if (newName.trim() !== "") {
                window.location.href = "${pageContext.request.contextPath}/rename-playlist?id=" + selectedPlaylistId + "&name=" + encodeURIComponent(newName);
            }
        }

        function handleDelete() {
            if (confirm("Bạn có chắc muốn xóa playlist '" + selectedPlaylistName + "' không?")) {
            	const url = "${pageContext.request.contextPath}/delete-playlist?id=" + selectedPlaylistId;
                console.log("Redirecting to: " + url);
                window.location.href = url;
            }
        }
    </script>
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${playlist.name} - SOUNDWAVE</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700;900&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">

    <style>
        /* --- CẤU TRÌNH WHITE THEME (NỀN TRẮNG) --- */
        .main-content {
            background:#080137; /* Đổi nền sang trắng */
            color: #121212 !important;     /* Chữ màu tối */
            overflow-y: auto;
            height: 100vh;
        }

        /* Header thông tin Playlist */
        .playlist-header-detail {
            padding: 60px 30px 30px;
            display: flex;
            align-items: flex-end;
            gap: 30px;
           background: linear-gradient(6deg,rgba(60, 118, 194, 1) 0%, rgba(111, 111, 217, 1) 49%, rgba(172, 238, 250, 1) 100%);
        }

        .playlist-cover-big {
            width: 230px;
            height: 230px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.15);
            border-radius: 8px;
            object-fit: cover;
        }

        .playlist-text-info h1 {
            font-size: 4rem;
            font-weight: 900;
            margin: 10px 0;
            color: #121212;
        }

        .playlist-text-info p {
            color: #555;
            font-weight: 500;
        }

        /* Thanh điều khiển */
        .controls-bar {
            padding: 20px 30px;
            display: flex;
            align-items: center;
        }

        .play-button-main {
            width: 56px;
            height: 56px;
            border-radius: 50%;
            background-color: #86B6F6; /* Màu chủ đạo của bạn */
            border: none;
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
            box-shadow: 0 4px 12px rgba(134, 182, 246, 0.4);
        }

        .play-button-main:hover {
            transform: scale(1.05);
            background-color: #a5ccff;
        }

        .play-button-main span {
            font-size: 32px;
            color: #000;
            font-variation-settings: 'FILL' 1;
        }

        /* Bảng danh sách bài hát */
        .song-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            padding: 0 20px;
        }

        .song-table th {
            text-align: left;
            padding: 12px 20px;
            color: #888;
            font-size: 0.85rem;
            border-bottom: 1px solid #eee;
            text-transform: uppercase;
        }

        .song-row {
            transition: background 0.2s;
            cursor: pointer;
            border-radius: 4px;
        }

        .song-row:hover {
            background-color: #f5f5f5 !important;
        }

        .song-row td {
            padding: 12px 20px;
            color: #121212;
        }

        .song-info-wrapper {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .song-thumb-small {
            width: 40px;
            height: 40px;
            border-radius: 4px;
        }

        .song-title {
            font-weight: 600;
        }

        .song-artist {
            color: #666;
            font-size: 0.9rem;
        }

        .btn-more-dark {
            color: #888;
            background: none;
            border: none;
            cursor: pointer;
        }

        /* Tùy chỉnh vùng cuộn không bị Player che */
        #main-view-container {
            padding-bottom: 120px;
        }
    </style>
</head>

<body>
    <jsp:include page="/assets/views/common/header.jsp" />

    <div class="main-content-wrapper layout-with-sidebar">
        <jsp:include page="/assets/views/common/sidebar.jsp" />

        <div class="main-content">
            <div id="main-view-container">
                
                <div class="playlist-header-detail">
                    <img src="${pageContext.request.contextPath}/assets/ima/a08.jpg" class="playlist-cover-big" alt="Cover">
                    <div class="playlist-text-info">
                        <p>DANH SÁCH PHÁT</p>
                        <h1>${playlist.name}</h1>
                        <p>${songList.size()} bài hát • Tạo bởi ${sessionScope.user.userName}</p>
                    </div>
                </div>

                <div class="controls-bar">
                    <button class="play-button-main" onclick="playAllFromPlaylist()">
                        <span class="material-symbols-outlined">play_arrow</span>
                    </button>
                </div>

                <table class="song-table">
                    <thead>
                        <tr>
                            <th style="width: 50px">#</th>
                            <th>Tiêu đề</th>
                            <th>Nghệ sĩ</th>
                            <th style="text-align: right; width: 80px;"><span class="material-symbols-outlined">schedule</span></th>
                            <th style="width: 50px"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${songList}" var="s" varStatus="loop">
                            <tr class="song-row" 
                                onclick="loadAndPlay('${s.id}', '${s.title}', '${s.artist}', '${pageContext.request.contextPath}/assets/${s.coverImage}', '${pageContext.request.contextPath}/assets/${s.filename}')">
                                
                                <td style="color: #888">${loop.index + 1}</td>
                                
                                <td>
                                    <div class="song-info-wrapper">
                                        <%-- Lời bài hát ẩn --%>
                                        <textarea id="lyrics-data-${s.id}" style="display: none;">${s.lyrics}</textarea>
                                        
                                        <img src="${pageContext.request.contextPath}/assets/${s.coverImage}" class="song-thumb-small" onerror="this.src='${pageContext.request.contextPath}/assets/ima/a08.jpg'">
                                        <div class="song-title">${s.title}</div>
                                    </div>
                                </td>
                                
                                <td><div class="song-artist">${s.artist}</div></td>
                                
                                <td style="text-align: right; color: #888">--:--</td>
                                
                                <td>
                                    <button class="btn-more-dark">
                                        <span class="material-symbols-outlined">more_horiz</span>
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <jsp:include page="/assets/views/main/lyrics.jsp" />
        </div>
    </div>

    <jsp:include page="/assets/views/common/footer.jsp" />

    <script>
        // 1. Tạo danh sách bài hát hiện có trên trang để Next/Prev
        var currentListOnPage = [
            <c:forEach items="${songList}" var="s" varStatus="status">
            {
                id: '${s.id}',
                title: '${s.title.replace("'", "\\'")}',
                artist: '${s.artist.replace("'", "\\'")}',
                cover: '${pageContext.request.contextPath}/assets/${s.coverImage}',
                src: '${pageContext.request.contextPath}/assets/${s.filename}',
                lyrics: `${s.lyrics}`
            }${!status.last ? ',' : ''}
            </c:forEach>
        ];

        // 2. Hàm phát tất cả bài hát
        function playAllFromPlaylist() {
            if (currentListOnPage.length > 0) {
                // Nạp danh sách vào trình phát toàn cục
                songs = currentListOnPage; 
                songIndex = 0;
                
                // Gọi hàm từ script.js
                loadSong(songIndex);
                playSong();
                
                // Cập nhật giao diện phụ
                if (typeof checkFavoriteStatus === 'function') checkFavoriteStatus(songs[0].id);
            } else {
                alert("Playlist này chưa có bài hát nào!");
            }
        }
    </script>
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>
</html>
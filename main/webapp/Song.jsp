<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Music Player</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f5f5f5; }
        .song { border: 1px solid #ddd; padding: 15px; margin: 10px 0; background: #fff; display: flex; }
        .cover { width: 100px; height: 100px; margin-right: 15px; }
        .details { flex: 1; }
        .lyrics { margin-top: 10px; font-size: 0.9em; color: #555; }
        audio { width: 100%; margin-top: 10px; }
    </style>
</head>
<body>
    <h1>Danh sách bài hát</h1>

    <c:forEach var="song" items="${songs}">
        <div class="song">
            <!-- Ảnh cover -->
            <div class="cover">
                <img src="${pageContext.request.contextPath}/${song.coverImage}" alt="${song.title}" width="100" height="100"/>
            </div>

            <!-- Thông tin và audio player -->
            <div class="details">
                <h3>${song.title} - ${song.artist}</h3>
                <p>Thể loại: ${song.genre}</p>

                <!-- Audio player -->
                <audio controls>
                    <source src="${pageContext.request.contextPath}/${song.filename}" type="audio/mpeg">
                    Trình duyệt của bạn không hỗ trợ audio.
                </audio>

                <!-- Lyrics -->
                <div class="lyrics">
                    <strong>Lời bài hát:</strong><br/>
                    ${song.lyrics}
                </div>
            </div>
        </div>
    </c:forEach>
</body>
</html>

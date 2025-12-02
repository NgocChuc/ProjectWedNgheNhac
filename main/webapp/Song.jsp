<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách bài hát</title>
</head>
<body>

<h2>Danh sách bài hát</h2>

<c:if test="${empty songs}">
    <p>Không có bài hát nào.</p>
</c:if>

<c:if test="${not empty songs}">
    <table border="1" cellpadding="10">
        <tr>
            <th>ID</th>
            <th>Tiêu đề</th>
            <th>Nghệ sĩ</th>
            <th>Thể loại</th>
            <th>Lượt xem</th>
            <th>Ảnh bìa</th>
            <th>Nghe</th>
        </tr>

        <c:forEach var="s" items="${songs}">
            <tr>
                <td>${s.id}</td>
                <td>${s.title}</td>
                <td>${s.artist}</td>
                <td>${s.genre}</td>

                <td>
                    <img src="${pageContext.request.contextPath}/${s.coverImage}" width="80">
                </td>

                <td>
                    <audio controls>
                        <source src="${pageContext.request.contextPath}/${s.filename}" type="audio/mpeg">
                    </audio>
                </td>
            </tr>
        </c:forEach>
    </table>
</c:if>

</body>
</html>

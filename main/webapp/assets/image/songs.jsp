<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Model_Layer.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách bài hát</title>
    <style>
        table { border-collapse: collapse; width: 80%; }
        th, td { border: 1px solid #333; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        tr:nth-child(even) { background-color: #f9f9f9; }
    </style>
</head>
<body>
<h2>Danh sách bài hát</h2>

<%
    List<Song> list = (List<Song>) request.getAttribute("songs");
    if (list == null) {
%>
<p>List = null</p>
<%
    } else if (list.isEmpty()) {
%>
<p>Danh sách rỗng</p>
<%
    } else {
%>

<table>
    <tr>
        <th>STT</th>
        <th>Tiêu đề</th>
        <th>Nghệ sĩ</th>
        <th>Genre</th>
        <th>Lượt xem</th>
    </tr>
<%
        int stt = 1;
        for (Song s : list) {
%>
    <tr>
        <td><%= stt++ %></td>
        <td><%= s.getTitle() %></td>
        <td><%= s.getArtist() %></td>
        <td><%= s.getGenre() %></td>
        <td><%= s.getViews() %></td>
    </tr>
<%
        }
%>
</table>

<%
    }
%>

</body>
</html>

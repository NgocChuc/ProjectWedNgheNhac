<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Playlist" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SOUNDWAVE</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Spline+Sans:wght@300;500;700&display=swap" rel="stylesheet" />
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>

<body>

    <input type="hidden" id="isLoggedIn" value="true">

    <jsp:include page="JSP/header.jsp" />

    <div class="main-content-wrapper">

        <jsp:include page="JSP/sidebar.jsp" />

        <div class="main-content">
            
            <div class="image-carousel">
                <div class="carousel-track" id="carouselTrack">
                    <div class="carousel-item"><img src="${pageContext.request.contextPath}/assets/img/b1.jpg" alt="Banner 1"></div>
                    <div class="carousel-item"><img src="${pageContext.request.contextPath}/assets/img/b2.jpg" alt="Banner 2"></div>
                    <div class="carousel-item"><img src="${pageContext.request.contextPath}/assets/img/b3.jpg" alt="Banner 3"></div>
                </div>
            </div>

            <section class="grid-section">
                <h2 class="section-title">Khám phá thể loại</h2>
                <div class="carousel-wrapper">
                    <button class="arrow-btn left-arrow" onclick="scrollCards(this, -1)">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 -960 960 960"><path d="M400-80 0-480l400-400 71 71-329 329 329 329-71 71Z" /></svg>
                    </button>
                    <div class="scroll-container">
                        <div class="card-grid">
                            
                            <% 
                               
                                List<Playlist> genres = (List<Playlist>) request.getAttribute("dataGenres");
                                                            
                                if (genres != null) {
                                    for (Playlist p : genres) {
                            %>
                                <div class="music-card">
                                    <img class="card-img" src="${pageContext.request.contextPath}/<%= p.getImageUrl() %>" alt="<%= p.getName() %>">
                                    <div class="card-info">
                                        <p class="card-title"><%= p.getName() %></p>
                                        <p class="card-subtitle"><%= p.getDescription() %></p>
                                    </div>
                                </div>
                            <% 
                                    } 
                                } 
                            %>

                        </div>
                    </div>
                    <button class="arrow-btn right-arrow" onclick="scrollCards(this, 1)">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 -960 960 960"><path d="m321-80-71-71 329-329-329-329 71-71 400 400-400 400Z" /></svg>
                    </button>
                </div>
            </section>


            <section class="grid-section">
                <h2 class="section-title">Danh sách của bạn</h2>
                <div class="carousel-wrapper">
                    <button class="arrow-btn left-arrow" onclick="scrollCards(this, -1)">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 -960 960 960"><path d="M400-80 0-480l400-400 71 71-329 329 329 329-71 71Z" /></svg>
                    </button>
                    <div class="scroll-container">
                        <div class="card-grid">
                            
                            <% 
                                // Lấy danh sách thứ 2
                                List<Playlist> myLists = (List<Playlist>) request.getAttribute("dataMyPlaylists");
                                
                                if (myLists != null) {
                                    for (Playlist p : myLists) {
                            %>
                                <div class="music-card">
                                    <img class="card-img" src="${pageContext.request.contextPath}/<%= p.getImageUrl() %>" alt="Playlist">
                                    <div class="card-info">
                                        <p class="card-title"><%= p.getName() %></p>
                                        <p class="card-subtitle">Playlist • <%= p.getDescription() %></p>
                                    </div>
                                </div>
                            <% 
                                    }
                                }
                            %>
                            
                        </div>
                    </div>
                    <button class="arrow-btn right-arrow" onclick="scrollCards(this, 1)">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 -960 960 960"><path d="m321-80-71-71 329-329-329-329 71-71 400 400-400 400Z" /></svg>
                    </button>
                </div>
            </section>
            
        </div>
    </div>

    <jsp:include page="JSP/footer.jsp" />

    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>
</html>

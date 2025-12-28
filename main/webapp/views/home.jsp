<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>SoundWave - Music Player</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/CSS/spline_Sans.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/CSS/material_symbols.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/CSS/main.css">
</head>
<body>
    <div class="app-layout">
        <jsp:include page="/includes_main/sidebar.jsp" />

        <main class="main-content">
            <jsp:include page="/includes_main/header.jsp" />

            <section class="banner-section">
                <div class="image-carousel">
                    <div class="carousel-track" id="carouselTrack">
                        <div class="carousel-item">
                            <img src="https://picsum.photos/id/102/1200/400" alt="Banner 1">
                        </div>
                        <div class="carousel-item">
                            <img src="https://picsum.photos/id/103/1200/400" alt="Banner 2">
                        </div>
                        <div class="carousel-item">
                            <img src="https://picsum.photos/id/104/1200/400" alt="Banner 3">
                        </div>
                    </div>
                    <button class="carousel-btn prev" onclick="moveSlide(-1)">&#10094;</button>
                    <button class="carousel-btn next" onclick="moveSlide(1)">&#10095;</button>
                </div>
            </section>

            <section class="content-body">
                <div class="featured-row">
                    <div class="featured-card">
                        <div class="img-box" style="background-image: url('https://picsum.photos/id/10/400/250')"></div>
                        <h3>Album of the Week</h3>
                        <p>Artist Name</p>
                    </div>
                    <div class="featured-card">
                        <div class="img-box" style="background-image: url('https://picsum.photos/id/20/400/250')"></div>
                        <h3>Featured Artist Spotlight</h3>
                        <p>Artist Name</p>
                    </div>
                    <div class="featured-card">
                        <div class="img-box" style="background-image: url('https://picsum.photos/id/30/400/250')"></div>
                        <h3>New Major Releases</h3>
                        <p>Various Artists</p>
                    </div>
                </div>
                
                <h2 class="row-title">Top 100 This Week</h2>
                <div class="music-grid">
                    <div class="music-card">
                        <div class="square-img" style="background-image: url('https://picsum.photos/id/40/300/300')"></div>
                        <h4>Hit List</h4>
                        <p>Top hits of the month</p>
                    </div>
                    <div class="music-card">
                        <div class="square-img" style="background-image: url('https://picsum.photos/id/50/300/300')"></div>
                        <h4>Workout Jams</h4>
                        <p>High-energy tracks</p>
                    </div>
                    <div class="music-card">
                        <div class="square-img" style="background-image: url('https://picsum.photos/id/60/300/300')"></div>
                        <h4>Focus</h4>
                        <p>Instrumental beats</p>
                    </div>
                    <div class="music-card">
                        <div class="square-img" style="background-image: url('https://picsum.photos/id/70/300/300')"></div>
                        <h4>Dinner Party</h4>
                        <p>Laid-back tunes</p>
                    </div>
                    <div class="music-card">
                        <div class="square-img" style="background-image: url('https://picsum.photos/id/80/300/300')"></div>
                        <h4>Chill Vibes</h4>
                        <p>Relax and unwind</p>
                    </div>
                </div>
            </section>     
        </main>

        <jsp:include page="/includes_main/player.jsp" />
    </div>
    
    <script src="${pageContext.request.contextPath}/assets/JS/main.js"></script>
</body>
</html>
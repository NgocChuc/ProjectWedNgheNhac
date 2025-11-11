CREATE DATABASE MusicDB;
GO
USE MusicDB;
GO

-- Bảng người dùng
CREATE TABLE Users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(50),
    password NVARCHAR(50),
    role NVARCHAR(10)
);
GO

-- Bảng bài hát
CREATE TABLE Songs (
    id INT IDENTITY(1,1) PRIMARY KEY,
    title NVARCHAR(100),
    artist NVARCHAR(100),
    genre NVARCHAR(50),
    filename NVARCHAR(100),
    mv_link NVARCHAR(255),
    lyrics NVARCHAR(MAX),
    cover_image NVARCHAR(255),
    views INT DEFAULT 0
);
GO

-- Bảng yêu thích
CREATE TABLE Favorites (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT,
    song_id INT,
    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (song_id) REFERENCES Songs(id)
);
GO

INSERT INTO Users(username, password, role)
VALUES (N'admin', N'123', N'admin'),
       (N'long', N'123', N'user');
GO

INSERT INTO Songs(title, artist, genre, filename, mv_link, lyrics, cover_image, views)
VALUES 
(N'Lối Nhỏ', N'Đen Vâu', N'Rap', N'loinho.mp3', N'mv_loinho.mp4', N'...', N'cover_loinho.jpg', 2000),
(N'Chạy Ngay Đi', N'Sơn Tùng M-TP', N'Pop', N'chayngaydi.mp3', N'mv_chayngaydi.mp4', N'...', N'cover_chayngaydi.jpg', 5000);
GO


ALTER LOGIN sa ENABLE;
ALTER LOGIN sa WITH PASSWORD = 'Admin@123' UNLOCK;


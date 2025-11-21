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


ALTER LOGIN sa ENABLE;
ALTER LOGIN sa WITH PASSWORD = 'Admin@123' UNLOCK;


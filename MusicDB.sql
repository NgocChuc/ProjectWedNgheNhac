CREATE DATABASE MusicDB;
GO
USE MusicDB;
GO


-- Bảng người dùng
CREATE TABLE Users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(50),
    email VARCHAR(100) UNIQUE, -- Thêm cột email
    password VARCHAR(50),
    role NVARCHAR(10)
);



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

INSERT INTO Users(username, email, password, role)
VALUES (N'admin', N'admin@example.com', N'123', N'admin'),
       (N'long', N'long@example.com', N'123', N'user');


ALTER LOGIN sa ENABLE;
ALTER LOGIN sa WITH PASSWORD = 'Admin@123' UNLOCK;



-- T-SQL: tạo bảng để lưu token reset (SQL Server)
CREATE TABLE PasswordResetToken (
    id INT IDENTITY(1,1) PRIMARY KEY,
    email NVARCHAR(255) NOT NULL,
    token NVARCHAR(128) NOT NULL UNIQUE,
    expires_at DATETIME2 NOT NULL,
    created_at DATETIME2 NOT NULL DEFAULT GETDATE()
);

-- index để tìm token nhanh
CREATE INDEX IX_PasswordResetToken_Token ON PasswordResetToken(token);
CREATE INDEX IX_PasswordResetToken_Email ON PasswordResetToken(email);


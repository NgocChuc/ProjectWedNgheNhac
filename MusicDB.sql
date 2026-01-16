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
    role VARCHAR(10)
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

-- Lưu lịch sử nghe để tính lượt nghe cá nhân
CREATE TABLE UserMusicHistory (
    id INT IDENTITY(1,1) PRIMARY KEY, -- Sửa lại ở đây
    user_id INT,
    song_id INT,
    listen_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (song_id) REFERENCES Songs(id)
);
GO

CREATE TABLE SavedEpisodes (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT,
    episode_id INT, -- Giả sử bạn có bảng Episodes (Tập phim/Podcast)
    saved_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(id)
);

-- Bảng danh sách phát
CREATE TABLE Playlists (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,            -- Tên playlist
    description NVARCHAR(500),              -- Mô tả (cho phép NULL)
    cover_image NVARCHAR(255),              -- Ảnh bìa (cho phép NULL)
    user_id INT NOT NULL,                   -- Người tạo
    created_at DATETIME DEFAULT GETDATE(),  -- Ngày tạo
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE
);
GO

-- Bảng chứa bài hát trong danh sách phátt (m-m)
CREATE TABLE PlaylistSongs (
    id INT IDENTITY(1,1) PRIMARY KEY,
    playlist_id INT NOT NULL,
    song_id INT NOT NULL,
    FOREIGN KEY (playlist_id) REFERENCES Playlists(id) ON DELETE CASCADE,
    FOREIGN KEY (song_id) REFERENCES Songs(id) ON DELETE CASCADE
);
GO

CREATE TABLE Favorites (
    id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT,
    song_id INT,
    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (song_id) REFERENCES Songs(id)
);

-- bổ sung cột avatar nếu bảng Users đã tồn tại
ALTER TABLE Users ADD avatar_url NVARCHAR(255) DEFAULT 'default-avt.jpg';

DELETE FROM Users;

INSERT INTO Users (username, email, password, role)
VALUES 
    (N'admin', 'admin@example.com', '123', 'admin'),
    (N'long',  'long@example.com',  '123', 'user');


UPDATE Users SET 
    email = LTRIM(RTRIM(email)), 
    password = LTRIM(RTRIM(password)), 
    role = LTRIM(RTRIM(role));

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


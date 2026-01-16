<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div id="lyrics-view" class="lyrics-view-container">
	<div class="overlay-header">
		<button class="btn-close-lyrics" onclick="LyricsManager.hide()">
			<span class="material-symbols-outlined"
				style="vertical-align: middle;">arrow_back</span> Quay lại
		</button>
	</div>

	<div class="overlay-content">
		
		<div id="overlay-lyrics-text" class="overlay-lyrics-box"></div>
	</div>
</div>

<style>
/* CSS MỚI CHO CHẾ ĐỘ SWITCH VIEW */
.lyrics-view-container {
	/* Không dùng Fixed nữa, dùng Relative để nằm gọn trong main-content */
	position: relative;
	width: 100%;
	height: 100%; /* Chiếm hết chiều cao main-content */
	position: absolute;
	/* Màu nền Gradient */
	background: linear-gradient(8deg, rgba(0, 0, 0, 1) 0%, rgba(0, 0, 74, 1)
		66%, rgba(0, 130, 156, 1) 100%);
	/* Mặc định ẩn */
	display: none;
	flex-direction: column;
	/* Animation hiện ra nhẹ nhàng */
	animation: fadeIn 0.3s ease-in-out;
	/* Padding dưới để tránh Footer */
	padding-bottom: 120px;
	box-sizing: border-box;
	z-index: 10;
}

@
keyframes fadeIn {from { opacity:0;
	
}

to {
	opacity: 1;
}

}

/* Các class con giữ nguyên style cũ */
.overlay-header {
	padding: 20px 30px;
}

.btn-close-lyrics {
	background: rgba(255, 255, 255, 0.1);
	border: none;
	color: white;
	font-size: 50px;
	cursor: pointer;
	display: flex;
	align-items: left;
	gap: 8px;
	padding: 8px 16px;
	border-radius: 30px;
	font-weight: 600;
}

.btn-close-lyrics:hover {
	background: rgba(255, 255, 255, 0.2);
}

.overlay-content {
	text-align: center;
	padding: 20px;
	max-width: 800px;
	margin: 0 auto;
}

.overlay-cover {
	width: 120px;
	height: 120px;
	border-radius: 8px;
	margin-bottom: 20px;
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.4);
}

#overlay-title {
	font-size: 24px;
	color: white;
	margin: 0 0 5px 0;
}

#overlay-artist {
	font-size: 16px;
	color: #b3b3b3;
	margin: 0 0 30px 0;
}

.overlay-lyrics-box {
	color: #fff;
	font-size: 50px;
	font-weight: 700;
	align-items: left;
	line-height: 1.6;
	white-space: pre-wrap;
}
</style>

<script>
	var currentActiveSongId = null;
	const LyricsManager = {
		isOpen : false,

		show : function(songId) {
			// Ưu tiên lấy ID truyền vào, nếu không có thì lấy ID bài đang phát
			var targetId = songId || currentActiveSongId;

			console.log("--- BẮT ĐẦU TÌM LYRICS ---");
			console.log("Target ID:", targetId);

			if (!targetId) {
				console.error("Lỗi: Không có ID bài hát nào được chọn.");
				alert("Vui lòng phát một bài hát trước!");
				return;
			}

			// 1. Tìm thẻ chứa lời
			var elementId = "lyrics-data-" + targetId;
			var hiddenEl = document.getElementById(elementId);

			var lyricsText = "";

			if (hiddenEl) {
				console.log("Đã tìm thấy thẻ HTML chứa lời:", hiddenEl);
				lyricsText = hiddenEl.value; // Lấy giá trị trong textarea
			} else {
				console.error("LỖI: Không tìm thấy thẻ có ID là " + elementId);
				console
						.log("Gợi ý: Kiểm tra lại xem trong file JSP, thẻ textarea có id đúng là 'lyrics-data-"
								+ targetId + "' không?");
			}

			// 2. Lấy thông tin Footer
			var footerImg = document.querySelector('.footer-player img');
			var footerTitle = document
					.querySelector('.footer-player .song-name');
			var footerArtist = document
					.querySelector('.footer-player .song-artist');

			// Gán dữ liệu vào Overlay
			if (footerImg)
				document.getElementById('overlay-img').src = footerImg.src;
			if (footerTitle)
				document.getElementById('overlay-title').innerText = footerTitle.innerText;
			if (footerArtist)
				document.getElementById('overlay-artist').innerText = footerArtist.innerText;

			// Gán Lời
			var textBox = document.getElementById('overlay-lyrics-text');
			if (lyricsText && lyricsText.trim() !== "") {
				textBox.innerText = lyricsText;
			} else {
				textBox.innerText = "Chưa có lời bài hát (Database trả về rỗng hoặc chưa cập nhật).";
			}

			// 3. Hiện giao diện
			const mainView = document.getElementById('main-view-container');
			if (mainView)
				mainView.style.display = 'none';

			const lyricsView = document.getElementById('lyrics-view');
			if (lyricsView) {
				lyricsView.style.display = 'flex';
				lyricsView.scrollTop = 0;
			}

			this.isOpen = true;
		},

		// HÀM ẨN LYRICS (Hiện lại Main View)
		hide : function() {
			// 1. Ẩn khung Lyrics
			const lyricsView = document.getElementById('lyrics-view');
			if (lyricsView) {
				lyricsView.style.display = 'none';
			}

			// 2. Hiện lại nội dung chính
			const mainView = document.getElementById('main-view-container');
			if (mainView) {
				mainView.style.display = 'block'; // Hoặc 'flex' tùy vào layout gốc của bạn
			}

			// Cập nhật trạng thái
			this.isOpen = false;

			// Bỏ màu nút ở Footer
			const btn = document.getElementById('btn-lyrics');
			if (btn)
				btn.classList.remove('active-btn');
		},

		// HÀM BẬT/TẮT
		toggle : function(songId) {
			if (this.isOpen) {
				this.hide();
			} else {
				this.show(songId);
			}
		},

		// HÀM CẬP NHẬT KHI CHUYỂN BÀI (Nếu đang mở lyrics)
		updateIfOpen : function(songId) {
			if (this.isOpen) {
				this.show(songId);
			}
		}
	};
</script>
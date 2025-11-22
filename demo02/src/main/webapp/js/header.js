// header.js

document.addEventListener('DOMContentLoaded', function() {
    // ... (Giữ nguyên logic Thông báo) ...
    const notificationBtn = document.getElementById('notificationBtn');
    const notificationDropdown = document.getElementById('notificationsDropdown');
    
    // --- LỚP MỚI CHO AVATAR MENU ---
    const avatarBtn = document.getElementById('avatarBtn'); 
    const userDropdown = document.getElementById('userDropdown'); 

    // Logic cho nút Thông báo
    if (notificationBtn && notificationDropdown) {
        notificationBtn.addEventListener('click', function(event) {
            event.stopPropagation(); 
            // Đóng menu Avatar nếu đang mở
            if (userDropdown && userDropdown.classList.contains('show')) {
                 userDropdown.classList.remove('show');
            }
            notificationDropdown.classList.toggle('show');
            this.blur();
        });
    }

	// Logic cho nút Avatar
	    if (avatarBtn && userDropdown) {
	        avatarBtn.addEventListener('click', function(event) {
	            // LỆNH QUAN TRỌNG: NGĂN CHẶN TRÌNH DUYỆT CHUYỂN TRANG
	            event.preventDefault(); 
	            
	            // LỆNH QUAN TRỌNG: NGĂN CHẶN SỰ KIỆN LAN TRUYỀN (propagation)
	            event.stopPropagation();
	            
	            // Đóng menu Thông báo nếu đang mở (Đảm bảo logic này hoạt động)
	            const notificationDropdown = document.getElementById('notificationsDropdown');
	            if (notificationDropdown && notificationDropdown.classList.contains('show')) {
	                 notificationDropdown.classList.remove('show');
	            }
	            
	            // Hiển thị/Ẩn menu Avatar
	            userDropdown.classList.toggle('show');
	        });
	    }

    // Hàm đóng dropdown khi click ra ngoài (Áp dụng cho cả hai)
    document.addEventListener('click', function(event) {
        // Đóng menu Thông báo
        if (notificationDropdown && notificationDropdown.classList.contains('show') && !notificationBtn.contains(event.target) && !notificationDropdown.contains(event.target)) {
            notificationDropdown.classList.remove('show');
        }
        
        // Đóng menu Avatar
        if (userDropdown && userDropdown.classList.contains('show') && !avatarBtn.contains(event.target) && !userDropdown.contains(event.target)) {
            userDropdown.classList.remove('show');
        }
    });
});
// --- Sidebar Toggle ---
function toggleSidebar() {
    const sidebar = document.getElementById('library-sidebar');
    const arrowBtn = document.getElementById('toggleArrowBtn');

    if (sidebar) {
        sidebar.classList.toggle('collapsed');
        if (arrowBtn) {
            const icon = arrowBtn.querySelector('.arrow-icon');
            if (sidebar.classList.contains('collapsed')) {
                icon.style.transform = 'rotate(180deg)';
            } else {
                icon.style.transform = 'rotate(0deg)';
            }
        }
    }
}

// --- Card Scroll (Arrow Button) ---
function scrollCards(button, direction) {
    const wrapper = button.parentElement;
    const container = wrapper.querySelector('.scroll-container');

    if (container) {
        // Scroll amount = width of container * 0.7
        const scrollAmount = container.offsetWidth * 0.7;
        container.scrollBy({
            left: direction * scrollAmount,
            behavior: 'smooth'
        });
    }
}

document.addEventListener('DOMContentLoaded', function () {
    // --- Header Dropdown Logic ---
    const notificationBtn = document.getElementById('notificationBtn');
    const notificationsDropdown = document.getElementById('notificationsDropdown');
    const userAvatarBtn = document.querySelector('.useraccount-btn');
    const userDropdown = document.getElementById('userDropdown');

    if (notificationBtn) {
        notificationBtn.addEventListener('click', function (event) {
            event.stopPropagation();
            notificationsDropdown.classList.toggle('show');
            if (userDropdown && userDropdown.classList.contains('show')) userDropdown.classList.remove('show');
        });
    }

    if (userAvatarBtn) {
        userAvatarBtn.addEventListener('click', function (event) {
            event.preventDefault();
            event.stopPropagation();
            userDropdown.classList.toggle('show');
            if (notificationsDropdown && notificationsDropdown.classList.contains('show')) notificationsDropdown.classList.remove('show');
        });
    }

    document.addEventListener('click', function () {
        if (notificationsDropdown) notificationsDropdown.classList.remove('show');
        if (userDropdown) userDropdown.classList.remove('show');
    });

    // --- Carousel Autoplay Script ---
    const track = document.getElementById('carouselTrack');
    const items = track ? track.getElementsByClassName('carousel-item') : [];

    if (items.length > 0) {
        const totalItems = items.length;
        let currentIndex = 0;
        const intervalTime = 3000; // 3s

        function updateCarousel() {
            // Since track width is 300%, each move is -33.33% relative to total width, 
            // or simply -100% relative to single item width if controlled differently.
            // Here we use percentage offset based on number of items.
            const offset = -currentIndex * (100 / totalItems);
            track.style.transform = `translateX(${offset}%)`;
            currentIndex = (currentIndex + 1) % totalItems;
        }
        setInterval(updateCarousel, intervalTime);
    }

    // --- Drag-Scroll for Card Grid ---
    const containers = document.querySelectorAll('.scroll-container');

    containers.forEach(container => {
        let isDown = false;
        let startX;
        let scrollLeft;

        container.addEventListener('mousedown', (e) => {
            isDown = true;
            container.classList.add('active-drag');
            startX = e.pageX - container.offsetLeft;
            scrollLeft = container.scrollLeft;
        });

        container.addEventListener('mouseleave', () => {
            isDown = false;
            container.classList.remove('active-drag');
        });

        container.addEventListener('mouseup', () => {
            isDown = false;
            container.classList.remove('active-drag');
        });

        container.addEventListener('mousemove', (e) => {
            if (!isDown) return;
            e.preventDefault();
            const x = e.pageX - container.offsetLeft;
            const walk = (x - startX) * 1.5; // Drag speed
            container.scrollLeft = scrollLeft - walk;
        });
    });
});
document.addEventListener('DOMContentLoaded', function () {
    const pwd = document.getElementById('password');
    const toggle = document.getElementById('passwordToggle');
    const icon = toggle.querySelector('.eye-icon');

    toggle.addEventListener('click', function () {
        if (pwd.type === 'password') {
            pwd.type = 'text';
            icon.classList.add('show-password');
        } else {
            pwd.type = 'password';
            icon.classList.remove('show-password');
        }
    });
});

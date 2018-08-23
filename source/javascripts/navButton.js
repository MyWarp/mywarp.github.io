var menuButton = document.getElementById('menu-button');
var menuNav = document.getElementById('site-nav');
menuButton.addEventListener('click', function (e) {
    menuButton.classList.toggle('is-active');
    menuNav.classList.toggle('is-active');
    e.preventDefault();
});
var menuButton = document.getElementById('menu-button');
var menuNav = document.getElementById('main-navigation');
menuButton.addEventListener('click', function(e) {
  menuButton.classList.toggle('is-active');
  menuNav.classList.toggle('is-active');
  document.body.classList.toggle('noscroll');
  e.preventDefault();
});
var menuButton=document.getElementById("menu-button"),menuNav=document.getElementById("main-navigation");menuButton.addEventListener("click",function(t){menuButton.classList.toggle("is-active"),menuNav.classList.toggle("is-active"),document.body.classList.toggle("noscroll"),t.preventDefault()});
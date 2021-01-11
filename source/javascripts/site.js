var bodyStyle = getComputedStyle(document.body);
var menuButton = document.getElementById('menu-button');
var menuNav = document.getElementById('main-navigation');

menuButton.addEventListener('click', function(e) {
    menuButton.classList.toggle('is-active');
    menuNav.classList.toggle('is-active');
    document.body.classList.toggle('noscroll');
    e.preventDefault();
});

function setup_particles() {
    var color_var = bodyStyle.getPropertyValue('--particles-color').trim();

    tsParticles.loadJSON('site-canvas', 'default.json')
        .then((container) => {
            container.options.load({
                particles: {
                    color: {
                        value: color_var
                    },
                    line_linked: {
                        color: {
                            value: color_var
                        }
                    }
                }
            });
            container.refresh();
        })
        .catch((error) => {
            console.error(error)
        })
}
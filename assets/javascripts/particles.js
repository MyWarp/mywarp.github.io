import { tsParticles } from "tsparticles";

var bodyStyle = getComputedStyle(document.body);
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
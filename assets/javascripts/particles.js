import { tsParticles } from "tsparticles";
var bodyStyle = getComputedStyle(document.body);
var color_var = bodyStyle.getPropertyValue('--particles-color').trim();
tsParticles.load('site-canvas', {
  "particles": {
    "number": {
      "value": 100,
      "density": {
        "enable": true,
        "value_area": 2500
      }
    },
    "color": {
      "value": color_var
    },
    "shape": {
      "type": "circle",
      "stroke": {
        "width": 0,
        "color": color_var
      },
      "polygon": {
        "nb_sides": 5
      }
    },
    "opacity": {
      "value": 0.5,
      "random": false
    },
    "size": {
      "value": 3,
      "random": true,
      "anim": {
        "enable": false,
        "speed": 40,
        "size_min": 0.1,
        "sync": false
      }
    },
    "line_linked": {
      "enable": true,
      "distance": 180,
      "color": color_var,
      "opacity": 0.4,
      "width": 1
    },
    "move": {
      "enable": true,
      "speed": 1.5,
      "direction": "none",
      "random": false,
      "straight": false,
      "out_mode": "out",
      "bounce": false,
      "attract": {
        "enable": true,
        "rotateX": 600,
        "rotateY": 1200
      }
    }
  },
  "retina_detect": true
}).catch((error) => {
  console.error(error)
});
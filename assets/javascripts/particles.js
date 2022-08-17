import { tsParticles } from "tsparticles-engine";
import { loadLinksPreset } from "tsparticles-preset-links";

document.addEventListener('DOMContentLoaded', initParticles(), false);
window.matchMedia("(prefers-color-scheme: dark)").addEventListener("change", () => { loadParticles(); });

async function initParticles() {
  await loadLinksPreset(tsParticles);
  await loadParticles();
}

async function loadParticles() {
  var particleColor = getComputedStyle(document.body).getPropertyValue('--particles-color').trim();
  console.error(particleColor);
  await tsParticles.load("site-canvas", {
    "background": {
        "color": "transparent",
    },
    "particles": {
      "number": {
        "value": 100,
        "density": {
          "enable": true,
          "value_area": 2500
        }
      },
      "color": {
        "value": particleColor
      },
      "shape": {
        "type": "circle",
        "stroke": {
          "width": 0,
          "color": particleColor
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
        "distance": 220,
        "color": particleColor,
        "opacity": 0.4,
        "width": 1
      },
      "move": {
        "enable": true,
        "speed": 0.95,
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
    preset: "links",
  })
  .catch((error) => {
      console.error(error)
  });
}
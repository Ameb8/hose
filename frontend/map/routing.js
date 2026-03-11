import { state } from "./state.js";
import { fetchRoute } from "./api.js";


export function drawRoute(routeData) {

  if (state.currentRouteLayer) {
    state.currentRouteLayer.remove();
  }

  const latlngs = routeData.geometry.coordinates.map(coord => [
    coord[1],
    coord[0]
  ]);

  const miles = routeData.distance / 1609.34;

  state.currentRouteLayer = L.polyline(latlngs, {
    color: "blue",
    weight: 5
  }).addTo(state.map);

  state.map.fitBounds(state.currentRouteLayer.getBounds());

  state.currentRouteLayer.bindPopup(`
    <strong>Distance:</strong> ${miles.toFixed(2)} miles<br>
    <strong>Duration:</strong> ${(routeData.duration / 60).toFixed(1)} minutes
  `).openPopup();

  state.currentRouteLayer.on("popupclose", () => {
    if (state.currentRouteLayer) {
      state.currentRouteLayer.remove();
      state.currentRouteLayer = null;
    }
  });
}


function updateRouteButtonStyles() {
  Object.entries(state.routeButtonEls).forEach(([key, btn]) => {
    const active =
      state.routeMode && state.routeTransport === key;

    btn.classList.toggle("active", active);
  });
}

export function clearRoute() {
  if (state.currentRouteLayer) {
    state.currentRouteLayer.remove();
    state.currentRouteLayer = null;
  }
}


export function addRouteControl() {
  const RouteControl = L.Control.extend({
    options: { position: "bottomleft" },

    onAdd: function () {
      const container = L.DomUtil.create("div", "route-control");
      const title = L.DomUtil.create("div", "route-title", container);
      const buttons = L.DomUtil.create("div", "route-button-row", container);
      title.textContent = "Get Directions";

      const modes = [
        { key: "walk", icon: "🚶", label: "Walk" },
        { key: "bike", icon: "🚴", label: "Bike" },
        { key: "car", icon: "🚗", label: "Drive" }
      ];

      modes.forEach(mode => {
        const btn = L.DomUtil.create("button", "route-btn", buttons);

        btn.innerHTML = `
          <span class="route-icon">${mode.icon}</span>
          <span class="route-label">${mode.label}</span>
        `;

        L.DomEvent.disableClickPropagation(btn);

        state.routeButtonEls[mode.key] = btn;

        btn.onclick = function () {
          const isActive =
            state.routeMode && state.routeTransport === mode.key;

          if (isActive) {
            clearRoute();
            setRouteMode(false);
          } else {
            state.routeTransport = mode.key;
            setRouteMode(true);
            updateRouteButtonStyles();
          }
        };
      });

      return container;
    }
  });

  state.map.addControl(new RouteControl());
}


export function setRouteMode(enabled) {
  state.routeMode = enabled;

  if (!enabled) {
    state.routeTransport = null;
  }

  updateRouteButtonStyles();

  if (!enabled) {
    state.selectedFeatures = [];
    state.selectedLayers.forEach(layer => layer.setOpacity(1));
    state.selectedLayers = [];
  }
}
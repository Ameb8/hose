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

  state.currentRouteLayer = L.polyline(latlngs, {
    color: "blue",
    weight: 5
  }).addTo(state.map);

  state.map.fitBounds(state.currentRouteLayer.getBounds());

  state.currentRouteLayer.bindPopup(`
    <strong>Distance:</strong> ${(routeData.distance / 1000).toFixed(2)} km<br>
    <strong>Duration:</strong> ${(routeData.duration / 60).toFixed(1)} minutes
  `).openPopup();
}


function updateRouteButtonStyles() {
  Object.entries(state.routeButtonEls).forEach(([key, btn]) => {
    const active =
      state.routeMode && state.routeTransport === key;

    btn.style.background = active ? "#007bff" : "white";
    btn.style.color = active ? "white" : "black";
  });
}


export function addRouteControl() {
  const RouteControl = L.Control.extend({
    options: { position: "bottomleft" },

    onAdd: function () {
      const container = L.DomUtil.create("div", "route-control");

      const modes = [
        { key: "walk", label: "🚶" },
        { key: "bike", label: "🚴" },
        { key: "car", label: "🚗" }
      ];

      modes.forEach(mode => {
        const btn = L.DomUtil.create("button", "route-btn", container);
        btn.innerHTML = mode.label;

        L.DomEvent.disableClickPropagation(btn);

        state.routeButtonEls[mode.key] = btn;

        btn.onclick = function () {
          const isActive =
            state.routeMode && state.routeTransport === mode.key;

          if (isActive) {
            setRouteMode(false);
            state.routeTransport = null;
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
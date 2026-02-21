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


export function addRouteControl() {

  const RouteControl = L.Control.extend({
    options: { position: "bottomleft" },

    onAdd: function () {
      const btn = L.DomUtil.create("button", "route-btn");
      btn.innerHTML = "🧭 Route";

      L.DomEvent.disableClickPropagation(btn);

      state.routeButtonEl = btn;

      btn.onclick = function () {
        setRouteMode(!state.routeMode);

        if (!state.routeMode && state.currentRouteLayer) {
          state.currentRouteLayer.remove();
          state.currentRouteLayer = null;
        }
      };

      return btn;
    }
  });

  state.map.addControl(new RouteControl());
}


export function setRouteMode(enabled) {
  state.routeMode = enabled;

  if (state.routeButtonEl) {
    state.routeButtonEl.style.background = enabled ? "#007bff" : "white";
    state.routeButtonEl.style.color = enabled ? "white" : "black";
  }

  if (!enabled) {
    state.selectedFeatures = [];
    state.selectedLayers.forEach(layer => layer.setOpacity(1));
    state.selectedLayers = [];
  }
}
import { state } from "./state.js";
import { fetchData } from "./api.js";
import { createIcons } from "./icons.js";
import { createLayers } from "./layers.js";
import { addRouteControl } from "./routing.js";

export async function initMap() {
  state.map = L.map("map", { zoomControl: false }).setView([0, 0], 2);

  L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
    attribution: "&copy; OpenStreetMap contributors",
    maxZoom: 19,
  }).addTo(state.map);

  // Add zoom control manually in bottom-right
  L.control.zoom({ position: "bottomright" }).addTo(state.map);

  addRouteControl();

  const geojson = await fetchData("/destinations");
  state.allFeatures = geojson.features;

  createLayers();
}

document.addEventListener("DOMContentLoaded", initMap);
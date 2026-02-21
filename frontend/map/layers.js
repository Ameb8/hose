import { state } from "./state.js";
import { createIcons } from "./icons.js";
import { handleFeatureClick } from "./featureHandlers.js";

export function createLayers() {

  const iconMap = createIcons();

  const propertyFeatures = state.allFeatures.filter(f =>
    f.properties.type === "PROPERTY"
  );

  const otherFeatures = state.allFeatures.filter(f =>
    f.properties.type !== "PROPERTY"
  );

  state.propertyLayer = L.geoJSON([], {
    pointToLayer: (feature, latlng) => {
      const icon = iconMap[feature.properties.type];
      return L.marker(latlng, { icon });
    },
    onEachFeature: handleFeatureClick
  }).addTo(state.map);

  state.otherLayer = L.geoJSON(otherFeatures, {
    pointToLayer: (feature, latlng) => {
      const icon = iconMap[feature.properties.type];
      return L.marker(latlng, { icon });
    },
    onEachFeature: handleFeatureClick
  }).addTo(state.map);

  state.propertyLayer.addData(propertyFeatures);

  const group = L.featureGroup([state.propertyLayer, state.otherLayer]);
  state.map.fitBounds(group.getBounds());
}
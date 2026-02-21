import { state } from "./state.js";

export function applyMapFilters(filters) {
  const filtered = state.allFeatures.filter(feature => {

    if (feature.properties.type !== "PROPERTY") return false;

    const property = feature.properties.property;
    if (!property) return false;

    const unitTypes = property.unit_types || [];

    return unitTypes.some(unit => {
      const rent = unit.rent / 100;

      const matchesPrice =
        (!filters.minPrice || rent >= filters.minPrice) &&
        (!filters.maxPrice || rent <= filters.maxPrice);

      const matchesRooms =
        (!filters.rooms || unit.bedrooms >= filters.rooms);

      return matchesPrice && matchesRooms;
    });
  });

  state.propertyLayer.clearLayers();
  state.propertyLayer.addData(filtered);
}

export function resetMapFilters() {
  const allPropertyFeatures = state.allFeatures.filter(f =>
    f.properties.type === "PROPERTY"
  );

  state.propertyLayer.clearLayers();
  state.propertyLayer.addData(allPropertyFeatures);
}
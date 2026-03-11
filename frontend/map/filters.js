import { state } from "./state.js";

export function applyMapFilters(filters) {
  const filtered = state.allFeatures.filter(feature => {

    if (feature.properties.type !== "PROPERTY") return false;

    const property = feature.properties.property;
    if (!property) return false;

    // Get walk times
    const cwuDistance = property.cwu_time;
    const transitDistance = property.bus_stop_time;

    // Distance filters
    const matchesCwuDistance =
      (!filters.minDistCWU || cwuDistance >= filters.minDistCWU) &&
      (!filters.maxDistCWU || cwuDistance <= filters.maxDistCWU);

    const matchesTransitDistance =
      (!filters.minDistBus || transitDistance >= filters.minDistBus) &&
      (!filters.maxDistBus || transitDistance <= filters.maxDistBus);

    if (!matchesCwuDistance || !matchesTransitDistance) return false;

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
import { state } from "./state.js";
import { fetchData, fetchRoute } from "./api.js";
import { drawRoute, setRouteMode } from "./routing.js";
import { loadHOSECardTemplate, showHOSECard } from "../HOSE_Card/hoseCard.js";


function handleFeatureClick(feature, layer) {
  layer.on("click", async () => {
    const type = feature.properties.type;
    const featureId = feature.properties.id;
    let popupContent = "";

    if (state.routeMode) {
        state.selectedFeatures.push(featureId);
        state.selectedLayers.push(layer);
        layer.setOpacity(0.6);

        if (state.selectedFeatures.length === 2) {
            const [sourceId, destId] = state.selectedFeatures;

            try {
              const routeData = await fetchRoute(
                sourceId,
                destId,
                state.routeTransport
              );
              
              drawRoute(routeData);
            } catch (err) {
              console.error("Route fetch failed:", err);
            }

            setRouteMode(false);
        }

        return;
    }

    // Handle Property features
    if (type === "PROPERTY") {
      // Fetch property details
      const detailData = await fetchData(`/properties/${feature.properties.property.id}`);

      // Fetch HOSE card template
      await loadHOSECardTemplate();
      showHOSECard(detailData);
    } else if (type === "BUS_STOP") { // Handle bus stops
      popupContent = getBusStopPopupContent(feature);
      layer.bindPopup(popupContent).openPopup();
    } else if (type === "CWU") {
      popupContent = getCWUPopupContent(feature);
      layer.bindPopup(popupContent).openPopup();
    }
  });
}

function getBusStopPopupContent(feature) {
  return `
    <h3>Bus Stop</h3>
    <p>Name: ${feature.properties.name || "Unknown"}</p>
    <p>Address: ${feature.properties.address || "N/A"}</p>
  `;
}

function getCWUPopupContent(feature) {
  return `
    <h3>CWU Location</h3>
    <p>Name: ${feature.properties.name || "Unknown"}</p>
    <p>Address: ${feature.properties.address || "N/A"}</p>
    
  `;
}

export { handleFeatureClick };
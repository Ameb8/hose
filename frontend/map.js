document.addEventListener("DOMContentLoaded", initMap);


const API_BASE_URL = "https://bestsellers-navigate-bone-this.trycloudflare.com"
const DESTINATIONS_URL = "/destinations"


function createMap() {
  // Initialize map
  const map = L.map("map").setView([0, 0], 2);
  setTimeout(() => map.invalidateSize(), 100);

  // Add OpenStreetMap tiles
  L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
    attribution: "&copy; OpenStreetMap contributors",
    maxZoom: 19,
  }).addTo(map);

  return map;
}


function createIcons() {
  const propertyIcon = L.icon({
    iconUrl: "./icons/house.png",
    iconSize: [32, 32],
    iconAnchor: [16, 32],
    popupAnchor: [0, -32],
  });

  const busStopIcon = L.icon({
    iconUrl: "./icons/bus.png",
    iconSize: [32, 32],
    iconAnchor: [16, 32],
    popupAnchor: [0, -32],
  });

  return { PROPERTY: propertyIcon, BUS_STOP: busStopIcon };
}


async function getPropertyPopupContent(propertyId) {
  try {
    const detailData = await fetchGeoJSON(`/properties/${propertyId}`);
    return `
      <h3>${detailData.name}</h3>
      <p><strong>Address:</strong> ${detailData.address}</p>
      <p>${detailData.description}</p>
    `;
  } catch (err) {
    console.error("Error fetching property details:", err);
    return "<p>Error loading property details</p>";
  }
}


function getBusStopPopupContent(feature) {
  return `
    <h3>Bus Stop</h3>
    <p>Name: ${feature.properties.name || "Unknown"}</p>
    <p>Address: ${feature.properties.address || "N/A"}</p>
  `;
}


function handleFeatureClick(feature, layer) {
  layer.on("click", async () => {
    const type = feature.properties.type;
    let popupContent = "";

    if (type === "PROPERTY") {
      popupContent = await getPropertyPopupContent(feature.properties.property.id);
    } else if (type === "BUS_STOP") {
      popupContent = getBusStopPopupContent(feature);
    }

    layer.bindPopup(popupContent).openPopup();
  });
}


async function fetchData(endpoint) {
  const response = await fetch(`${API_BASE_URL}${endpoint}`);
  if (!response.ok) throw new Error("Failed to fetch " + endpoint);
  return response.json();
}


async function initMap() {
  // Create map object
  const map = createMap()

  try {
    // Query GeoJSON features from server
    const geojson = await fetchData(DESTINATIONS_URL);

    // Property icon
    const iconMap = createIcons();


    // Add GeoJSON to map
    const geojsonLayer = L.geoJSON(geojson, {
      pointToLayer: (feature, latlng) => {
        const icon = iconMap[feature.properties.type] || propertyIcon;
        return L.marker(latlng, { icon });
      },
      // Make overlaid features clickable
      onEachFeature: handleFeatureClick
    }).addTo(map);

    // Auto-zoom to features 
    if (geojsonLayer.getLayers().length > 0) {
      map.fitBounds(geojsonLayer.getBounds());
    }

  } catch (error) {
    console.error("Error loading GeoJSON:", error);
  }
}

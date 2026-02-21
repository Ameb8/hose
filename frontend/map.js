document.addEventListener("DOMContentLoaded", initMap);


const API_BASE_URL = "https://bestsellers-navigate-bone-this.trycloudflare.com"
const DESTINATIONS_URL = "/destinations"

let HOSECardTemplate = null;

function injectHOSECSS() {
  if (!document.getElementById("HOSECardCSS")) {
    const link = document.createElement("link");
    link.id = "HOSECardCSS";
    link.rel = "stylesheet";
    link.href = "./HOSE_Card/HOSE_cStyle.css";
    document.head.appendChild(link);
  }
}

// Inject CSS immediately on load
injectHOSECSS();

// Load card HTML as template
async function loadHOSECardTemplate() {
  if (!HOSECardTemplate) {
    const response = await fetch("./HOSE_Card/HOSE_card.html");
    HOSECardTemplate = await response.text();
  }
  return HOSECardTemplate;
}

function showHOSECard(data) {
  // Remove existing overlay if present
  const existingOverlay = document.querySelector(".apt-card-overlay");
  if (existingOverlay) existingOverlay.remove();

  // Create a container div
  const container = document.createElement("div");
  container.innerHTML = HOSECardTemplate; // HOSE card HTML

  // Append to body
  document.body.appendChild(container);

  // Fill in dynamic data
  const card = container.querySelector(".HOSE-card");
  card.querySelector(".apt-card-image img").src = data.image || "./HOSE_Card/House.png";
  card.querySelector(".apt-panel-header h2").textContent = data.name || "Unknown";
  const spans = card.querySelectorAll(".apt-panel-header span");
  if (spans.length >= 2) {
    spans[0].textContent = `Distance: ${data.distance || "N/A"}`;
    spans[1].textContent = data.address || "Unknown";
  }

  // Update panel-box info
  const box = card.querySelector(".apt-panel-box");
  if (box) {
    box.innerHTML = `
      <p><strong>Public transit Route:</strong> ${data.transitRoute || "N/A"}</p>
      <p class="sub-info"><strong>Nearest stop:</strong> ${data.nearestStop || "N/A"}</p>
      <p class="sub-info"><strong>CWU stop:</strong> ${data.cwuStop || "N/A"}</p>
      <p><strong>Lease type:</strong> ${data.leaseType || "N/A"}</p>
      <p><strong>Price:</strong> ${data.price || "N/A"}</p>
      <p><strong>Room type:</strong> ${data.roomType || "N/A"}</p>
      <p><strong>Pet policy:</strong> ${data.petPolicy || "N/A"}</p>
    `;
  }

  // Close modal when overlay is clicked
  container.querySelector(".apt-card-overlay").addEventListener("click", (e) => {
    if (e.target.classList.contains("apt-card-overlay")) container.remove();
  });
}


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

    // Handle Property features
    if (type === "PROPERTY") {
      // Fetch property details
      const detailData = await fetchData(`/properties/${feature.properties.property.id}`);

      // Fetch HOSE card template
      await loadHOSECardTemplate();

      // Show HOSE card modal
      showHOSECard({
        image: detailData.images?.[0]?.imageUrl || "./HOSE_Card/House.png",
        name: detailData.name,
        distance: "N/A",
        address: detailData.address || "Unknown",
        transitRoute: "N/A", 
        nearestStop: detailData.busStopWalkDistances?.[0]?.stopName || "N/A",
        cwuStop: detailData.busStopWalkDistances?.find(s => s.type === "CWU")?.stopName || "N/A",
        leaseType: detailData.propertyType || "N/A",
        price: detailData.unitTypes?.[0] ? `$${(detailData.unitTypes[0].rentCents/100).toLocaleString()}` : "N/A",
        roomType: detailData.unitTypes?.[0]?.name || "N/A",
        petPolicy: "N/A",
      });
    } else if (type === "BUS_STOP") { // Handle bus stops
      popupContent = getBusStopPopupContent(feature);
      layer.bindPopup(popupContent).openPopup();
    }
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

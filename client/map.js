document.addEventListener("DOMContentLoaded", initMap);

const API_BASE_URL = "https://kit-loved-brown-water.trycloudflare.com"


async function initMap() {
  // Create map object
  const map = L.map("map").setView([0, 0], 2);

  // Add OpenStreetMap tiles
  L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
    attribution: "&copy; OpenStreetMap contributors",
    maxZoom: 19,
  }).addTo(map);

  try {
    // Fetch GeoJSON features 
    const response = await fetch(`${API_BASE_URL}/destinations`);
    if (!response.ok) {
      throw new Error("Failed to fetch GeoJSON");
    }

    const geojson = await response.json();

    // Add GeoJSON to map
    const geojsonLayer = L.geoJSON(geojson, {
      pointToLayer: (feature, latlng) => {
        return L.circleMarker(latlng, {
          radius: 6,
          fillColor: "#ff7800",
          color: "#000",
          weight: 1,
          fillOpacity: 0.8,
        });
      },
      onEachFeature: (feature, layer) => {
        // 5. Bind click event to make API call on demand
        layer.on("click", async (e) => {
          try {
            // Replace `/destination/${id}` with your actual endpoint
            const detailResponse = await fetch(`${API_BASE_URL}/properties/${feature.id}`);
            if (!detailResponse.ok) throw new Error("Failed to fetch details");

            const detailData = await detailResponse.json();

            // Format content for popup
            const popupContent = `
              <h3>${detailData.name}</h3>
              <p><strong>Address:</strong> ${detailData.address}</p>
              <p>${detailData.description}</p>
            `;

            layer.bindPopup(popupContent).openPopup();
          } catch (err) {
            console.error("Error fetching feature details:", err);
            layer.bindPopup("<p>Error loading details</p>").openPopup();
          }
        });
      },
    }).addTo(map);

    // Auto-zoom to features 
    if (geojsonLayer.getLayers().length > 0) {
      map.fitBounds(geojsonLayer.getBounds());
    }

  } catch (error) {
    console.error("Error loading GeoJSON:", error);
  }
}

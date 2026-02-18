document.addEventListener("DOMContentLoaded", initMap);

const API_BASE_URL = "https://bestsellers-navigate-bone-this.trycloudflare.com"


async function initMap() {
  // Create map object
  const map = L.map("map").setView([0, 0], 2);

  setTimeout(() => {
    map.invalidateSize();
  }, 100);

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

    // Property icon
    const propertyIcon = L.icon({
      iconUrl: "./icons/house.png", // path to house icon
      iconSize: [32, 32],
      iconAnchor: [16, 32],
      popupAnchor: [0, -32],
    });

    // Bus Stop icon
    const busStopIcon = L.icon({
      iconUrl: "./icons/bus.png",
      iconSize: [32, 32],
      iconAnchor: [16, 32],
      popupAnchor: [0, -32],
    });

    // Maps property type to icon
    const iconMap = {
      PROPERTY: propertyIcon,
      BUS_STOP: busStopIcon,
    };


    // Add GeoJSON to map
    const geojsonLayer = L.geoJSON(geojson, {
      pointToLayer: (feature, latlng) => {
        const icon = iconMap[feature.properties.type] || propertyIcon;
        return L.marker(latlng, { icon });
      },
      // Make overlaid features clickable
      onEachFeature: (feature, layer) => {
        layer.on("click", async () => {
          const type = feature.properties.type;

          // Handle Property features
          if (type === "PROPERTY") {
            // Fetch full Property object
            try {
              const detailResponse = await fetch(`${API_BASE_URL}/properties/${feature.properties.property.id}`);
              if (!detailResponse.ok) throw new Error("Failed to fetch details");

              const detailData = await detailResponse.json(); // Wait for response

              // Display property content
              const popupContent = `
                <h3>${detailData.name}</h3>
                <p><strong>Address:</strong> ${detailData.address}</p>
                <p>${detailData.description}</p>
              `;

              layer.bindPopup(popupContent).openPopup();
            } catch (err) {
              console.error("Error fetching feature details:", err);
              layer.bindPopup("<p>Error loading property details</p>").openPopup();
            }

          // Handle bus stop features
          } else if (type === "BUS_STOP") {
            // Display bus stop info
            const busPopupContent = `
              <h3>Bus Stop</h3>
              <p>Name: ${feature.properties.name || "Unknown"}</p>
              <p>Address: ${feature.properties.address || "N/A"}</p>
            `;
            layer.bindPopup(busPopupContent).openPopup();
          }
        });
      }
    }).addTo(map);

    // Auto-zoom to features 
    if (geojsonLayer.getLayers().length > 0) {
      map.fitBounds(geojsonLayer.getBounds());
    }

  } catch (error) {
    console.error("Error loading GeoJSON:", error);
  }
}

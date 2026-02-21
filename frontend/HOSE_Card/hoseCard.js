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

injectHOSECSS();

export async function loadHOSECardTemplate() {
  if (!HOSECardTemplate) {
    const response = await fetch("./HOSE_Card/HOSE_card.html");
    HOSECardTemplate = await response.text();
  }
  return HOSECardTemplate;
}

export function showHOSECard(data) {
  const existingOverlay = document.querySelector(".apt-card-overlay");
  if (existingOverlay) existingOverlay.remove();

  const container = document.createElement("div");
  container.innerHTML = HOSECardTemplate;
  document.body.appendChild(container);

  const card = container.querySelector(".HOSE-card");
  const imageContainer = card.querySelector(".apt-card-image");
  imageContainer.innerHTML = "";

  if (data.images?.length) {
    data.images.forEach(img => {
      const imageEl = document.createElement("img");
      imageEl.src = img.imageUrl;
      imageContainer.appendChild(imageEl);
    });
  } else {
    const fallback = document.createElement("img");
    fallback.src = "./HOSE_Card/House.png";
    imageContainer.appendChild(fallback);
  }

  card.querySelector(".apt-panel-header h2").textContent = data.name || "Unknown";

  const spans = card.querySelectorAll(".apt-panel-header span");
  if (spans.length >= 2) {
    spans[0].textContent = `Distance: ${data.distance || "N/A"}`;
    spans[1].textContent = data.address || "Unknown";
  }

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

  container.querySelector(".apt-card-overlay")
    .addEventListener("click", (e) => {
      if (e.target.classList.contains("apt-card-overlay")) {
        container.remove();
      }
    });
}
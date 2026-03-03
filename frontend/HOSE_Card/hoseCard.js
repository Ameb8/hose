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

function formatPhone(phone) {
  if (!phone) return "N/A";

  const cleaned = phone.replace(/\D/g, "");

  if (cleaned.length === 10) {
    return `(${cleaned.slice(0,3)}) ${cleaned.slice(3,6)}-${cleaned.slice(6)}`;
  }

  return phone;
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
    spans[2].textContent = formatPhone(data.contactPhone);
  }

  const box = card.querySelector(".apt-panel-box");
  console.log("Data:\n\n", data) // DEBUG ******
  if (box) {
    const formattedDescription = data.description
      ? data.description
          .split("\n")
          .map(p => `<p>${p.trim()}</p>`)
          .join("")
      : "<p>No description available.</p>";

    box.innerHTML = `
      <div class="hose-section">
        <p><strong>Walking Distance To:</strong></p>
        <p class="sub-info"><strong>Nearest Bus Stop:</strong> ${data.busStopDistance ?? "N/A"} mi</p>
        <p class="sub-info"><strong>CWU:</strong> ${data.cwuDistance ?? "N/A"} mi</p>
      </div>

      <div class="hose-section">
        <p><strong>Price:</strong> ${data.price || "N/A"}</p>
        <p><strong>Room Type:</strong> ${data.roomType || "N/A"}</p>
      </div>

      <div class="hose-description">
        <h3>About This Property</h3>
        ${formattedDescription}
      </div>
    `;
  }

  container.querySelector(".apt-card-overlay")
    .addEventListener("click", (e) => {
      if (e.target.classList.contains("apt-card-overlay")) {
        container.remove();
      }
    });
}
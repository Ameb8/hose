
import { addToCompare, removeFromCompare, isInCompare } from '../compare/compareState.js';
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

export async  function showHOSECard(data) {

  // Ensure template is loaded
  await loadHOSECardTemplate();

  // Remove any existing card
  const existingOverlay = document.querySelector(".apt-card-overlay");
  if (existingOverlay) existingOverlay.remove();

  // Create container and inject template
  const container = document.createElement("div");
  container.innerHTML = HOSECardTemplate;
  document.body.appendChild(container);

  const card = container.querySelector(".HOSE-card");
  
  const compareCheckbox = card.querySelector(".compare-box input");

  if (compareCheckbox) {
    compareCheckbox.checked = isInCompare(data.id);

    compareCheckbox.addEventListener("change", () => {
      if (compareCheckbox.checked) {
        const added = addToCompare({
          id: data.id,
          name: data.name,
          data: data
        });

        if (!added) {
          compareCheckbox.checked = false;
        }
      } else {
        removeFromCompare(data.id);
      }
    });
  }

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
    spans[0].textContent = data.address || "Unknown";
    spans[1].textContent = formatPhone(data.contactPhone);
  }

  const box = card.querySelector(".apt-panel-box");

  if (box) {
    const formattedDescription = data.description
      ? data.description
          .split("\n")
          .map(p => `<p>${p.trim()}</p>`)
          .join("")
      : "<p>No description available.</p>";

    const unitList = data.unitTypes?.length
      ? data.unitTypes.map(unit => `
          <div class="unit-row">
            <span class="unit-price">$${(unit.rentCents/100).toLocaleString()}</span>
            <span>${unit.bedrooms} Bed</span>
            <span>${unit.bathrooms} Bath</span>
          </div>
        `).join("")
      : `<div class="unit-row">No units available</div>`;

    box.innerHTML = `
      <div class="hose-section">
        <p><strong>Walking Distance To:</strong></p>
        <p class="sub-info"><strong>Nearest Bus Stop:</strong> ${data.busStopDistance ?? "N/A"} mi</p>
        <p class="sub-info"><strong>CWU:</strong> ${data.cwuDistance ?? "N/A"} mi</p>
      </div>

      <div class="hose-section">
        <div class="unit-dropdown">
          <button class="unit-toggle">Available Units ▾</button>
          <div class="unit-dropdown-content">
            ${unitList}
          </div>
        </div>
      </div>

      <div class="hose-description">
        <h3>About This Property</h3>
        ${formattedDescription}
      </div>
    `;

    // Dropdown toggle logic
    const toggle = box.querySelector(".unit-toggle");
    const content = box.querySelector(".unit-dropdown-content");

    toggle.addEventListener("click", () => {
      content.classList.toggle("open");
      toggle.textContent = content.classList.contains("open")
        ? "Available Units ▴"
        : "Available Units ▾";
    });
  }

  container.querySelector(".apt-card-overlay")
    .addEventListener("click", (e) => {
      if (e.target.classList.contains("apt-card-overlay")) {
        container.remove();
      }
    });
}



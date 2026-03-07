// compare/compare.js
import { getCompareList, removeFromCompare, clearCompare } from '../compareState.js';

export function showCompareView() {
    const compareList = getCompareList();

    // Remove existing overlay if any
    const existingOverlay = document.querySelector('.compare-overlay');
    if (existingOverlay) {
        existingOverlay.remove();
    }

    // Create overlay
    const overlay = document.createElement('div');
    overlay.className = 'compare-overlay';

    // Create container
    const container = document.createElement('div');
    container.className = 'compare-container';

    // Header
    const header = document.createElement('div');
    header.className = 'compare-header';
    header.innerHTML = `
        <h2>Compare Apartments (${compareList.length}/4)</h2>
        <button class="close-compare">&times;</button>
    `;

    // Grid for compare cards
    const grid = document.createElement('div');
    grid.className = 'compare-grid';

    if (compareList.length === 0) {
        grid.innerHTML = '<div class="empty-compare">No apartments selected for comparison</div>';
    } else {
        compareList.forEach(item => {
            const card = createCompareCard(item);
            grid.appendChild(card);
        });
    }

    // Assemble
    container.appendChild(header);
    container.appendChild(grid);
    overlay.appendChild(container);
    document.body.appendChild(overlay);

    // Close button functionality
    const closeBtn = header.querySelector('.close-compare');
    closeBtn.addEventListener('click', () => {
        overlay.remove();
    });

    // Click outside to close
    overlay.addEventListener('click', (e) => {
        if (e.target === overlay) {
            overlay.remove();
        }
    });
}

function createCompareCard(item) {
    const card = document.createElement('div');
    card.className = 'compare-card';

    const data = item.data;
    const imageUrl = data.images && data.images[0]
        ? data.images[0].imageUrl
        : './HOSE_Card/House.png';

    const firstUnit = data.unitTypes && data.unitTypes[0];
    const priceDisplay = firstUnit
        ? `$${(firstUnit.rentCents / 100).toLocaleString()}/mo`
        : 'Price N/A';

    card.innerHTML = `
        <div class="compare-card-image">
            <img src="${imageUrl}" alt="${data.name}">
        </div>
        <div class="compare-card-content">
            <h3>${data.name || 'Unknown'}</h3>
            <p><strong>Address:</strong> ${data.address || 'N/A'}</p>
            <p><strong>Phone:</strong> ${formatPhone(data.contactPhone)}</p>
            <p class="price">${priceDisplay}</p>
            <p><strong>Distance to CWU:</strong> ${data.cwuDistance || 'N/A'} mi</p>
            <p><strong>Bus Stop:</strong> ${data.busStopDistance || 'N/A'} mi</p>
            <button class="compare-remove" data-id="${data.id}">Remove from Compare</button>
        </div>
    `;

    // Remove button functionality
    const removeBtn = card.querySelector('.compare-remove');
    removeBtn.addEventListener('click', () => {
        removeFromCompare(data.id);

        // Refresh the compare view
        const overlay = document.querySelector('.compare-overlay');
        if (overlay) {
            overlay.remove();
            showCompareView();
        }
    });

    return card;
}

function formatPhone(phone) {
    if (!phone) return "N/A";
    const cleaned = phone.replace(/\D/g, "");
    if (cleaned.length === 10) {
        return `(${cleaned.slice(0,3)}) ${cleaned.slice(3,6)}-${cleaned.slice(6)}`;
    }
    return phone;
}

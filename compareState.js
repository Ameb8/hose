// compareState.js
let compareList = [];

export function getCompareList() {
    return compareList;
}

export function addToCompare(item) {
    if (compareList.length >= 4) {
        alert('You can compare up to 4 apartments maximum');
        return false;
    }
    
    if (!compareList.some(existing => existing.id === item.id)) {
        compareList.push(item);
        updateCompareButton();
        return true;
    }
    return false;
}

export function removeFromCompare(itemId) {
    compareList = compareList.filter(item => item.id !== itemId);
    updateCompareButton();
}

export function isInCompare(itemId) {
    return compareList.some(item => item.id === itemId);
}

export function clearCompare() {
    compareList = [];
    updateCompareButton();
}

// Update the compare button UI
function updateCompareButton() {
    const btn = document.getElementById("compareBtn");
    const count = compareList.length;

    if (btn) {
        if (count > 0) {
            btn.innerHTML = `<i class="fas fa-code-compare"></i> Compare (${count}/4)`;
            btn.classList.add('has-items');
        } else {
            btn.innerHTML = `<i class="fas fa-code-compare"></i> Compare Now`;
            btn.classList.remove('has-items');
        }
    }
}

// Initialize button when DOM is ready
if (typeof document !== 'undefined') {
    document.addEventListener('DOMContentLoaded', () => {
        updateCompareButton();
    });
}
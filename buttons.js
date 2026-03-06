import { showCompareView } from './compare/compare.js';

// Import other stuff you need
import { applyMapFilters, resetMapFilters } from "./map/filters.js";

const API_BASE_URL = "https://driving-solaris-stewart-visiting.trycloudflare.com";

// Initialize when DOM is ready
document.addEventListener('DOMContentLoaded', function() {
    "use strict";
    
    console.log("Initializing buttons...");
    
    // Compare button
    const compareBtn = document.getElementById('compareBtn');
    if (compareBtn) {
        compareBtn.addEventListener('click', function(e) {
            e.preventDefault();
            console.log("Compare button clicked");
            showCompareView();
        });
    }
    
    // Chat button
    const chatBtn = document.getElementById('chatButton');
    const chatBadge = document.getElementById('chatOpenBadge');
    const chatWindow = document.getElementById('chatWindow');
    const chatInput = document.getElementById("chatInput");
    const sendChatBtn = document.getElementById("sendChatBtn");
    const chatMessages = document.querySelector(".chat-messages");
    
    // Filter button
    const filterBtn = document.getElementById('filterToggleBtn');
    const filterPanel = document.getElementById('filterPanel');
    
    let chatOpen = false;
    let filterVisible = false;
    
    // Chat functions
    if (chatBtn && chatWindow) {
        chatBtn.addEventListener('click', function(e) {
            e.preventDefault();
            chatOpen = !chatOpen;
            
            if (chatOpen) {
                if (filterVisible) setFilterVisible(false);
                chatWindow.classList.remove('hidden');
                if (chatBadge) chatBadge.classList.remove('hidden');
            } else {
                chatWindow.classList.add('hidden');
                if (chatBadge) chatBadge.classList.add('hidden');
            }
        });
    }
    
    // Filter functions
    function setFilterVisible(visible) {
        filterVisible = visible;
        if (filterVisible) {
            if (chatOpen) {
                chatOpen = false;
                chatWindow.classList.add('hidden');
                if (chatBadge) chatBadge.classList.add('hidden');
            }
            filterPanel.classList.add('show');
            filterBtn.innerHTML = '<i class="fas fa-sliders-h"></i> Filter <i class="fas fa-chevron-up"></i>';
        } else {
            filterPanel.classList.remove('show');
            filterBtn.innerHTML = '<i class="fas fa-sliders-h"></i> Filter <i class="fas fa-chevron-down"></i>';
        }
    }
    
    if (filterBtn && filterPanel) {
        filterBtn.addEventListener('click', function(e) {
            e.preventDefault();
            setFilterVisible(!filterVisible);
        });
    }
    
    // Chat send function
    async function sendMessage() {
        if (!chatInput || !chatMessages) return;
        
        const text = chatInput.value.trim();
        if (!text) return;
        
        // Add user message
        const userMsg = document.createElement("div");
        userMsg.textContent = text;
        userMsg.classList.add("user-message");
        chatMessages.appendChild(userMsg);
        
        chatInput.value = "";
        chatMessages.scrollTop = chatMessages.scrollHeight;
        
        // AI response placeholder
        const aiMsg = document.createElement("div");
        aiMsg.textContent = "AI is typing...";
        aiMsg.classList.add("ai-message");
        chatMessages.appendChild(aiMsg);
        chatMessages.scrollTop = chatMessages.scrollHeight;
        
        try {
            const response = await fetch(`${API_BASE_URL}/api/ai`, {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ query: text })
            });
            
            if (response.status === 503) {
                aiMsg.textContent = "AI assistant is currently unavailable.";
                return;
            }
            
            if (!response.ok) throw new Error("Request failed");
            
            const data = await response.json();
            aiMsg.textContent = data.answer;
            
        } catch (error) {
            console.error("Chat error:", error);
            aiMsg.textContent = "AI assistant is currently unavailable.";
        }
        
        chatMessages.scrollTop = chatMessages.scrollHeight;
    }
    
    if (sendChatBtn) {
        sendChatBtn.addEventListener("click", sendMessage);
    }
    
    if (chatInput) {
        chatInput.addEventListener("keypress", (e) => {
            if (e.key === "Enter") sendMessage();
        });
    }
    
    // Filter buttons
    const resetBtn = document.getElementById('resetFiltersBtn');
    if (resetBtn && resetMapFilters) {
        resetBtn.addEventListener('click', function() {
            document.getElementById("minPrice").value = "";
            document.getElementById("maxPrice").value = "";
            document.querySelectorAll(".room-btn").forEach(b => b.classList.remove("active"));
            resetMapFilters();
        });
    }
    
    // Room buttons
    document.querySelectorAll(".room-btn").forEach(btn => {
        btn.addEventListener("click", function() {
            document.querySelectorAll(".room-btn").forEach(b => b.classList.remove("active"));
            this.classList.add("active");
        });
    });
    
    // Apply filters
    const applyBtn = document.getElementById('applyFilterBtn');
    if (applyBtn && applyMapFilters) {
        applyBtn.addEventListener('click', function() {
            const minPrice = parseInt(document.getElementById("minPrice").value) || 0;
            const maxPrice = parseInt(document.getElementById("maxPrice").value) || 3000;
            const minDistCWU = parseInt(document.getElementById("walkingMin").value) || null;
            const maxDistCWU = parseInt(document.getElementById("walkingMax").value) || null;
            const minDistBus = parseInt(document.getElementById("transitMin").value) || null;
            const maxDistBus = parseInt(document.getElementById("transitMax").value) || null;
            const activeRoomBtn = document.querySelector(".room-btn.active");
            const rooms = activeRoomBtn ? parseInt(activeRoomBtn.dataset.rooms) : null;
            
            applyMapFilters({ minPrice, maxPrice, minDistCWU, maxDistCWU, minDistBus, maxDistBus, rooms });
        });
    }
});
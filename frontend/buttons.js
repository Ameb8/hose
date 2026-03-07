import { applyMapFilters, resetMapFilters } from "./map/filters.js";
import { showCompareView } from './compare/compare.js';

const LLM_BASE_URL = "https://random-text-here.trycloudflare.com";


//HALF OF THE BUTTON BEHAVIOR ☠️☠️☠️☠️☠️☠️
(function() {
  "use strict";

      // Compare button
  const compareBtn = document.getElementById('compareBtn');
  if (compareBtn) {
      compareBtn.addEventListener('click', function(e) {
          e.preventDefault();
          closeAllPanels();
          showCompareView();
      });
  }
  

  // DOM elements
  const chatBtn = document.getElementById('chatButton');
  const chatBadge = document.getElementById('chatOpenBadge');
  const chatBanner = document.getElementById('chatIndicatorBanner');
  const filterBtn = document.getElementById('filterToggleBtn');
  const filterPanel = document.getElementById('filterPanel');
  const chatInput = document.getElementById("chatInput");
  const sendChatBtn = document.getElementById("sendChatBtn");
  const chatMessages = document.querySelector(".chat-messages");

async function sendMessage() {
  const text = chatInput.value.trim();
  if (!text) return;

  // Add user message to UI
  const userMsg = document.createElement("div");
  userMsg.textContent = text;
  userMsg.classList.add("user-message");
  chatMessages.appendChild(userMsg);

  chatInput.value = "";
  chatMessages.scrollTop = chatMessages.scrollHeight;

  // Create temporary AI "thinking..." message
  const aiMsg = document.createElement("div");
  aiMsg.textContent = "AI is typing...";
  aiMsg.classList.add("ai-message");
  chatMessages.appendChild(aiMsg);
  chatMessages.scrollTop = chatMessages.scrollHeight;

  try { // Make API call with LLM Prompt
    const response = await fetch(`${LLM_BASE_URL}/ask-ai`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        query: text
      })
    });

    // Handle 503 if LLM service is down
    if (response.status === 503) {
      aiMsg.textContent = "AI assistant is currently unavailable.";
      return;
    }

    // Handle other errors
    if (!response.ok) { 
      throw new Error("Request failed");
    }

    const data = await response.json();

    // Extract LLM response
    aiMsg.textContent = data.answer;

  } catch (error) {
    console.error("Chat error:", error);
    aiMsg.textContent = "AI assistant is currently unavailable.";
  }

  chatMessages.scrollTop = chatMessages.scrollHeight;
}

sendChatBtn.addEventListener("click", sendMessage);

chatInput.addEventListener("keypress", (e) => {
  if (e.key === "Enter") sendMessage();
});


  //Chat button
  const chatButton = document.getElementById("chatButton"); 
  const chatWindow = document.getElementById("chatWindow");
  // By default, chat is NOT open, filter panel is hidden
  let chatOpen = false;
  let filterVisible = false;


//close Panels:
function closeAllPanels() {
  // Close Chat
  if (chatOpen) {
    chatOpen = false;
    chatWindow.classList.add('hidden');
    if (chatBadge) chatBadge.classList.add('hidden');
  }

  // Close Filter
  if (filterVisible) {
    filterVisible = false;
    filterPanel.classList.remove('show');
    filterBtn.innerHTML =
        '<i class="fas fa-sliders-h"></i> Filter <i class="fas fa-chevron-down"></i>';
  }
}

  // Function to update chat UI based on state
function setChatOpen(open) {
  if (open && filterVisible) { 
    setFilterVisible(false); 
  }

  chatOpen = open;

  if (chatOpen) {
    chatBadge.classList.remove('hidden');
    chatWindow.classList.remove('hidden');

    chatBtn.style.background = '#25344F';
    chatBtn.style.borderColor = '#ffffff';

  } else {
    chatBadge.classList.add('hidden');
    chatWindow.classList.add('hidden');

    chatBtn.style.background = '#25344F';
    chatBtn.style.borderColor = '#ffffff';
  }
}


  // toggle filter panel visibility
  function setFilterVisible(visible) {
    // Only close chat when OPENING filter
    if (visible && chatOpen) { 
      setChatOpen(false); 
    }

    filterVisible = visible;
    if (filterVisible) {
      filterPanel.classList.add('show');
      filterBtn.classList.add('active');
      filterBtn.innerHTML = '<i class="fas fa-sliders-h"></i>   Filter <i class="fas fa-chevron-up" style="font-size:0.85rem;"></i>';
    } else {
      filterPanel.classList.remove('show');
      filterBtn.classList.remove('active');
      filterBtn.innerHTML = '<i class="fas fa-sliders-h"></i> Filter <i class="fas fa-chevron-down" style="font-size:0.85rem;"></i>';
    }
  }

  const resetBtn = document.getElementById('resetFiltersBtn');

  if (resetBtn) {
    resetBtn.addEventListener('click', function() {

      // Clear input fields
      document.getElementById("minPrice").value = "";
      document.getElementById("maxPrice").value = "";

      document.querySelectorAll(".room-btn").forEach(b =>
        b.classList.remove("active")
      );

      // Reset map layer
      resetMapFilters();
    });
  }

  // when user clicks CHAT button - TOGGLE behavior
  chatBtn.addEventListener('click', function(e) {
    e.preventDefault();
    setChatOpen(!chatOpen);
  });

  //  toggle filter on filter button click
  filterBtn.addEventListener('click', function(e) {
    e.preventDefault();
    setFilterVisible(!filterVisible);
  });

  document.querySelectorAll(".room-btn").forEach(btn => {
    btn.addEventListener("click", function() {
      document.querySelectorAll(".room-btn").forEach(b => b.classList.remove("active"));
      this.classList.add("active");
    });
  });

  const applyBtn = document.getElementById('applyFilterBtn');

  if (applyBtn) {
    applyBtn.addEventListener('click', function() {

      // Price filters
      const minPrice = parseInt(document.getElementById("minPrice").value);
      const maxPrice = parseInt(document.getElementById("maxPrice").value);

      // Walk distance filters
      const minDistCWU = parseInt(document.getElementById("walkingMin").value) || null;
      const maxDistCWU = parseInt(document.getElementById("walkingMax").value) || null;
      const minDistBus = parseInt(document.getElementById("transitMin").value) || null;
      const maxDistBus = parseInt(document.getElementById("transitMax").value) || null;

      // Number of rooms filters
      const activeRoomBtn = document.querySelector(".room-btn.active");
      const rooms = activeRoomBtn ? parseInt(activeRoomBtn.dataset.rooms) : null;

      applyMapFilters({
        minPrice,
        maxPrice,
        minDistCWU,
        maxDistCWU,
        minDistBus,
        maxDistBus,
        rooms
      });

    });
  }

  // Initialize
  setChatOpen(false);
  setFilterVisible(false);
})();
import { applyMapFilters, resetMapFilters } from "./map/filters.js";

//HALF OF THE BUTTON BEHAVIOR ☠️☠️☠️☠️☠️☠️
(function() {
  "use strict";

  // DOM elements
  const chatBtn = document.getElementById('chatButton');
  const chatBadge = document.getElementById('chatOpenBadge');
  const chatBanner = document.getElementById('chatIndicatorBanner');
  const filterBtn = document.getElementById('filterToggleBtn');
  const filterPanel = document.getElementById('filterPanel');
  const chatInput = document.getElementById("chatInput");
  const sendChatBtn = document.getElementById("sendChatBtn");
  const chatMessages = document.querySelector(".chat-messages");

function sendMessage() {
  const text = chatInput.value.trim();
  if (!text) return;

  const msg = document.createElement("div");
  msg.textContent = text;
  msg.classList.add("user-message"); //add AI somewhere around here

  chatMessages.appendChild(msg);
  chatInput.value = "";
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

      const minPrice = parseInt(document.getElementById("minPrice").value);
      const maxPrice = parseInt(document.getElementById("maxPrice").value);

      const activeRoomBtn = document.querySelector(".room-btn.active");
      const rooms = activeRoomBtn ? parseInt(activeRoomBtn.dataset.rooms) : null;

      applyMapFilters({
        minPrice,
        maxPrice,
        rooms
      });

    });
  }

  // Initialize
  setChatOpen(false);
  setFilterVisible(false);
})();
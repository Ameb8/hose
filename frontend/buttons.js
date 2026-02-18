//HALF OF THE BUTTON BEHAVIOR ☠️☠️☠️☠️☠️☠️
(function() {
  "use strict";

  // DOM elements
  const chatBtn = document.getElementById('chatButton');
  const chatBadge = document.getElementById('chatOpenBadge');
  const chatBanner = document.getElementById('chatIndicatorBanner');
  const filterBtn = document.getElementById('filterToggleBtn');
  const filterPanel = document.getElementById('filterPanel');

  // By default, chat is NOT open, filter panel is hidden
  let chatOpen = false;
  let filterVisible = false;

  // Function to update chat UI based on state
  function setChatOpen(open) {
    chatOpen = open;
    if (chatOpen) {
      chatBadge.classList.remove('hidden');
      chatBanner.classList.remove('hidden');
      chatBtn.style.background = '#166973';
      chatBtn.style.borderColor = '#ffd966';
    } else {
      chatBadge.classList.add('hidden');
      chatBanner.classList.add('hidden');
      chatBtn.style.background = '#1e4a5f';
      chatBtn.style.borderColor = '#569fb0';
    }
  }

  // toggle filter panel visibility
  function setFilterVisible(visible) {
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

  // apply filter button just gives feedback (demo)
  const applyBtn = document.getElementById('applyFilterBtn');
  if (applyBtn) {
    applyBtn.addEventListener('click', function() {
      alert('✨Demo: Filter applied');
    });
  }

  // Initialize
  setChatOpen(false);
  setFilterVisible(false);
})();
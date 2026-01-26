const btn = document.getElementById("fetchBtn");
const output = document.getElementById("output");

btn.addEventListener("click", async () => {
  output.textContent = "Loading...";

  try {
    const res = await fetch("http://localhost:8080/destinations"); 
    const json = await res.json();

    // Pretty-print JSON for vertical readability
    output.textContent = JSON.stringify(json, null, 2);
  } catch (err) {
    output.textContent = "Error: " + err.message;
  }
});

const API_BASE_URL = "http://192.168.1.211:8080";

export async function fetchData(endpoint) {
  const response = await fetch(`${API_BASE_URL}${endpoint}`);
  if (!response.ok) throw new Error("Failed to fetch " + endpoint);
  return response.json();
}

export function fetchRoute(sourceId, destId, mode) {
  return fetchData(`/destinations/${sourceId}/${destId}/route?profile=${mode.toUpperCase()}`);
}


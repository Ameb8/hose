export function createIcons() {
  const propertyIcon = L.icon({
    iconUrl: "./icons/house.png",
    iconSize: [32, 32],
    iconAnchor: [16, 32],
    popupAnchor: [0, -32],
  });

  const busStopIcon = L.icon({
    iconUrl: "./icons/bus.png",
    iconSize: [32, 32],
    iconAnchor: [16, 32],
    popupAnchor: [0, -32],
  });

  return { PROPERTY: propertyIcon, BUS_STOP: busStopIcon };
}

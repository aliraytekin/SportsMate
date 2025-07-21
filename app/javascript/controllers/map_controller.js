import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
    latitude: Number,
    longitude: Number
  }

  connect() {
    console.log("🗺️ Connecting Map...");
    console.log("🗺️ Markers:", this.markersValue);
    console.log("🗺️ Lat/Lng:", this.latitudeValue, this.longitudeValue);

    mapboxgl.accessToken = this.apiKeyValue;

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v11",
      center: [this.longitudeValue, this.latitudeValue]
    })

    this.addMarkers()
    this.fitMapToMarkers()
    this.map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken,
                                        mapboxgl: mapboxgl }))
  }

  markersValueChanged() {
    this.clearMarkers()
    this.addMarkers()
    this.fitMapToMarkers()
  }


  addMarkers() {
    this.markerInstances = []

    this.markersValue.forEach(marker => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html)

      const customMarker = document.createElement("div")
      customMarker.innerHTML = marker.marker_html

      const newMarker = new mapboxgl.Marker(customMarker)
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(this.map)

      this.markerInstances.push(newMarker)
    })
  }

  fitMapToMarkers() {
    if (!this.map || !Array.isArray(this.markersValue) || this.markersValue.length === 0) return;

    const bounds = new mapboxgl.LngLatBounds();

    this.markersValue.forEach((marker) => {
      if (marker && marker.lat && marker.lng) {
        bounds.extend([marker.lng, marker.lat]);
      }
    });

    if (!bounds.isEmpty()) {
      this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
    }
  }


  clearMarkers() {
  if (this.markerInstances) {
    this.markerInstances.forEach(marker => marker.remove())
  }
  this.markerInstances = []
  }
}

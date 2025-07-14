import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    // mapboxgl.accessToken = this.apiKeyValue; // This synthax not working, the api key is empoty when console.log ?!
    mapboxgl.accessToken = 'pk.eyJ1IjoiYXJlZmxhbSIsImEiOiJjbWQxamlhbTAwejB0Mmtxd2dobHpkanc2In0.bzG-eH-Zw-oFRTFHAiA5fQ';
    this.map = new mapboxgl.Map({
    container: this.element, // container ID
    style: 'mapbox://styles/mapbox/streets-v12', // style URL
    center: [0, 0], // starting position [lng, lat]
    zoom: 9, // starting zoom
    })
     this.#addMarkersToMap();
     this.#fitMapToMarkers();
  }
#addMarkersToMap() {
  this.markersValue.forEach((marker) => {
    const popup = new mapboxgl.Popup().setHTML(marker.info_window_html)
    new mapboxgl.Marker()
      .setLngLat([ marker.lng, marker.lat ])
      .setPopup(popup)
      .addTo(this.map)
    })
  }
#fitMapToMarkers() {
  const bounds = new mapboxgl.LngLatBounds()
  this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
  this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }
}

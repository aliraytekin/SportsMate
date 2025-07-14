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
    center: [-74.5, 40], // starting position [lng, lat]
    zoom: 9, // starting zoom
    })
     this.#addMarkersToMap();
  }
#addMarkersToMap() {
  this.markersValue.forEach((marker) => {
    new mapboxgl.Marker()
      .setLngLat([ marker.lng, marker.lat ])
      .addTo(this.map)
    })
  }
}

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v12",
      center: [-1.5536, 47.2184], // Nantes par défaut (si aucun marqueur)
      zoom: 5
    })
    this.#addMarkers()
    this.#fitMapToMarkers()
  }

  #addMarkers() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.popup_html)
      new mapboxgl.Marker()
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(this.map)
    })
  }

  #fitMapToMarkers() {
    if (this.markersValue.length === 0) return
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(m => bounds.extend([m.lng, m.lat]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 14, duration: 0 })
  }
}

import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-price"
export default class extends Controller {
  static targets = ["checkbox", "priceField"]

  connect() {
    this.toggle()
  }

  toggle() {
    const isFree = this.checkboxTarget.checked
    this.priceFieldTarget.style.display = isFree ? "none" : "block"
  }
}

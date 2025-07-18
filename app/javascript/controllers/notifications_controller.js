import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notifications"
export default class extends Controller {
  static values = { url: String }

  markAsRead() {
    fetch(this.urlValue, {
      method: "PATCH",
      headers: {
        "X-CSRF-token": document.querySelector("meta[name=csrf-token]").content,
        "Accept": "text/vnd.turbo-stream.html"
      }
    })
  }
}

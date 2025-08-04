import { Controller } from "@hotwired/stimulus"
import Typed from 'typed.js'

// Connects to data-controller="typed"
export default class extends Controller {
  static targets = ["output"]

  connect() {
    this.typed = new Typed(this.outputTarget, {
      strings: [
        "More than just a game.",
        "Find teammates. Create games. Play together."
      ],
      typeSpeed: 50,
      backSpeed: 25,
      backDelay: 2000,
      loop: true,
      showCursor: true
    })
  }

  disconnect() {
    if (this.typed)
      this.typed.destroy();
  }
}

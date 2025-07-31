import { Controller } from "@hotwired/stimulus"
import * as bootstrap from "bootstrap"

export default class extends Controller {
  connect() {
    this.modalElement = this.element.querySelector(".modal")
    if (this.modalElement) {
      this.modalInstance = bootstrap.Modal.getOrCreateInstance(this.modalElement)
      this.modalInstance.show()

      this.modalElement.addEventListener("hidden.bs.modal", () => {
        this.element.remove()  // removes turbo-frame from DOM
      })
    }
  }

  close() {
    // To close modal, clear Turbo Frame content or remove the modal element
    const modalFrame = document.getElementById("modal");
    if (modalFrame) {
      modalFrame.innerHTML = "";  // Clear modal content to hide it
    }
  }
}

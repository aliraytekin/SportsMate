import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["icon", "card"]

  connect() {
    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          if (this.hasCardTarget) {
            this.cardTarget.classList.add("visible")
          }

          this.iconTargets.forEach((icon, index) => {
            icon.style.opacity = 0
            icon.style.transform = "translateY(20px)"
            setTimeout(() => {
              icon.style.transition = "opacity 1.3s ease-out, transform 1.3s ease-out"
              icon.style.opacity = 1
              icon.style.transform = "translateY(0)"
            }, index * 500)
          })

          observer.unobserve(entry.target)
        }
      })
    }, {
      threshold: 0.2
    })

    observer.observe(this.element)
  }
}

import { Controller } from "@hotwired/stimulus"
import gsap from "gsap"
import ScrollTrigger from "gsap/ScrollTrigger"

// Connects to data-controller="gsap"
export default class extends Controller {
  static targets = ["card1", "card2", "card3"]

  connect() {
    gsap.registerPlugin(ScrollTrigger)

    gsap.from(this.card1Target, {
      scrollTrigger: {
        trigger: this.card1Target,
        start: "top 60%",
        end: "top 40%",
        toggleActions: "play none reverse none",
      },
      opacity: 1,
      x: -700,
      duration: 1,
      ease: "power3.out"
    })

    gsap.from(this.card2Target, {
      scrollTrigger: {
        trigger: this.card2Target,
        start: "top 60%",
        end: "top 40%",
        toggleActions: "play none reverse none",
      },
      opacity: 0,
      scale: 0.8,
      duration: 1,
      ease: "back-out(1.7)"
    })

    gsap.from(this.card3Target, {
      scrollTrigger: {
        trigger: this.card3Target,
        start: "top 60%",
        end: "top 40%",
        toggleActions: "play none reverse none",
      },
      x: 400,
      opacity: 0,
      duration: 1,
      ease: "power3.out"
    })
  }
}

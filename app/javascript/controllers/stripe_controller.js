import { Controller } from "@hotwired/stimulus"
import { loadStripe } from "@stripe/stripe-js"

// Connects to data-controller="stripe"
export default class extends Controller {
  static values = {
    apiKey: String,
    secretClient: String,
    EventId: Number
  }
  static targets = ["card", "form", "submit"]

  async connect() {
    this.stripe = await loadStripe(this.apiKeyValue)
    this.elements = this.stripe.elements()
    this.cardElement = this.elements.create("card")
    this.cardElement.mount(this.cardTarget)
  }

  async submit(event) {
    event.preventDefault();
    this.submitTarget.disabled = true

    const { error, paymentIntent } = await this.stripe.confirmCardPayment(this.secretClientValue, {
      payment_method: {
        card: this.cardElement
      }
    })

    if (error) {
      console.log("stripe", error)
      alert(error.message)
      this.submitTarget.disabled = false
    } else if (paymentIntent && paymentIntent.status === "succeeded") {
      this.formTarget.submit();
    } else {
      alert("Payment not completed.")
      this.submitTarget.disabled = false
    }
  }
}

import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="interest-video"
export default class extends Controller {
  static targets = ["video"]

  play() {
    this.videoTarget.play();
  }

  pause() {
    this.videoTarget.pause();
    this.videoTarget.currentTime = 0;
  }
}

import { Controller } from "@hotwired/stimulus"
// there is a bug within turbo that dosent let you navigate
// from a frame more than once, to fix this you have to reset the frame
// src and all works. this is a monkey patch. to use it
// place it directly on a frame, data-controller="turbo-frame"
// Propagate event turbo-reset-src wherever it's neeeded

export default class extends Controller {
  
  initialize() {
    this.boundResetSrc = this.resetSrc.bind(this);
  }

  connect() {
    window.addEventListener("turbo-reset-src", this.boundResetSrc);
  }

  disconnect() {
    window.removeEventListener("turbo-reset-src", this.boundResetSrc);
  }

  resetSrc() {
    this.element.src = "";
  }
}
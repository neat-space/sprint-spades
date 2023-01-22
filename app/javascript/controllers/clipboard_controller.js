// src/controllers/clipboard_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  copy() {
    this.inputTarget.select();
    document.execCommand("copy");
    alert("Copied to clipboard!");
  }
}
// app/javascript/controllers/navbar_controller.js

import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = ["menu"];

  /**
   * Toggles the visibility of the mobile menu by toggling the 'hidden' class.
   * This method is triggered by the 'data-action="navbar#toggle"' attribute on the button.
   */
  toggle() {
    this.menuTarget.classList.toggle("hidden");
  }
}
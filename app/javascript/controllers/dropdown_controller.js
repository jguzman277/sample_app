// app/javascript/controllers/dropdown_controller.js

import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["menu"];
  static classes = ["hidden"];

  // The 'connect' method is a Stimulus lifecycle method that runs when the controller connects to the DOM.
  connect() {
    // Add a 'click' event listener to the entire document.
    document.addEventListener("click", this.hideMenu.bind(this));
  }

  // The 'disconnect' method is a Stimulus lifecycle method that runs when the controller disconnects from the DOM.
  disconnect() {
    // Clean up the event listener to prevent memory leaks.
    document.removeEventListener("click", this.hideMenu.bind(this));
  }

  toggle() {
    this.menuTarget.classList.toggle(this.hiddenClass);
  }

  hideMenu(event) {
    // Check if the click occurred outside of the controller's element.
    if (!this.element.contains(event.target)) {
      // If it did, add the 'hidden' class to the menu target.
      this.menuTarget.classList.add(this.hiddenClass);
    }
  }
}
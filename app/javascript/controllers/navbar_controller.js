import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["menu"]

  connect() {
    // Bind the close method to this instance so we can remove the listener later
    this.closeOnClickOutside = this.closeOnClickOutside.bind(this)
  }

  toggle(event) {
    event.stopPropagation()
    this.menuTarget.classList.toggle("hidden")
    
    if (!this.menuTarget.classList.contains("hidden")) {
      // Add click listener to close dropdown when clicking outside
      document.addEventListener("click", this.closeOnClickOutside)
    }
  }

  close() {
    this.menuTarget.classList.add("hidden")
    document.removeEventListener("click", this.closeOnClickOutside)
  }

  closeOnClickOutside(event) {
    if (!this.element.contains(event.target)) {
      this.close()
    }
  }

  disconnect() {
    // Clean up event listener when controller is disconnected
    document.removeEventListener("click", this.closeOnClickOutside)
  }
}
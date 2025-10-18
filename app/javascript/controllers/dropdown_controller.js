import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["menu"]

  connect() {
    this.closeOnClickOutside = this.closeOnClickOutside.bind(this)
    this.closeOnNavigate = this.closeOnNavigate.bind(this)
    
    // Listen for Turbo navigation events
    document.addEventListener("turbo:before-visit", this.closeOnNavigate)
    document.addEventListener("turbo:before-frame-render", this.closeOnNavigate)
  }

  toggle(event) {
    event.preventDefault()
    event.stopPropagation()
    
    const isCurrentlyHidden = this.menuTarget.classList.contains("hidden")
    
    // Close all other dropdowns first
    this.closeAllDropdowns()
    
    // Toggle this dropdown
    if (isCurrentlyHidden) {
      this.menuTarget.classList.remove("hidden")
      document.addEventListener("click", this.closeOnClickOutside)
    }
  }

  close() {
    if (!this.menuTarget.classList.contains("hidden")) {
      this.menuTarget.classList.add("hidden")
      document.removeEventListener("click", this.closeOnClickOutside)
    }
  }

  closeAllDropdowns() {
    // Close all dropdown menus
    document.querySelectorAll("[data-dropdown-target='menu']").forEach(menu => {
      menu.classList.add("hidden")
    })
    // Close all notification menus
    document.querySelectorAll("[data-notifications-target='menu']").forEach(menu => {
      menu.classList.add("hidden")
    })
    document.removeEventListener("click", this.closeOnClickOutside)
  }

  closeOnClickOutside(event) {
    if (!this.element.contains(event.target)) {
      this.close()
    }
  }

  closeOnNavigate() {
    this.close()
  }

  disconnect() {
    // Clean up all event listeners when controller is disconnected
    document.removeEventListener("click", this.closeOnClickOutside)
    document.removeEventListener("turbo:before-visit", this.closeOnNavigate)
    document.removeEventListener("turbo:before-frame-render", this.closeOnNavigate)
  }
}
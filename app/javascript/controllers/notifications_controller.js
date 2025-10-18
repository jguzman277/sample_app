import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notifications"
export default class extends Controller {
  static targets = ["menu", "badge", "list"]
  static values = { 
    unreadCount: Number 
  }

  connect() {
    this.closeOnClickOutside = this.closeOnClickOutside.bind(this)
    this.closeOnNavigate = this.closeOnNavigate.bind(this)
    
    document.addEventListener("turbo:before-visit", this.closeOnNavigate)
    document.addEventListener("turbo:before-frame-render", this.closeOnNavigate)
  }

  toggle(event) {
    event.preventDefault()
    event.stopPropagation()
    
    const isCurrentlyHidden = this.menuTarget.classList.contains("hidden")
    
    // Close all other dropdowns first
    this.closeAllDropdowns()
    
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

  updateBadge(count) {
    if (this.hasBadgeTarget) {
      if (count > 0) {
        this.badgeTarget.textContent = count > 9 ? '9+' : count
        this.badgeTarget.classList.remove('hidden')
      } else {
        this.badgeTarget.classList.add('hidden')
      }
    }
  }

  unreadCountValueChanged() {
    this.updateBadge(this.unreadCountValue)
  }

  disconnect() {
    document.removeEventListener("click", this.closeOnClickOutside)
    document.removeEventListener("turbo:before-visit", this.closeOnNavigate)
    document.removeEventListener("turbo:before-frame-render", this.closeOnNavigate)
  }
}
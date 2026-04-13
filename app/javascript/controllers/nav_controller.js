import { Controller } from "@hotwired/stimulus"

// Toggles the off-canvas sidebar on mobile.
// Usage: data-controller="nav" on the admin shell wrapper.
export default class extends Controller {
  static targets = ["sidebar", "backdrop"]

  toggle() {
    const isOpen = this.sidebarTarget.classList.toggle("is-open")
    this.backdropTarget.classList.toggle("is-visible", isOpen)
    document.body.style.overflow = isOpen ? "hidden" : ""
  }

  close() {
    this.sidebarTarget.classList.remove("is-open")
    this.backdropTarget.classList.remove("is-visible")
    document.body.style.overflow = ""
  }
}

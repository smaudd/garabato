import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  toggle() {
    this.element.classList.toggle("sidebar-open")
  }

  close() {
    this.element.classList.remove("sidebar-open")
  }
}

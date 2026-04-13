import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container", "template", "entry", "destroy"]

  addEntry() {
    const timestamp = new Date().getTime()
    const html = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, timestamp)
    this.containerTarget.insertAdjacentHTML("beforeend", html)
  }

  removeEntry(event) {
    const entry = event.target.closest("[data-nested-form-target='entry']")
    const destroyField = entry.querySelector("[data-nested-form-target='destroy']")

    if (destroyField) {
      destroyField.value = "1"
      entry.style.display = "none"
    } else {
      entry.remove()
    }
  }
}

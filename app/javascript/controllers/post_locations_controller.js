import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["companySelect", "locationsContainer", "selectAllBtn"]
  static values = { locationsUrl: String }

  connect() {
    if (this.companySelectTarget.value) {
      this.loadLocations(this.companySelectTarget.value)
    }
  }

  companyChanged() {
    const companyId = this.companySelectTarget.value
    if (companyId) {
      this.loadLocations(companyId)
    } else {
      const hint = this.locationsContainerTarget.dataset.noCompany
      this.locationsContainerTarget.innerHTML = `<em>${hint}</em>`
      this.selectAllBtnTarget.hidden = true
    }
  }

  loadLocations(companyId) {
    const url = this.locationsUrlValue.replace("__id__", companyId)
    fetch(url, { headers: { Accept: "application/json" } })
      .then(r => r.json())
      .then(locations => this.renderLocations(locations))
  }

  renderLocations(locations) {
    if (locations.length === 0) {
      const hint = this.locationsContainerTarget.dataset.noLocations
      this.locationsContainerTarget.innerHTML = `<em>${hint}</em>`
      this.selectAllBtnTarget.hidden = true
      return
    }

    const selectedIds = this.selectedLocationIds()
    this.locationsContainerTarget.innerHTML = locations.map(l => `
      <label>
        <input type="checkbox" name="post[location_ids][]" value="${l.id}" ${selectedIds.includes(String(l.id)) ? "checked" : ""}>
        ${l.name}
      </label>
    `).join("")
    this.selectAllBtnTarget.hidden = false
    this.selectAllBtnTarget.textContent = this.selectAllBtnTarget.dataset.selectText
  }

  selectedLocationIds() {
    return Array.from(this.locationsContainerTarget.querySelectorAll("input[type=checkbox]:checked"))
      .map(cb => cb.value)
  }

  toggleAll() {
    const checkboxes = this.locationsContainerTarget.querySelectorAll("input[type=checkbox]")
    const allChecked = Array.from(checkboxes).every(cb => cb.checked)
    checkboxes.forEach(cb => cb.checked = !allChecked)
    const selectText = this.selectAllBtnTarget.dataset.selectText
    const deselectText = this.selectAllBtnTarget.dataset.deselectText
    this.selectAllBtnTarget.textContent = allChecked ? selectText : deselectText
  }
}

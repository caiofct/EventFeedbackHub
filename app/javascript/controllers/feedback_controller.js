import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="feedback"
export default class extends Controller {
  connect() {
  }

  resetForm() {
    this.element.reset();
  }
}

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    siteKey: String,
    fieldName: String,
  }

  // Turnstile automatically inserts a hidden input if rendered inside a form
  connect() {
    this.button.disabled = true
    this.id = turnstile.render(this.element, {
      sitekey: this.siteKeyValue,
      "response-field-name": this.fieldNameValue,
      callback: () => this.button.disabled = false
    })
  }

  disconnect() {
    turnstile.remove(this.id)
  }

  get form() {
    return this.element.closest("form")
  }

  get button() {
    return this.form.querySelector("input[type=submit]") || this.form.querySelector("button")
  }
}

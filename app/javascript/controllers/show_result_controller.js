import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="show-result"
export default class extends Controller {
  static targets = ["healthCheckDate", "resultStatus", "form"]

  connect() {
    console.log("connect to show result controller")
  }

  show() {
    console.log("fire form submit")


  }
}

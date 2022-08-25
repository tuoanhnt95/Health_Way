import { Controller } from "@hotwired/stimulus"
import Litepicker from 'litepicker';

// Connects to data-controller="litepicker"
export default class extends Controller {
  static targets = ["start", "end"]

  connect() {
    const picker = new Litepicker({
      element: this.startTarget,
      elementEnd: this.endTarget,
      singleMode: false
    });
  }
}

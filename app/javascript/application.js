// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "bootstrap"

import $ from 'jquery';
import 'select2';

const initSelect2 = () => {
  $('.select2').select2();
};

document.addEventListener("turbolinks:load", function() {
  initSelect2();
});

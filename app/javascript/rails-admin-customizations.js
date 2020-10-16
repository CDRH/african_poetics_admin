export function start() {
  document.addEventListener("DOMContentLoaded", function() {
    var MODELS_SHOWING_NEW_BUTTON = [
      "news_item",
      "event",
    ];

    var page_header = document.querySelector(".page-header");

    if (page_header !== null) {
      var rails_admin_model = page_header.dataset.model;

      if (rails_admin_model !== undefined &&
          !MODELS_SHOWING_NEW_BUTTON.includes(rails_admin_model)) {
        var new_item_link = document.querySelector(".nav-tabs .new_collection_link");

        new_item_link.style.display = "none";
      }
    }
  });
}

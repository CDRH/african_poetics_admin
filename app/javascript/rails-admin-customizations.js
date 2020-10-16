export function start() {
  document.addEventListener("DOMContentLoaded", function() {
    var page_header = document.querySelector(".page-header");

    if (page_header !== null) {
      var rails_admin_model = page_header.dataset.model;

      if (rails_admin_model !== undefined) {
        var models_showing_new_button = ["news_item", "event"];

        if (!models_showing_new_button.includes(rails_admin_model)) {
          var new_item_link = document.querySelector(".nav-tabs .new_collection_link");

          new_item_link.style.display = "none";
        }
      }
    }
  });
}

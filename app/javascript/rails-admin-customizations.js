export function start() {
  document.addEventListener("DOMContentLoaded", function() {
    var MODELS_SHOWING_NEW_BUTTON = [
      "news_item",
      "event",
      "commentary",
      "meta_commentary"
    ];

    var page_header = document.querySelector(".page-header");

    if (page_header !== null) {
      var rails_admin_model = page_header.dataset.model;

      if (rails_admin_model !== undefined) {
        if (!MODELS_SHOWING_NEW_BUTTON.includes(rails_admin_model)) {
          var new_item_link = document.querySelector(".nav-tabs .new_collection_link");
          new_item_link.style.display = "none";
        }

        // Open all filters on model index pages
        var filter_toggles = document.querySelectorAll("#filters a");
        filter_toggles.forEach(function (toggle) { toggle.click(); });

        // Hide default filter
        document.querySelector("#remove_filter").parentNode.parentNode.style.visibility = "hidden";

        // Set filters to 'like' value (Contains / Number…) in selects
        var contains_options = document.querySelectorAll("#filters_box option[value='like']");
        contains_options.forEach(function (option) {
          option.parentNode.value = 'like';
        });

        // Create links where pjax was required to sort before it was disabled
        var headers = document.querySelectorAll("#bulk_form .header.pjax");
        headers.forEach(function (h) {
          h.innerHTML = '<a href="' + h.dataset.href + '">' + h.innerHTML
            + '</a>';
        });
      }
    }
  });
}

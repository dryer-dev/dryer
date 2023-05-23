import NestedFields from "./nested_fields";
// https://stevepolito.design/blog/create-a-nested-form-in-rails-from-scratch/
// app/javascript/packs/nested-forms/addFields.js
class addFields {
  // This executes when the function is instantiated.
  constructor() {
    this.links = document.querySelectorAll(".add_fields");
    this.iterateLinks();
  }

  iterateLinks() {
    // If there are no links on the page, stop the function from executing.
    if (this.links.length === 0) return;
    // Loop over each link on the page. A page could have multiple nested forms.
    this.links.forEach((link) => {
      link.addEventListener("click", (e) => {
        this.handleClick(link, e);
      });
    });
  }

  handleClick(link, e) {
    // Stop the function from executing if a link or event were not passed into the function.
    if (!link || !e) return;
    // Prevent the browser from following the URL.
    e.preventDefault();
    const nestedFields = new NestedFields(link.dataset.id, link.dataset.fields);
    link.parentElement.insertBefore(nestedFields, link);
  }
}

// Wait for turbolinks to load, otherwise `document.querySelectorAll()` won't work
window.addEventListener("load", () => new addFields());
// Wait for turbolinks to load, otherwise `document.querySelectorAll()` won't work
window.addEventListener("turbolinks:load", () => new addFields());


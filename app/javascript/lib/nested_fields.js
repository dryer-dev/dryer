import { createRef } from './utilities.js';
// Based on https://stevepolito.design/blog/create-a-nested-form-in-rails-from-scratch/
// refactored for event delegation vs class object
// we're nesting forms within nested forms and this js will only be loaded in edit views
export default class NestedFields extends HTMLElement {
  constructor(dataset) {
    super();
    this.id = dataset?.id || this.dataset.id;
    this.fields = dataset?.fields || this.innerHTML;
    this.ref = createRef();
    this.dataset.editor = dataset?.editor || this.dataset.editor;
    this.dataset.editorRef = this.ref;
  }
  // Fires when attached
  connectedCallback() { 
    this.innerHTML = this.newFields();
    this.setupRemoveLink();
    // handleEditorJS(this);
  }    
  // Replace all instances of the `new_object.object_id` with `time`, and save markup into a
  // variable if there's a value in `regexp`.
  newFields() {
    if (this.regexp()) {
      return this.fields.replace(this.regexp(), this.ref);
    }
    return null;
  }
  // Create a new regular expression needed to find any instance of the `new_object.object_id`
  // used in the fields data attribute if there's a value in `linkId`.
  regexp() {
    const id = this.id;
    if (id) {
      return new RegExp(id, 'g');
    }
    return null;    
  }
    
  removeFields() {
    // find the hidden delete field.
    const deleteField = this.querySelector('input[type="hidden"]')
    // If there is a delete field, update the value to `1` and hide the corresponding nested fields.
    if (deleteField) {
      deleteField.value = 1
      this.style.display = 'none'
    }
  }

  setupRemoveLink() {
    const link =  document.createElement("a");
    link.href = "#0";
    link.innerHTML = "✕";
    link.classList.add("remove_fields");
    link.onclick = (e) => {
      e.preventDefault();
      this.removeFields();
    }

    return this.appendChild(link);
  }
}

customElements.define('nested-fields', NestedFields);

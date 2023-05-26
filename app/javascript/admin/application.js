require("../lib/add_fields");
import EditorInstance from "../lib/editor_instance";

function setupEditors() {
  const nestedFields = document.getElementsByTagName("nested-fields");

  if (nestedFields.length > 0) {
    for (const field of nestedFields) {
      if ("editorRef" in field.dataset) {
        const editor = new EditorInstance(field);
      }
    }
  }
}

window.addEventListener("load", () => {
  setupEditors();
});




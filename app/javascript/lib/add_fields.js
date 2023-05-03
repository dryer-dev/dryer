import EditorJS from '@editorjs/editorjs';
import Header from '@editorjs/header'; 
import List from '@editorjs/list'; 
// or if you inject ImageTool via standalone script
const ImageTool = window.ImageTool;
// Based on https://stevepolito.design/blog/create-a-nested-form-in-rails-from-scratch/
// refactored for event delegation vs class object
// we're nesting forms within nested forms and this js will only be loaded in edit views
function addNestedFields(e) {
  // Prevent the browser from following the URL.
  e.preventDefault();
  // Get element
  let element = e.target;
  // Save a unique timestamp to ensure the key of the associated array is unique.
  let time = new Date().getTime();
  // Save the data id attribute into a variable. This corresponds to `new_object.object_id`.
  let linkId = element.dataset.id;
  // Create a new regular expression needed to find any instance of the `new_object.object_id`
  // used in the fields data attribute if there's a value in `linkId`.
  let regexp = linkId
               ? new RegExp(linkId, 'g')
               : null;
  // Replace all instances of the `new_object.object_id` with `time`, and save markup into a
  // variable if there's a value in `regexp`.
  let newFields = regexp
                  ? element.dataset.fields.replace(regexp, time)
                  : null;
  // Add the new markup to the form if there are fields to add.
  if ( newFields ) {
     element.insertAdjacentHTML('beforebegin', newFields)
     element.insertAdjacentHTML('beforebegin', "<div id='editorjs-" + time + "'></div>")
    const editor = new EditorJS({
      autofocus: true,
      minHeight: 13,
      holder: 'editorjs-' + time,
      tools: {
        header: {
          class: Header, 
          inlineToolbar: ['link'] 
        },
        list: { 
          class: List, 
          inlineToolbar: true 
        }
      },
    });
  } else {
    return null;
  }
}

document.addEventListener('click', e => {
  if ( !e.target || !e.target.classList.contains('add_fields') ) return;
  addNestedFields(e);
});

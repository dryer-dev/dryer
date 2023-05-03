// https://stevepolito.design/blog/create-a-nested-form-in-rails-from-scratch/
// refactored for event delegation vs class object
// we're nesting forms within nested forms and this js will only be loaded in edit views
function removeNestedFields(e) {
  // Prevent the browser from following the URL.
  e.preventDefault()
  // Get element
  let element = e.target;
  // Find the parent wrapper for the set of nested fields.
  let fieldParent = element.closest('.nested-field')
  // If there is a parent wrapper, find the hidden delete field.
  let deleteField = fieldParent
    ? fieldParent.querySelector('input[type="hidden"]')
    : null
  // If there is a delete field, update the value to `1` and hide the corresponding nested fields.
  if (deleteField) {
    deleteField.value = 1
    fieldParent.style.display = 'none'
  }
}

document.addEventListener('click', function(e){
  if ( !e.target || !e.target.classList.contains('remove_fields') ) return;
  removeNestedFields(e);
});

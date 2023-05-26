import EditorJS from '@editorjs/editorjs';
import Header from '@editorjs/header'; 
import List from '@editorjs/list'; 
// we'll could have multiple instances of EditorJS on any page
// so we'll create a class to manage each instance
export default class EditorInstance extends EditorJS {
  // pass the DOM element to the constructor
  constructor(el) {
    // capture the intended EditorJS container
    const container = el.querySelector("[data-editor-container]");
    // get the unique reference for this instance
    const ref = el.dataset.editorRef;
    // set the container id to the unique reference 
    container.id = `editorjs-${ref}`;
    // get the input field for the EditorJS data
    const input = el.querySelector("[data-editor-input]");
    // parse any previously saved input field data into JSON
    const input_data = JSON.parse(input.value);
    // create the EditorJS instance
    // and pass the configuration options
    super({
      autofocus: true,
      minHeight: 0,
      holder: container.id,
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
      data: input_data,
      onChange: async() => {
        const data = await this.save();
        this.editorInstanceDataInput.value = JSON.stringify(data);
      }
    })
    // in case we need to refer to the DOM elements later
    this.editorInstanceContainer = container;
    this.editorInstanceDataInput = input;
  } 
}   
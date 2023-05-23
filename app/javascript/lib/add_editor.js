import EditorJS from '@editorjs/editorjs';
import Header from '@editorjs/header'; 
import List from '@editorjs/list'; 

export default function addEditorJS(el, ref) {
  el.id = `editorjs-${ref}`;

  const editor = new EditorJS({
    autofocus: true,
    minHeight: 13,
    holder: 'editorjs-' + ref,
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
}

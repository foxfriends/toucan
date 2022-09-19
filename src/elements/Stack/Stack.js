import "./Stack.css";

export default class Stack extends HTMLElement {}

if ("customElements" in window) {
  customElements.define("stack-l", Stack);
}

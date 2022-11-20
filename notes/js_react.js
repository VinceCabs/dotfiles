// codepen test : https://codepen.io/VinceCabs/pen/BadRavW

// Install
// npm install react react-dom

import React from "react";


// React Version
console.log(React.version);

// Rappel DOM : document.createElement
const element = document.createElement("h2");
element.className = "name-of-class";  // note : "className" and not "class"
element.style = "color: red; background-color: blue";
document.body.appendChild(element);

// React.createElement(type, options, children)
const element = React.createElement("h1", {}, "Hello World");
const element = React.createElement("h1", { className: "center", style: "color: red" });
// returns
// {
//   type: "h1",
//   props: {className: "center", style: "color: red"}
// };
const element = React.createElement("h1", { className: "center", style: "color: red" }, "Hello World");
// returns
// {
//   type: "h1",
//   props: {
//     // ...
//     children : "Hello World"
//   } 
// };

//// ReactDOM ////
// React --> ReactDOM --> DOM
// (and React --> ReactNative)

//ReactDom.render()
import ReactDOM from "react-dom"; // OR
import { render } from "react-dom";

const root = document.querySelector("#root");
const element = React.createElement("h1", {}, "Hello World");
ReactDOM.render(element, root);

//// JSX ////
const title = <h1>Hello World</h1>
// generates
const title = React.createElement("h1", {}, "Hello World");
// ! JSX is not HTML !
// test here : https://babeljs.io/en/repl#?browsers=&build=&builtIns=false&spec=false&loose=false&code_lz=MYewdgzgLgBApgGzgWzmWBeGAeAFgRgD4AJRBEGAdRACcEATbAegMKA&debug=false&forceAllTransforms=false&shippedProposals=false&circleciRepo=&evaluate=false&fileSize=false&timeTravel=false&sourceType=module&lineWrap=true&presets=es2015%2Creact&prettier=false

const root = document.querySelector("#root");
ReactDOM.render(<h1>Hello World</h1>, root);
// with attributes (className !)
render(<p className="selected" id="promo">Hello World</p>, root);

// expressions
const title = <h1>You have {2 + 3} notifications</h1>;
const element = <p className="user-info">Welcome {user.name}!</p>
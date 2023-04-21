/**
 * Utils & good practice
 */

// measure execution time
console.time("Label A");
for (let i = 0; i < 100; i++) {
  // do smthg
}
console.timeEnd("Label A");
// Label A: 250.34 ms

// set Default objects with Object.assign()
const myFruit = {
  color: "yellow",
  taste: "sweet",
};
function createFruit(fruit) {
  // use Object.assign to enrich default fruit
  let finalFruit = Object.assign(
    {
      shape: "sphere",
      color: "red",
    },
    fruit
  );
  return finalFruit;
}
createFruit(myFruit);
// {
//     shape: 'sphere',
//     color: 'yellow',
//     taste: 'sweet'
// }

/**
 * Arrays manipulation
 * from https://www.freecodecamp.org/news/manipulating-arrays-in-javascript/
 */

// toString()

// join()

// concat()

// push(): adds items to the end
const browsers = [];
browsers = ["chrome", "firefox", "edge"];
browsers.push("safari", "opera mini"); // changes array
console.log(browsers); // ["chrome", "firefox", "edge", "safari", "opera mini"]

// pop(): removes last item and removes it
browsers = ["chrome", "firefox", "edge"];
browsers.pop(); // "edge"
console.log(browsers); // ["chrome", "firefox"]

// shift(): removes first item and returns it
browsers = ["chrome", "firefox", "edge"];
browsers.shift(); // "chrome"
console.log(browsers); // ["firefox", "edge"]

// unshift(): adds item(s) to the beginning
browsers = ["chrome", "firefox", "edge"];
browsers.unshift("safari");
console.log(browsers); //  ["safari", "chrome", "firefox", "edge"]

// splice(start)
// splice(start, deleteCount)
// splice(start, deleteCount, item1, item2, itemN)
// removes items from start and optionnaly add other items
const colors = ["green", "yellow", "blue", "purple"];
colors.splice(0, 3); // returns ['green', 'yellow', 'blue']
console.log(colors); // ["purple"]
// /!\ stops at index 2, not 3

// slice(start, end)
// /!\ does not change the original array
const animals = ["ant", "bison", "camel", "duck", "elephant"];
animals.slice(2); // ["camel", "duck", "elephant"]
animals.slice(2, 4); // ["camel", "duck"]

// String.prototype.split(): retunrs an array with substrings
// split(separator)
// split(separator, limit) : limit the number of substring returne in the array
const monthString = "Jan,Feb,Mar,Apr";
monthString.split(","); //  ['Jan', 'Feb', 'Mar', 'Apr']
monthString.split(",", 2); // ['Jan', 'Feb']

// filter()
const words = ["spray", "limit", "elite", "exuberant", "destruction"];
const result = words.filter((word) => word.length > 6); // ["exuberant", "destruction"];

// map()
// /!\ does not change the original array
const numbers = [1, 2, 3, 4];
numbers.map((x) => x * x); // [1, 4, 9, 16]

/**
 * Promises
 */

new Promise((res, rej) => {});
// Promise have a status and a value :
// [[PromiseState]]: "pending"  or "fulfilled" or "rejected"
// [[PromiseResult]]: undefined

new Promise((res, rej) => {
  try {
    // Perform a task
    res("pouet"); // resolve
  } catch (e) {
    rej(new Error(e)); // reject
  }
});

new Promise((res, rej) => res("glop"));
// [[PromiseState]]: "fulfilled"
// [[PromiseResult]]: "glop"

new Promise((res, rej) => rej("pas glop"));
// /!\ Uncaught (in promise) pas glop
// better :
new Promise((res, rej) => rej(new Error("pas glop")));
// [[PromiseState]]: "rejected"
// [[PromiseResult]]: "pas glop"
// /!\ Uncaught (in promise) Error: pas glop

Promise.resolve("glop"); // shortcut to create a resolved Promise

Promise.resolve("2")
  .then((res) => res * 2) // 4
  .then((res) => res * 2) // 8
  .then(console.log); // shortcut!

/**
 * Javascript event loop:
 * Microtasks are executed before Tasks
 */
console.log("Start!");
// schedule task
setTimeout(() => {
  console.log("Timeout!");
}, 0);
// schedule microtask
Promise.resolve("Promise!").then(console.log);
console.log("End!");
// Start!
// End!
// Promise!
// Timeout!

/**
 * async/await (ES7)
 */

// syntax (1)
async function f() {
  let promise = new Promise(() => {});
  let result = await promise; // wait until promise resolves
}

// syntax (2)
async function greet() {
  return "hello!";
}
// is equivalent to:
function greet() {
  return Promise.resolve("hello!");
}
// is similar to:
Promise.resolve("hello!");
// in all cases:
greet().then(console.log); // hello !

// sample (1)
async function greet() {
  let p = new Promise((res) => {
    setTimeout(() => res("hello!"), 1000);
  });
  let result = await p; // wait until the promise resolves
  console.log(result);
}
greet(); // 1sec ... "hello!"

// sample (2)
async function showLogo() {
  let response = await fetch("https://api.github.com/users/VinceCabs"); // Response {type:...}
  let user = await response.json(); // Object {login: 'VinceCabs', ...}

  let img = document.createElement("img");
  img.src = user.avatar_url;
  document.body.prepend(img); // like append but inserts at the beginning of parent node
}
showLogo();

// sample (2 bis)
async function showLogo() {
  let user = await getUser(); // factorized

  let img = document.createElement("img");
  img.src = user.avatar_url;
  document.body.prepend(img);
}
async function getUser() {
  let response = await fetch("https://api.github.com/users/VinceCabs");
  let user = await response.json();
  return user;
}
showLogo();

// sample (2 ter) : full rewrite with .then()
async function showLogo() {
  fetch("https://api.github.com/users/VinceCabs")
    .then((response) => {
      return response.json();
    })
    .then((user) => {
      console.log(user);
      let img = document.createElement("img");
      img.src = user.avatar_url;
      document.body.prepend(img);
    });
}
showLogo();

// sample (3)
async function wait(delay) {
  await new Promise((res) => setTimeout(res, delay));
}
wait(1000).then(() => console.log("pouet!"));

/**
 * for...in, for...of, .forEach()
 */

for (let prop in ["a", "b", "c"]) console.log(prop); // 0, 1, 2 (array indexes)
for (let prop in "str") console.log(prop); // 0, 1, 2 (string indexes)
for (let prop in { a: 1, b: 2, c: 3 }) console.log(prop); // a, b, c (object property names)

for (let val of ["a", "b", "c"]) console.log(val); // a, b, c (array values)
for (let val of "str") console.log(val); // s, t, r (string characters)
for (let val of { a: 1, b: 2, c: 3 }) console.log(prop); // TypeError (not iterable)

["a", "b", "c"].forEach(
  (val) => console.log(val) // a, b, c (array values)
);
["a", "b", "c"].forEach(
  (val, i) => console.log(i) // 0, 1, 2 (array indexes)
);

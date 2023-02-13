/**  
 * Utils
 */

// measure execution time
console.time("Label A")
for (let i = 0; i < 100; i++) {
    // do smthg
}
console.timeEnd("Label A")
// Label A: 250.34 ms

/**  
 * Promises
 */

new Promise((res, rej) => { })
// Promise have a status and a value :
// [[PromiseState]]: "pending"  or "fulfilled" or "rejected"
// [[PromiseResult]]: undefined

new Promise((res, rej) => {
    try {
        // Perform a task
        res("pouet")  // resolve
    } catch (e) {
        rej(new Error(e))  // reject
    }
})

new Promise((res, rej) => res("glop"))
// [[PromiseState]]: "fulfilled"
// [[PromiseResult]]: "glop"

new Promise((res, rej) => rej("pas glop"))
// /!\ Uncaught (in promise) pas glop
// better :
new Promise((res, rej) => rej(new Error("pas glop")))
// [[PromiseState]]: "rejected"
// [[PromiseResult]]: "pas glop"
// /!\ Uncaught (in promise) Error: pas glop

Promise.resolve("glop")  // shortcut to create a resolved Promise

Promise.resolve("2")
    .then(res => res * 2)  // 4
    .then(res => res * 2)  // 8
    .then(console.log)  // shortcut!

/** 
 * Javascript event loop:
 * Microtasks are executed before Tasks
 */
console.log("Start!")
// schedule task
setTimeout(() => {
    console.log("Timeout!")
}, 0)
// schedule microtask
Promise.resolve("Promise!")
    .then(res => console.log(res))
console.log("End!")
// Start!
// End!
// Promise!
// Timeout!

/**
 * async/await (ES7)
 */

// syntax (1)
async function f() {
    let promise = new Promise(() => { })
    let result = await promise  // wait until promise resolves
}

// syntax (2)
async function greet() { return "hello!" }
// is equivalent to:
function greet() { return Promise.resolve("hello!") }
// is similar to:
Promise.resolve("hello!")
// in all cases:
greet().then(console.log)  // hello !

// sample (1)
async function greet() {
    let p = new Promise(res => {
        setTimeout(() => res("hello!"), 1000)
    });
    let result = await p; // wait until the promise resolves
    console.log(result);
}
greet() // 1sec ... "hello!"

// sample (2)
async function showLogo() {

    let response = await fetch("https://api.github.com/users/VinceCabs") // Response {type:...}
    let user = await response.json() // Object {login: 'VinceCabs', ...}

    let img = document.createElement('img')
    img.src = user.avatar_url
    document.body.prepend(img)  // like append but inserts at the beginning of parent node
}
showLogo()

// sample (2 bis)
async function showLogo() {

    let user = await getUser()  // factorized

    let img = document.createElement('img')
    img.src = user.avatar_url
    document.body.prepend(img)
}
async function getUser() {
    let response = await fetch("https://api.github.com/users/VinceCabs")
    let user = await response.json()
    return user
}
showLogo()

// sample (2 ter) : full rewrite with .then()
async function showLogo() {
    fetch("https://api.github.com/users/VinceCabs")
        .then(response => {
            return response.json()
        })
        .then(user => {
            console.log(user)
            let img = document.createElement('img')
            img.src = user.avatar_url
            document.body.prepend(img)
        })
}
showLogo()

// sample (3)
async function wait(delay) {
    await new Promise((res) => setTimeout(res, delay))
}
wait(1000).then(() => console.log("pouet!"))

// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");

import "stylesheets/application";
import "@fortawesome/fontawesome-free/js/all";

// window.onload = function () {
//   // ナビゲーション
//   const nav = document.querySelector("#navArea");
//   const btn = document.querySelector(".tham-box");
//   const mask = document.querySelector("#mask");
//   const open = "open";

//     btn.onclick = function () {
//         console.log("btn clicked");
//     if (!nav.classList.contains(open)) {
//       nav.classList.add(open);
//     } else {
//       nav.classList.remove(open);
//     }
//   };

//   mask.onclick = function () {
//     nav.classList.remove(open);
//   };
// };

// ハンバーガーメニュー
document.addEventListener('turbolinks:load', (event) => {
  // ナビゲーション
  const nav = document.querySelector("#navArea");
  const btn = document.querySelector(".tham-box");
  const mask = document.querySelector("#mask");
  const open = "open";

  btn.onclick = function () {
    console.log("btn clicked");
    if (!nav.classList.contains(open)) {
      nav.classList.add(open);
    } else {
      nav.classList.remove(open);
    }
  };

  mask.onclick = function () {
    nav.classList.remove(open);
  };
});

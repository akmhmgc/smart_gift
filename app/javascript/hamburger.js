// ハンバーガーメニュー
document.addEventListener('turbolinks:load', (event) => {
    // ナビゲーション
    const nav = document.querySelector("#navArea");
    const btn = document.querySelector(".tham-box");
    const mask = document.querySelector("#mask");
    const open = "open";

    btn.onclick = function () {
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
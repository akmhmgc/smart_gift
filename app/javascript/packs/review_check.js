const review_title = document.querySelector("#review_title");
const review_body = document.querySelector("#review_body");
const btn = document.querySelector("#review_post");

var review_check = function () {
    const title_content = review_title.value.replace(/^\s+/, '');
    const body_content = review_body.value.replace(/^\s+/, '');
    if (0 < title_content.length && title_content.length <= 30 && 0 < body_content.length && body_content.length <= 140) {
        btn.disabled = false;
        btn.classList.add('bg-red-300','hover:bg-red-400');
        btn.classList.remove('bg-gray-300');
    } else {
        btn.disabled = true;
        btn.classList.remove('bg-red-300','hover:bg-red-400');
        btn.classList.add('bg-gray-300');
    }
};

review_title.addEventListener('input',review_check);
review_body.addEventListener('input',review_check);
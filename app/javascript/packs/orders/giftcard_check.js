const message = document.querySelector("#message_box");
const sender_name = document.querySelector("#sender_name");
const btn = document.querySelector("#giftcard_post");

var review_check = function () {
    const message_content = message.value.replace(/^\s+/, '');
    const sender_name_content = sender_name.value.replace(/^\s+/, '');
    if (0 < message_content.length && message_content.length <= 300 && 0 < sender_name_content.length && sender_name_content.length <= 20) {
        btn.disabled = false;
        btn.classList.add('bg-red-300', 'hover:bg-red-400');
        btn.classList.remove('bg-gray-300', 'cursor-not-allowed');
    } else {
        btn.disabled = true;
        btn.classList.remove('bg-red-300', 'hover:bg-red-400', 'cursor-pointer');
        btn.classList.add('bg-gray-300', 'cursor-not-allowed');
    }
};


if (document.querySelector(".order_item") != null) {
    message.addEventListener('input', review_check);
    sender_name.addEventListener('input', review_check);
};
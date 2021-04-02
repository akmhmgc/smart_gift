window.calc_orders = function (obj) {
  // 合計値の計算
  sum_orders();
  //更新ボタンの出現
  const nextSibling = obj.nextElementSibling;
  nextSibling.style.display = "inline";
}


function sum_orders() {
  const items = document.querySelectorAll("li.list-none");
  var sum = 0;
  items.forEach((item) => {
    price = item.querySelector("#price").value;
    quantity = item.querySelector("#quantity").value;
    sum += price * quantity
  })
  var sumMsg = document.querySelector('#sum');
  sumMsg.textContent = `${sum}円`;
}



document.addEventListener('DOMContentLoaded', sum_orders);
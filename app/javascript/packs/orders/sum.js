window.calc_sum = function () {
  const items = document.querySelectorAll("li.list-none");
  var sum = 0;
  items.forEach((item) => {
    price = item.querySelector("#price").value;
    quantity = item.querySelector("#quantity").value;
    sum += price * quantity
  })
  console.log(sum);
}
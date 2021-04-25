const copyBtn = document.querySelector("#url_copy");

function copyUrl() {
  var url = location.href;
  navigator.clipboard.writeText(url);
  alert("urlがコピーされました");
}

copyBtn.addEventListener('click', copyUrl);
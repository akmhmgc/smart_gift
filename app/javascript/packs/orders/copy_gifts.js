const btn = document.getElementById('copy_btn');
btn.addEventListener('click', function() {
  
  var copyTarget = document.getElementById("copyTarget");

  // コピー対象のテキストを選択する
  copyTarget.select();

  // 選択しているテキストをクリップボードにコピーする
  document.execCommand("Copy");

  // コピーをお知らせする
  alert("コピーできました！ : " + copyTarget.value);
}, false);
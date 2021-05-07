const copyBtn = document.querySelector("#url_copy");
var url = location.href;


const clipbordCopy = () =>{
  if( !navigator.clipboard ) {
      alert("クリップボードにコピーできませんでした");return false;
  }
  navigator.clipboard.writeText(url).then(
      ()=>alert("クリップボードにコピーしました。SNSなどでプレゼントできます。"),
      ()=>alert("クリップボードにコピーできませんでした")
  );
  return true;
};

copyBtn.addEventListener('click', clipbordCopy);
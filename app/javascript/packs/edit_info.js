const img_field = document.querySelector("#image_field");
const img_prev = document.querySelector(".image_prev");

img_field.addEventListener('change', function () {
    var size_in_megabytes = this.files[0].size / 1024 / 1024;
    if (size_in_megabytes > 5) {
        alert("このサイトのアップロード最大サイズ(5MB)を超えています。");
        img_field.value = "";
    }
});

function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            img_prev.setAttribute('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
    }
}

img_field.addEventListener('change', function () {
    readURL(this);
}, false);
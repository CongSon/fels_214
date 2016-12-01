var loadFile = function(event) {
  var reader = new FileReader();
  reader.onload = function(){
    var output = document.getElementById('avatar');
    output.src = reader.result;
    output.width = 200;
    output.height = 200;
  };
  var size_in_megabytes = event.target.files[0].size/1024/1024;
  if (size_in_megabytes > 5) {
    alert(I18n.t('max_size'));
  }
  reader.readAsDataURL(event.target.files[0]);
};

$(document).on('turbolinks:load', function () {
  $(".import").click(function(){
  $("#import").fadeIn()
  });
});

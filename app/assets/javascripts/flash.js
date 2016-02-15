$(document).ready(function(){
  setTimeout(function(){
    $('#notification').fadeOut("slow", function(){
      $(this).remove();
    })
  }, 4000);
});

$(document).on("upload:start", "form", function(e) {
  $(this).find("input[type=submit]").attr("disabled", true)
});

$(document).on("upload:complete", "form", function(e) {
  if(!$(this).find("input.uploading").length) {
    $(this).find("input[type=submit]").removeAttr("disabled")
  }
});

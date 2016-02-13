$(document).ready(function(){
  setTimeout(function(){
    $('#notification').fadeOut("slow", function(){
      $(this).remove();
    })
  }, 4000);
});

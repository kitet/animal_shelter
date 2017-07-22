
$(document).ready(function(){
  $(".show_form").click(function(){
    $(".my_form").fadeIn(1500);
    $(".show_form").fadeOut(1500);
  });
  $(".submit_form").click(function(){
    $(".my_form").fadeOut(1500);
    $(".show_form").fadeIn(1500);
  });
  $(".cancel_form").click(function(){
    $(".my_form").fadeOut(1500);
    $(".show_form").fadeIn(1500);
  });
});

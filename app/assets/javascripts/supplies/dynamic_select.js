$(document).ready(function(){
  $(".contractor_customer_id").hide();
  $('input[type="radio"]').change(function(){
    var selected = $('input:checked[name="supplies_order[customer_type]"]').val();
    if(selected == "Project"){
      $(".contractor_customer_id").hide();
      $(".project_customer_id").show();
    } else if ( selected == "Contractor") {
      $(".project_customer_id").hide();
      $(".contractor_customer_id").show();
    }
  });
});

// $(document).ready(function(){
//   $("input[type=radio]").change(function (e) {
//       $(".contractor_customer, .project_customer").removeClass("selected");
//       $("." + $(e.currentTarget).val()).addClass("selected");
//   });
// });
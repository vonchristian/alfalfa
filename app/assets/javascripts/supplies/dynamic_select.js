$(document).ready(function(){
  $(".contractor_customer_id").hide();
  $(".customer_name").hide();
  $('input[type="radio"]').change(function(){
    var selected = $('input:checked[name="supplies_order[customer_type]"]').val();
    if(selected === "Project"){
      $(".contractor_customer_id").hide();
      $(".customer_name").hide();
      $(".project_customer_id").show();
    } else if ( selected === "Contractor") {
      $(".project_customer_id").hide();
      $(".customer_name").hide();
      $(".contractor_customer_id").show();
    } else if ( selected === "Customer") {
      $(".project_customer_id").hide();
      $(".contractor_customer_id").hide();
      $(".customer_name").show();
    }
  });
});

// $(document).ready(function(){
//   $("input[type=radio]").change(function (e) {
//       $(".contractor_customer, .project_customer").removeClass("selected");
//       $("." + $(e.currentTarget).val()).addClass("selected");
//   });
// });

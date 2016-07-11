$(document).ready(function(){
  $(".customer_name").hide();
  $(".contractor_name").hide();
  $(".project_select").hide();
  $('input[type="radio"]').change(function(){
    var selected = $('input:checked[name="supplies_order[customer_type]"]').val();
    if(selected === "Project"){
      $(".customer_name").hide();
      $(".contractor_select").hide();
      $(".project_select").show();
    } else if ( selected === "Contractor") {
      $(".customer_name").hide();
      $(".contractor_select").show();
      $(".project_select").hide();
    } else if ( selected === "Customer") {
      $(".customer_name").show();
      $(".contractor_select").hide();
      $(".project_select").hide();
    }
  });
});

// $(document).ready(function(){
//   $("input[type=radio]").change(function (e) {
//       $(".contractor_customer, .project_customer").removeClass("selected");
//       $("." + $(e.currentTarget).val()).addClass("selected");
//   });
// });

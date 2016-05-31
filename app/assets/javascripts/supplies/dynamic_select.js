$(document).ready(function(){
  $(".customer_name").hide();
  $('input[type="radio"]').change(function(){
    var selected = $('input:checked[name="supplies_order[customer_type]"]').val();
    if(selected === "Project"){
      $(".customer_name").hide();
      $(".project_contractor").show();
    } else if ( selected === "Contractor") {
      $(".customer_name").hide();
      $(".project_contractor").show();
    } else if ( selected === "Customer") {
      $(".project_contractor").hide();
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

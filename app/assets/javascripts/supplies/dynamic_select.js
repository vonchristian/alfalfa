$(document).ready(function(){
  $(".customer_name").hide();
  $(".select").show();
  $('input[type="radio"]').change(function(){
    var selected = $('input:checked[name="supplies_order[customer_type]"]').val();
    if(selected === "Project" || "Contractor"){
      $(".customer_name").hide();
      $(".select").show();
    } else if ( selected === "Customer") {
      $(".customer_name").show();
      $(".select").hide();
    }
  });
});

// $(document).ready(function(){
//   $("input[type=radio]").change(function (e) {
//       $(".contractor_customer, .project_customer").removeClass("selected");
//       $("." + $(e.currentTarget).val()).addClass("selected");
//   });
// });

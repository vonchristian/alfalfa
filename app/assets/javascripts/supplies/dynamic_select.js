$(document).ready(function(){
  $("#purpose_field").hide();
  $('input[type="radio"]').change(function(){
    var selected = $('input:checked[name="supplies_order[customer_type]"]').val();
    if(selected === "Project"){
      $("#purpose_field").hide();
      $(".select").show();

    } else if ( selected === "Contractor") {
      $("#purpose_field").hide();
      $(".select").show();

    } else if ( selected === "Equipment") {
      $("#purpose_field").show();
      $(".select").show();

    } else if ( selected === "Others") {
      $("#purpose_field").show();
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

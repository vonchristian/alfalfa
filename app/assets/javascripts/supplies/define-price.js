$(document).ready(function() {
	$('#define_price').change(function() {
    if ( $('#define_price:checked').length > 0) {
      $("#supplies_line_item_unit_cost").removeAttr('readonly');
    } else {
      $("#supplies_line_item_unit_cost").attr('readonly','readonly');
    }
  }); 
});
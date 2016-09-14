$(document).ready(function() {
  $('.datetimepicker').datetimepicker({
  	format: 'YYYY-MM-DD hh:mm:ss A',
  	showClose: true,
      widgetPositioning: {
            horizontal: 'auto',
            vertical: 'auto'
      }
  });
});

$(document).ready(function() {
  $('.date_picker').datetimepicker({
  	format: 'MMM DD, YYYY',
  	showClose: true,
      widgetPositioning: {
            horizontal: 'auto',
            vertical: 'auto'
      }
  });
});

// $(document).ready(function() {
//   $('.datepicker_report').datepicker({
//   format: "yyyy-mm-dd",
//   orientation: "bottom right",
//   autoclose: true
//   });
// });

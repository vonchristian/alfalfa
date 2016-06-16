// function calculate_labor_cost() {
//     var myBox1 = document.getElementById('number_of_personnel').value;
//     var myBox2 = document.getElementById('number_of_days').value;
//     var myBox3 = document.getElementById('daily_rate').value;
//     var result = document.getElementById('total_cost');
//     var myResult = myBox1 * myBox2 * myBox3;
//     result.value = myResult;
//   }

function calculateLaborCost() {
  var myBox1 = document.getElementById('number_of_days').value;
  var myBox2 = document.getElementById('unit_cost').value;
  var result = document.getElementById('total_cost');
  var myResult = myBox1 * myBox2;
  result.value = myResult;
}

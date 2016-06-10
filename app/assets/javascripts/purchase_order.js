function calculate_purchase_order() {
  var myBox1 = document.getElementById('quantity').value;
  var myBox2 = document.getElementById('unit_cost').value;
  var result = document.getElementById('total_amount').value;
  var myResult = myBox1 * myBox2;
  total_amount.value = myResult;
}

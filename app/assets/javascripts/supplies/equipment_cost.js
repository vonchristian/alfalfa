function calculateEquipmentCost() {
  var myBox1 = document.getElementById('quantity').value;
  var myBox2 = document.getElementById('unit_cost').value;
  var result = document.getElementById('total_cost');
  var myResult = myBox1 * myBox2;
  result.value = myResult;
}
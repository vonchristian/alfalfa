function calculate() {
    var myBox1 = document.getElementById('stock_quantity').value;
    var myBox2 = document.getElementById('stock_unit_cost').value;
    var result = document.getElementById('stock_total_cost');
    var myResult = myBox1 * myBox2;
    result.value = myResult;
  }

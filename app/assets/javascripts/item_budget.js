function calculate() {
    var myBox1 = document.getElementById('quantity').value;
    var myBox2 = document.getElementById('unit_price').value;
    var result = document.getElementById('amount');
    var myResult = myBox1 * myBox2;
    result.value = myResult;


  }

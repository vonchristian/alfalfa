function calculate_equipment_cost() {
    var myBox1 = document.getElementById('number_of_equipment').value;
    var myBox2 = document.getElementById('number_of_days').value;
    var myBox3 = document.getElementById('daily_rate').value;
    var result = document.getElementById('total_cost');
    var myResult = myBox1 * myBox2 * myBox3;
    result.value = myResult;


  }

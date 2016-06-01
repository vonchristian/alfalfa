function calculateWorkDetailCost() {
    var quantity = document.getElementById('work_detail_quantity').value;
    var unitCost = document.getElementById('work_detail_unit_cost').value;
    var totalCost = document.getElementById('work_detail_total_cost');
    var result = quantity * unitCost;
  totalCost.value = result;
  }

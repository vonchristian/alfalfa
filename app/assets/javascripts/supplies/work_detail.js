function calculateWorkDetailCost() {
    var quantity = document.getElementById('work_detail_quantity').value;
    var unitPrice = document.getElementById('work_detail_unit_price').value;
    var amount = document.getElementById('work_detail_amount');
    var result = quantity * unitPrice;
    amount.value = myResult;
  }

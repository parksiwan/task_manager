class LowStockItem {
  String productName;
  String productCode;
  String currentQty;
  String location;
  DateTime reportDate;
  String picker;
  bool reportAccepted = false;
  String checker;
  String memo;

  LowStockItem(this.productName, this.productCode, this.currentQty, this.location, this.reportDate, this.picker, this.reportAccepted, this.checker, this.memo);

  // Convert a low stock item item object into a map
  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'productCode': productCode,
      'currentQty': currentQty,
      'location': location,
      'reportDate': reportDate,
      'picker': picker,
      'reportAccepted': reportAccepted,
      'checker': checker,
      'memo': memo
    };
  }

  // update a missing item and into a map
  Map<String, dynamic> updateLowStockItemToMap(productName, productCode, currentQty, location, reportDate, picker, reportAccepted, checker, memo) {
    return {
      'productName': productName,
      'productCode': productCode,
      'currentQty': currentQty,
      'location': location,
      'reportDate': reportDate,
      'picker': picker,
      'reportAccepted': reportAccepted,
      'checker': checker,
      'memo': memo
    };
  }
}

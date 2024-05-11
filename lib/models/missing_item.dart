class MissingItem {
  String productName;
  String productCode;
  String qty;
  String location;
  String shopName;
  DateTime deliveryDate;
  String picker;
  bool pickupCompleted = false;

  MissingItem(this.productName, this.productCode, this.qty, this.location, this.shopName, this.deliveryDate, this.picker, this.pickupCompleted);

  // Convert a missing item object into a map
  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'productCode': productCode,
      'qty': qty,
      'location': location,
      'shopName': shopName,
      'deliveryDate': deliveryDate,
      'picker': picker,
      'pickupCompleted': pickupCompleted
    };
  }

  // update a missing item and into a map
  Map<String, dynamic> updateMissingItemToMap(productName, productCode, qty, location, shopName, deliveryDate, picker, pickupCompleted) {
    return {
      'productName': productName,
      'productCode': productCode,
      'qty': qty,
      'location': location,
      'shopName': shopName,
      'deliveryDate': deliveryDate,
      'picker': picker,
      'pickupCompleted': pickupCompleted
    };
  }
}

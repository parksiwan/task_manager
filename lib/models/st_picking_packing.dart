class StPickingPacking {
  String shopName;
  String picker;
  String missingItems;
  String checker;
  int numberOfBox;
  DateTime deliveryDate;
  String additionalItems;
  int numberOfBoxAdd;
  String officeItems;
  int numberOfBoxOffice;
  bool pickupCompleted = false;
  bool checkCompleted = false;
  bool additionalCompleted = false;
  bool officeCompleted = false;
  String checkerAdditional;
  String checkerOffice;

  StPickingPacking(
      this.shopName,
      this.picker,
      this.missingItems,
      this.checker,
      this.numberOfBox,
      this.deliveryDate,
      this.additionalItems,
      this.numberOfBoxAdd,
      this.officeItems,
      this.numberOfBoxOffice,
      this.pickupCompleted,
      this.checkCompleted,
      this.additionalCompleted,
      this.officeCompleted,
      this.checkerAdditional,
      this.checkerOffice);

  // Convert a note item object into a map
  Map<String, dynamic> toMap() {
    return {
      'shopName': shopName,
      'picker': picker,
      'missingItems': missingItems,
      'checker': checker,
      'numberOfBox': numberOfBox,
      'deliveryDate': deliveryDate,
      'additionalItems': additionalItems,
      'numberOfBoxAdd': numberOfBoxAdd,
      'officeItems': officeItems,
      'numberOfBoxOffice': numberOfBoxOffice,
      'pickupCompleted': pickupCompleted,
      'checkCompleted': checkCompleted,
      'additionalCompleted': additionalCompleted,
      'officeCompleted': officeCompleted,
      'checkerAdditional': checkerAdditional,
      'checkerOffice': checkerOffice
    };
  }

  // Convert a note item object into a map
  Map<String, dynamic> updateStPickingPackingToMap(shopName, picker, missingItems, checker, numberOfBox, deliveryDate, additionalItems, numberOfBoxAdd,
      officeItems, numberOfBoxOffice, pickupCompleted, checkCompleted, additionalCompleted, officeCompleted, checkerAdditional, checkerOffice) {
    return {
      'shopName': shopName,
      'picker': picker,
      'missingItems': missingItems,
      'checker': checker,
      'numberOfBox': numberOfBox,
      'deliveryDate': deliveryDate,
      'additionalItems': additionalItems,
      'numberOfBoxAdd': numberOfBoxAdd,
      'officeItems': officeItems,
      'numberOfBoxOffice': numberOfBoxOffice,
      'pickupCompleted': pickupCompleted,
      'checkCompleted': checkCompleted,
      'additionalCompleted': additionalCompleted,
      'officeCompleted': officeCompleted,
      'checkerAdditional': checkerAdditional,
      'checkerOffice': checkerOffice
    };
  }
}

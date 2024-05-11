import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_manager/models/missing_item.dart';

class FirestoreServiceMI {
  // get collection of missing items
  final CollectionReference missingItems = FirebaseFirestore.instance.collection('MISSING_ITEMS');

  // Create: add a new missing item
  Future<void> addMissingItem(MissingItem item) {
    return missingItems.add(item.toMap());
  }

  // Read: get missing items from database
  Stream<QuerySnapshot> getMissingItemsStream() {
    final missingItemsStream = missingItems.where('deliveryDate', isGreaterThan: DateTime.now()).orderBy('deliveryDate', descending: false).snapshots();

    return missingItemsStream;
  }

  // Update: update missing ites given a doc id
  Future<void> updateMissingItem(String docID, MissingItem item) {
    return missingItems.doc(docID).update(item.updateMissingItemToMap(
        item.productName, item.productCode, item.qty, item.location, item.shopName, item.deliveryDate, item.picker, item.pickupCompleted));
  }

  //Delete: delete missing item given a doc id
  Future<void> deleteMissingItem(String docID) {
    return missingItems.doc(docID).delete();
  }
}

class FirestoreServiceAuth {}

class FirestoreServiceLowStock {}

class FirestoreServiceSchedule {}

class FirestoreServiceNotes {}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/models/missing_item.dart';
import 'package:task_manager/models/low_stock_item.dart';
import 'package:task_manager/models/upcoming_schedule.dart';
import 'package:task_manager/models/notes.dart';

// -------------------------------------------------------------------------------------------------------------------
class FirestoreServiceMI {
  // get collection of missing items
  final CollectionReference missingItems = FirebaseFirestore.instance.collection('MISSING_ITEMS');

  // Create: add a new missing item
  Future<void> addMissingItem(MissingItem item) {
    return missingItems.add(item.toMap());
  }

  // Read: get missing items from database
  Stream<QuerySnapshot> getMissingItemsStream() {
    // Get today's date
    DateTime today = DateTime.now();
    // Strip time components
    DateTime todayWithoutTime = DateTime(today.year, today.month, today.day, 0, 0, 0);

    final missingItemsStream =
        missingItems.where('deliveryDate', isGreaterThanOrEqualTo: Timestamp.fromDate(todayWithoutTime)).orderBy('deliveryDate', descending: true).snapshots();

    return missingItemsStream;
  }

  // Update: update missing ites given a doc id
  Future<void> updateMissingItem(String docID, MissingItem item) {
    return missingItems.doc(docID).update(item.updateMissingItemToMap(item.productName, item.productCode, item.qty, item.location, item.shopName,
        item.deliveryDate, item.picker, item.pickupCompleted, item.checker, item.memo));
  }

  //Delete: delete missing item given a doc id
  Future<void> deleteMissingItem(String docID) {
    return missingItems.doc(docID).delete();
  }
}

// -----------------------------------------------------------------------------------------------------------------------
class FirestoreServiceLowStock {
  // get collection of low stock items
  final CollectionReference lowStockItems = FirebaseFirestore.instance.collection('LOW_STOCK_ITEMS');

  // Create: add a new low stock item
  Future<void> addLowStockItem(LowStockItem item) {
    return lowStockItems.add(item.toMap());
  }

  // Read: get low stock items from database
  Stream<QuerySnapshot> getLowStockItemsStream() {
    // Get today's date
    DateTime today = DateTime.now();
    // Strip time components
    DateTime threeDayAgo = today.subtract(const Duration(days: 3));
    //DateTime todayWithoutTime = DateTime(today.year, today.month, today.day - 3, 0, 0, 0);

    final lowStockItemsStream //= lowStockItems.where('reportAccepted', isEqualTo: false).snapshots();
        = lowStockItems.where('reportDate', isGreaterThanOrEqualTo: Timestamp.fromDate(threeDayAgo)).orderBy('reportDate', descending: true).snapshots();
    return lowStockItemsStream;
  }

  // Update: update missing ites given a doc id
  Future<void> updateLowStockItem(String docID, LowStockItem item) {
    return lowStockItems.doc(docID).update(item.updateLowStockItemToMap(
        item.productName, item.productCode, item.currentQty, item.location, item.reportDate, item.picker, item.reportAccepted, item.checker, item.memo));
  }

  //Delete: delete missing item given a doc id
  Future<void> deleteLowStockItem(String docID) {
    return lowStockItems.doc(docID).delete();
  }
}

class FirestoreServiceUpcomingSchedule {
  // get collection of upcoming schedules
  final CollectionReference upcomingSchedules = FirebaseFirestore.instance.collection('UPCOMING_SCHEDULES');

  // Create: add a new note
  Future<void> addUpcomingSchedule(UpcomingSchedule upcomingSchedule) {
    return upcomingSchedules.add(upcomingSchedule.toMap());
  }

  // Read: get missing items from database
  Stream<QuerySnapshot> getUpcomingScheduleStream() {
    // Get today's date
    DateTime today = DateTime.now();
    // Strip time components
    DateTime todayWithoutTime = DateTime(today.year, today.month, today.day, 0, 0, 0);

    final upcomingShcedulesStream =
        upcomingSchedules.where('etda', isGreaterThanOrEqualTo: Timestamp.fromDate(todayWithoutTime)).orderBy('etda', descending: true).snapshots();

    return upcomingShcedulesStream;
  }
}

// -------------------------------------------------------------------------------------------------------------
class FirestoreServiceNotes {
  // get collection of notes
  final CollectionReference notes = FirebaseFirestore.instance.collection('NOTES');

  // Create: add a new note
  Future<void> addNote(Note note) {
    return notes.add(note.toMap());
  }

  // Read: get notes from database
  Stream<QuerySnapshot> getNotesStream() {
    final notesStream = notes.orderBy('postDate', descending: true).snapshots();
    return notesStream;
  }

  // Update: update notes given a doc id
  Future<void> updateNote(String docID, Note note) {
    return notes.doc(docID).update(note.updateNoteToMap(note.title, note.category, note.contents, note.postDate, note.poster, note.priority));
  }

  //Delete: delete note given a doc id
  Future<void> deleteNote(String docID) {
    return notes.doc(docID).delete();
  }
}

// Provider ---------------------------------------------------------
class UserInfoProvider extends ChangeNotifier {
  String _userName = "";
  String _team = "";

  UserInfoProvider() {
    // Fetch user information when the provider is initialized
    fetchUserInfo();
  }

  Future<void> fetchUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Replace 'users' and 'username' with your actual collection and field names
      DocumentSnapshot userInfo = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      Map<String, dynamic> data = userInfo.data() as Map<String, dynamic>;
      _userName = data['username'];
      _team = data['team'];
      notifyListeners();
    }
  }

  String get userName => _userName;
  String get team => _team;
}
// Provider -----------------------------------------------------------
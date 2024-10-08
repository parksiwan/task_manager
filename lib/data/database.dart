import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/models/missing_item.dart';
import 'package:task_manager/models/low_stock_item.dart';
import 'package:task_manager/models/st_picking_packing.dart';
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

// ---------------------------------------------------------------------------------------------------------------------------------------------
class FirestoreServiceUpcomingSchedule {
  // get collection of upcoming schedules
  final CollectionReference upcomingSchedules = FirebaseFirestore.instance.collection('UPCOMING_SCHEDULES');

  // Create: add a new schedule
  Future<void> addUpcomingSchedule(UpcomingSchedule upcomingSchedule) {
    return upcomingSchedules.add(upcomingSchedule.toMap());
  }

  // Read: get upcoming schedules from database
  Stream<QuerySnapshot> getUpcomingScheduleStream(DateTime selectedDate) {
    // Get today's date
    //DateTime startingDate = selectedDate;
    // Strip time components
    DateTime startingDate = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 0, 0, 0);

    final upcomingShcedulesStream =
        upcomingSchedules.where('etda', isGreaterThanOrEqualTo: Timestamp.fromDate(startingDate)).orderBy('etda', descending: false).snapshots();

    return upcomingShcedulesStream;
  }

  // Update: update upcoming schedule given a doc id
  Future<void> updateUpcomingSchedule(String docID, UpcomingSchedule item) {
    return upcomingSchedules.doc(docID).update(
        item.updateUpcomingScheduleToMap(item.category, item.title, item.contents, item.etda, item.poster, item.taskCompleted, item.checker, item.memo));
  }

  //Delete: delete upcoming schedule given a doc id
  Future<void> deleteUpcomingSchedule(String docID) {
    return upcomingSchedules.doc(docID).delete();
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

// -------------------------------------------------------------------------------------------------------------------
class FirestoreServiceSTPP {
  // get collection of missing items
  final CollectionReference stPickingPacking = FirebaseFirestore.instance.collection('ST_PICKING_PACKING');

  // Create: add a new ST-picking-packing item
  Future<void> addStPickingPacking(StPickingPacking item) {
    return stPickingPacking.add(item.toMap());
  }

  // Read: get ST-picking-packing from database
  Stream<QuerySnapshot> getStPickingPackingStream(DateTime selectedDate) {
    // Get today's date
    //DateTime startingDate = selectedDate;
    // Strip time components
    DateTime startingDate = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 0, 0, 0);

    final stPickingPackingStream =
        stPickingPacking.where('deliveryDate', isGreaterThanOrEqualTo: Timestamp.fromDate(startingDate)).orderBy('deliveryDate', descending: false).snapshots();

    return stPickingPackingStream;
  }

  // Update: update st-picking-packing items given a doc id
  Future<void> updateStPickingPacking(String docID, StPickingPacking item) {
    return stPickingPacking.doc(docID).update(item.updateStPickingPackingToMap(
        item.shopName,
        item.picker,
        item.missingItems,
        item.checker,
        item.numberOfBox,
        item.deliveryDate,
        item.additionalItems,
        item.numberOfBoxAdd,
        item.officeItems,
        item.numberOfBoxOffice,
        item.pickupCompleted,
        item.checkCompleted,
        item.additionalCompleted,
        item.officeCompleted,
        item.checkerAdditional,
        item.checkerOffice));
  }

  //Delete: delete st-picking-packing given a doc id
  Future<void> deleteStPickingPacking(String docID) {
    return stPickingPacking.doc(docID).delete();
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
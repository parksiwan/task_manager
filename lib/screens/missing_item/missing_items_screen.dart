import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:task_manager/data/database.dart';
//import 'package:task_manager/models/missing_item.dart';
import 'package:task_manager/widgets/missing_items_tile.dart';
import 'package:task_manager/screens/missing_item/add_missing_item_screen.dart';
//import 'package:provider/provider.dart';

class MissingItems extends StatefulWidget {
  const MissingItems({super.key});

  @override
  State<MissingItems> createState() => _MissingItemsState();
}

class _MissingItemsState extends State<MissingItems> {
  final FirestoreServiceMI _fb = FirestoreServiceMI();

  void logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Log out successful
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 40,
        title: const Text(
          'Missing Items', // + Provider.of<SharedStats>(context).stats.toString(),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        //backgroundColor: Colors.transparent,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          Container(
            child: IconButton(
              onPressed: () {
                logout();
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.logout),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true, // to make bottom sheet be expanded
            builder: (BuildContext context) {
              return SingleChildScrollView(
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.9, // to make bottom sheet be expanded
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      //borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: AddMissingItem(
                      fb: _fb,
                    )),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Column(children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 100, left: 15, right: 15, bottom: 30),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))),
          child: const SizedBox(height: 1),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
              stream: _fb.getMissingItemsStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List missingItemsList = snapshot.data!.docs;
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemCount: missingItemsList.length,
                    itemBuilder: (context, index) {
                      //get each individual doc
                      DocumentSnapshot document = missingItemsList[index];
                      String docID = document.id;
                      // get missing item from each doc
                      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                      data['checker'] = data['checker'] ?? "";
                      data['memo'] = data['memo'] ?? "";
                      // Get today's date
                      //DateTime today = DateTime.now();
                      //DateTime todayWithoutTime = DateTime(today.year, today.month, today.day);
                      // Get delivery date's Datetime type
                      //DateTime temp = data['deliveryDate'].toDate();
                      //DateTime deliveryDateWithoutTime = DateTime(temp.year, temp.month, temp.day);
                      //print('------------------');
                      //print(todayWithoutTime);
                      //print(deliveryDateWithoutTime);
                      //if ((Timestamp.fromDate(todayWithoutTime).compareTo(data['deliveryDate']) < 0) || (!data['pickupCompleted'])) {
                      // Filter data that are only equal to today or after OR not pickup Completed
                      //if (todayWithoutTime.isBefore(deliveryDateWithoutTime) || (!data['pickupCompleted'])) {
                      return MissingItemsTile(
                        productName: data['productName'],
                        productCode: data['productCode'],
                        qty: data['qty'],
                        location: data['location'],
                        shopName: data['shopName'],
                        deliveryDate: data['deliveryDate'].toDate(),
                        picker: data['picker'],
                        pickupCompleted: data['pickupCompleted'],
                        checker: data['checker'],
                        memo: data['memo'],
                        fb: _fb,
                        docID: docID,
                      );
                      //}
                    },
                  );
                } else {
                  return const Text("no data");
                }
              }),
        ),
      ]),
    );
  }
}

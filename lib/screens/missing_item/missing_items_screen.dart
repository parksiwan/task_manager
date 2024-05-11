import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:task_manager/data/database.dart';
import 'package:task_manager/models/missing_item.dart';
import 'package:task_manager/widgets/missing_items_tile.dart';
import 'package:task_manager/screens/missing_item/add_missing_item_screen.dart';
import 'package:intl/intl.dart';

class MissingItems extends StatefulWidget {
  //final Function(int) passMissingItemsCount;
  const MissingItems({Key? key}) : super(key: key);
  //const MissingItems({
  //  Key? key,
  //  required this.passMissingItemsCount,
  //required this.loadNewMissingItem,
  //}) : super(key: key);

  @override
  State<MissingItems> createState() => _MissingItemsState();
}

class _MissingItemsState extends State<MissingItems> {
  final FirestoreServiceMI _fb = FirestoreServiceMI();
  //int count = 0;

  //@override
  //void initState() {
  //  super.initState();
  //  widget.passMissingItemsCount(count); // notifiy parent widget
  //}

  // check box was tapped
  void changeStatus(bool? value, String docID, Map<String, dynamic> data) {
    setState(() {
      data['pickupCompleted'] = !data['pickupCompleted'];
    });
    MissingItem item = MissingItem(data['productName'], data['productCode'], data['qty'], data['location'], data['shopName'], data['deliveryDate'].toDate(),
        data['picker'], data['pickupCompleted']);
    _fb.updateMissingItem(docID, item);
  }

  //delete missing item
  void deleteMissingItem(String docID) {
    _fb.deleteMissingItem(docID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 40,
        title: const Text(
          'Missing Items',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        //backgroundColor: Colors.transparent,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.white70, width: 2), shape: BoxShape.circle),
                child: const CircleAvatar(radius: 15, child: Text("SI"))),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.all(16),
                    child: AddMissingItem(
                      fb: _fb,
                      //loadNewMissingItem: loadNewMissingItem,
                    )),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      body: Column(children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 100, left: 15, right: 15, bottom: 30),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))),
          child: SizedBox(height: 1),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
              stream: _fb.getMissingItemsStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List missingItemsList = snapshot.data!.docs;
                  //count = missingItemsList.length;
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemCount: missingItemsList.length,
                    itemBuilder: (context, index) {
                      //get each individual doc
                      DocumentSnapshot document = missingItemsList[index];
                      String docID = document.id;
                      // get missing item from each doc
                      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                      return MissingItemsTile(
                        productName: data['productName'],
                        productCode: data['productCode'],
                        qty: data['qty'],
                        location: data['location'],
                        shopName: data['shopName'],
                        deliveryDate: data['deliveryDate'].toDate(),
                        picker: data['picker'],
                        pickupCompleted: data['pickupCompleted'],
                        changeStatusFunction: (value) => changeStatus(value, docID, data),
                        deleteFunction: (context) => deleteMissingItem(docID),
                        fb: _fb,
                        docID: docID,
                      );
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

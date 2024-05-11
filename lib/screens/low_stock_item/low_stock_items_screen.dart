import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:task_manager/data/database.dart';
import 'package:task_manager/widgets/low_stock_items_tile.dart';
import 'package:task_manager/screens/low_stock_item/add_low_stock_item_screen.dart';

class LowStockItems extends StatefulWidget {
  const LowStockItems({super.key});

  @override
  State<LowStockItems> createState() => _LowStockItemsState();
}

class _LowStockItemsState extends State<LowStockItems> {
  final FirestoreServiceLowStock _fb = FirestoreServiceLowStock();

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
          'Low Stock Items', // + Provider.of<SharedStats>(context).stats.toString(),
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
            builder: (BuildContext context) {
              return SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.all(16),
                    child: AddLowStockItem(
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
              stream: _fb.getLowStockItemsStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List lowStockItemsList = snapshot.data!.docs;
                  print('3333333');
                  print(lowStockItemsList.length);
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemCount: lowStockItemsList.length,
                    itemBuilder: (context, index) {
                      //get each individual doc
                      DocumentSnapshot document = lowStockItemsList[index];
                      String docID = document.id;
                      // get missing item from each doc
                      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                      data['checker'] = data['checker'] ?? "";
                      data['memo'] = data['memo'] ?? "";

                      return LowStockItemsTile(
                        productName: data['productName'],
                        productCode: data['productCode'],
                        currentQty: data['currentQty'],
                        location: data['location'],
                        reportDate: data['reportDate'].toDate(),
                        picker: data['picker'],
                        reportAccepted: data['reportAccepted'],
                        checker: data['checker'],
                        memo: data['memo'],
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

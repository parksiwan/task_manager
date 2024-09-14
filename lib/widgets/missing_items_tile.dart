import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/data/database.dart';
import 'package:task_manager/models/missing_item.dart';
import 'package:task_manager/screens/missing_item/edit_missing_item_screen.dart';
import 'package:task_manager/screens/missing_item/add_memo_missing_item_screen.dart';
import 'package:task_manager/screens/missing_item/show_memo_missing_item_screen.dart';
import 'package:provider/provider.dart';

class MissingItemsTile extends StatefulWidget {
  final String productName;
  final String productCode;
  final String qty;
  final String location;
  final String shopName;
  final DateTime deliveryDate;
  final String picker;
  final bool pickupCompleted;
  String checker;
  final String memo;
  final FirestoreServiceMI fb;
  final String docID;

  MissingItemsTile({
    super.key,
    required this.productName,
    required this.productCode,
    required this.qty,
    required this.location,
    required this.shopName,
    required this.deliveryDate,
    required this.picker,
    required this.pickupCompleted,
    required this.checker,
    required this.memo,
    required this.fb,
    required this.docID,
  });

  @override
  State<MissingItemsTile> createState() => _MissingItemsTileState();
}

class _MissingItemsTileState extends State<MissingItemsTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      // In order to give space between (Card + Slidable)
      padding: const EdgeInsets.only(bottom: 7.0),
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.70,
          motion: const ScrollMotion(), //StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                MissingItem item = MissingItem(widget.productName, widget.productCode, widget.qty, widget.location, widget.shopName, widget.deliveryDate,
                    widget.picker, widget.pickupCompleted, widget.checker, widget.memo);
                setState(() {
                  item.pickupCompleted = !item.pickupCompleted;
                  if (item.pickupCompleted) {
                    item.checker = Provider.of<UserInfoProvider>(context, listen: false).userName;
                    widget.checker = item.checker;
                  } else {
                    item.checker = "";
                  }
                  widget.fb.updateMissingItem(widget.docID, item);
                });
              },
              icon: Icons.check_outlined,
              backgroundColor: Colors.purple.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            SlidableAction(
              onPressed: (context) {
                MissingItem item = MissingItem(widget.productName, widget.productCode, widget.qty, widget.location, widget.shopName, widget.deliveryDate,
                    widget.picker, widget.pickupCompleted, widget.checker, widget.memo);
                //print("----");
                //print(widget.checker);
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            //borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: AddMemoMissingItem(fb: widget.fb, docID: widget.docID, item: item)),
                    );
                  },
                );
              },
              icon: Icons.comment,
              backgroundColor: Colors.purple.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            SlidableAction(
              onPressed: (context) {
                MissingItem item = MissingItem(widget.productName, widget.productCode, widget.qty, widget.location, widget.shopName, widget.deliveryDate,
                    widget.picker, widget.pickupCompleted, widget.checker, widget.memo);
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            //borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: EditMissingItem(fb: widget.fb, docID: widget.docID, item: item)),
                    );
                  },
                );
              },
              icon: Icons.edit,
              backgroundColor: Colors.purple.shade300,
              borderRadius: BorderRadius.circular(20),
            ),
            SlidableAction(
              onPressed: (context) {
                widget.fb.deleteMissingItem(widget.docID);
              }, // widget.deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.purple.shade400,
              borderRadius: BorderRadius.circular(20),
            ),
          ],
        ),
        child: Container(
          height: 140,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Theme.of(context).colorScheme.secondary),
          child: Container(
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 7.0),
                        child: Text(
                          widget.productName,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 130,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(topRight: Radius.circular(20)),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Delivery Date",
                              style: TextStyle(color: Colors.white, fontSize: 10),
                            ),
                            Text(
                              DateFormat('dd/MM/yyyy').format(widget.deliveryDate),
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 7.0, top: 7),
                      child: Row(
                        children: [
                          const Text(
                            "Code : ",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          Text(
                            widget.productCode,
                            style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 130,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 7.0),
                        child: Row(
                          children: [
                            const Text(
                              "Shop : ",
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            Expanded(
                              child: Text(
                                widget.shopName,
                                style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 7, top: 7.0),
                      child: Row(
                        children: [
                          const Text(
                            "QTY : ",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          Text(
                            widget.qty,
                            style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 130,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 7.0),
                        child: Row(
                          children: [
                            const Text(
                              "Picker : ",
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            Expanded(
                              child: Text(
                                widget.picker,
                                style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 7.0, top: 7.0),
                      child: Row(
                        children: [
                          const Text(
                            "Location : ",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          Text(
                            widget.location,
                            style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Row(
                        children: [
                          widget.pickupCompleted
                              ? const Icon(Icons.check_circle, color: Colors.greenAccent, size: 20)
                              : const Icon(Icons.error, color: Colors.orangeAccent, size: 20),
                          widget.pickupCompleted
                              ? Text(" by ${widget.checker}", style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 12))
                              : const Text(""),
                          const SizedBox(width: 10),
                          widget.memo == ""
                              ? const SizedBox(width: 0, height: 0)
                              : GestureDetector(
                                  onTap: () {
                                    //MissingItem item = MissingItem(widget.productName, widget.productCode, widget.qty, widget.location, widget.shopName,
                                    //    widget.deliveryDate, widget.picker, widget.pickupCompleted, widget.checker, widget.memo);
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SingleChildScrollView(
                                          child: Container(
                                              decoration: BoxDecoration(
                                                color: Theme.of(context).colorScheme.secondary,
                                              ),
                                              padding: const EdgeInsets.all(16),
                                              child: ShowMemoMissingItem(memo: widget.memo)),
                                        );
                                      },
                                    );
                                  },
                                  child: const Icon(
                                    Icons.comment,
                                    color: Colors.white60,
                                    size: 20,
                                  )),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

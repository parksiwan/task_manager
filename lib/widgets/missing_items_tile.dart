import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/data/database.dart';
import 'package:task_manager/models/missing_item.dart';
import 'package:task_manager/screens/missing_item/edit_missing_item_screen.dart';

class MissingItemsTile extends StatefulWidget {
  final String productName;
  final String productCode;
  final String qty;
  final String location;
  final String shopName;
  final DateTime deliveryDate;
  final String picker;
  final bool pickupCompleted;
  Function(bool?)? changeStatusFunction;
  Function(BuildContext)? deleteFunction;
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
    required this.changeStatusFunction,
    required this.deleteFunction,
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
          extentRatio: 0.50,
          motion: ScrollMotion(), //StretchMotion(),
          children: [
            SlidableAction(
              onPressed: widget.deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(20),
            ),
            SlidableAction(
              onPressed: (context) {
                MissingItem item = MissingItem(widget.productName, widget.productCode, widget.qty, widget.location, widget.shopName, widget.deliveryDate,
                    widget.picker, widget.pickupCompleted);
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      child: Container(padding: EdgeInsets.all(16), child: EditMissingItem(fb: widget.fb, docID: widget.docID, item: item)),
                    );
                  },
                );
              },
              icon: Icons.edit,
              backgroundColor: Colors.blue.shade300,
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
                        borderRadius: BorderRadius.only(topRight: Radius.circular(20)),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
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
                          Text(
                            "Code : ",
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                          Text(
                            widget.productCode,
                            style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 130,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 7.0),
                        child: Row(
                          children: [
                            Text(
                              "Shop : ",
                              style: TextStyle(color: Colors.white, fontSize: 10),
                            ),
                            Expanded(
                              child: Text(
                                widget.shopName,
                                style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 10),
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
                          Text(
                            "QTY : ",
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                          Text(
                            widget.qty,
                            style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 130,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 7.0),
                        child: Row(
                          children: [
                            Text(
                              "Picker : ",
                              style: TextStyle(color: Colors.white, fontSize: 10),
                            ),
                            Expanded(
                              child: Text(
                                widget.picker,
                                style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 10),
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
                      padding: const EdgeInsets.only(left: 7.0),
                      child: Row(
                        children: [
                          Text(
                            "Location : ",
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                          Text(
                            widget.location,
                            style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          //shape: BeveledRectangleBorder,
                          value: widget.pickupCompleted,
                          onChanged: widget.changeStatusFunction,
                          activeColor: Colors.black,
                        ),
                        widget.pickupCompleted
                            ? Text(
                                "Fixed",
                                style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 10),
                              )
                            : Icon(Icons.error, color: Colors.orangeAccent)
                      ],
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

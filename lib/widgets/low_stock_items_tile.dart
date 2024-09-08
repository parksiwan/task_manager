import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/data/database.dart';
import 'package:task_manager/models/low_stock_item.dart';

import 'package:task_manager/screens/low_stock_item/edit_low_stock_item_screen.dart';
import 'package:task_manager/screens/low_stock_item/add_memo_low_stock_item_screen.dart';
import 'package:task_manager/screens/low_stock_item/show_memo_low_stock_item_screen.dart';
import 'package:provider/provider.dart';

class LowStockItemsTile extends StatefulWidget {
  final String productName;
  final String productCode;
  final String currentQty;
  final String location;
  final DateTime reportDate;
  final String picker;
  final bool reportAccepted;
  String checker;
  final String memo;
  final FirestoreServiceLowStock fb;
  final String docID;

  LowStockItemsTile({
    super.key,
    required this.productName,
    required this.productCode,
    required this.currentQty,
    required this.location,
    required this.reportDate,
    required this.picker,
    required this.reportAccepted,
    required this.checker,
    required this.memo,
    required this.fb,
    required this.docID,
  });

  @override
  State<LowStockItemsTile> createState() => _LowStockItemsTileState();
}

class _LowStockItemsTileState extends State<LowStockItemsTile> {
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
                LowStockItem item = LowStockItem(widget.productName, widget.productCode, widget.currentQty, widget.location, widget.reportDate, widget.picker,
                    widget.reportAccepted, widget.checker, widget.memo);
                setState(() {
                  item.reportAccepted = !item.reportAccepted;
                  if (item.reportAccepted) {
                    item.checker = Provider.of<UserInfoProvider>(context, listen: false).userName;
                    widget.checker = item.checker;
                  } else {
                    item.checker = "";
                  }
                  widget.fb.updateLowStockItem(widget.docID, item);
                });
              },
              icon: Icons.check_outlined,
              backgroundColor: Colors.purple.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            SlidableAction(
              onPressed: (context) {
                LowStockItem item = LowStockItem(widget.productName, widget.productCode, widget.currentQty, widget.location, widget.reportDate, widget.picker,
                    widget.reportAccepted, widget.checker, widget.memo);
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          padding: const EdgeInsets.all(16),
                          child: AddMemoLowStockItem(fb: widget.fb, docID: widget.docID, item: item)),
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
                LowStockItem item = LowStockItem(widget.productName, widget.productCode, widget.currentQty, widget.location, widget.reportDate, widget.picker,
                    widget.reportAccepted, widget.checker, widget.memo);
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          padding: const EdgeInsets.all(16),
                          child: EditLowStockItem(fb: widget.fb, docID: widget.docID, item: item)),
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
                widget.fb.deleteLowStockItem(widget.docID);
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
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(20)),
                        //color: Theme.of(context).colorScheme.onBackground,
                        color: Color.fromRGBO(218, 156, 244, 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Report Date",
                              style: TextStyle(color: Colors.white, fontSize: 10),
                            ),
                            Text(
                              DateFormat('dd/MM/yyyy').format(widget.reportDate),
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
                            style: const TextStyle(color: Color.fromRGBO(218, 156, 244, 1), fontSize: 12),
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
                              "Location : ",
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            Expanded(
                              child: Text(
                                widget.location,
                                style: const TextStyle(color: Color.fromRGBO(218, 156, 244, 1), fontSize: 12),
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
                            "Current QTY : ",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          Text(
                            widget.currentQty,
                            style: const TextStyle(color: Color.fromRGBO(218, 156, 244, 1), fontSize: 12),
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
                                style: const TextStyle(color: Color.fromRGBO(218, 156, 244, 1), fontSize: 12),
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 7.0, right: 5.0),
                      child: Row(
                        children: [
                          widget.reportAccepted
                              ? const Icon(Icons.check_circle, color: Colors.greenAccent, size: 20)
                              : const Icon(Icons.error, color: Colors.orangeAccent, size: 20),
                          widget.reportAccepted
                              ? Text(" by ${widget.checker}", style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 12))
                              : const Text(""),
                          const SizedBox(width: 10),
                          widget.memo == ""
                              ? const SizedBox(width: 0, height: 0)
                              : GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SingleChildScrollView(
                                          child: Container(
                                              decoration: BoxDecoration(
                                                color: Theme.of(context).colorScheme.secondary,
                                              ),
                                              padding: const EdgeInsets.all(16),
                                              child: ShowMemoLowStockItem(memo: widget.memo)),
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

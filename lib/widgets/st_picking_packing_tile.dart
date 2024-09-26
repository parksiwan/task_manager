import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import 'package:task_manager/data/database.dart';
import 'package:task_manager/models/st_picking_packing.dart';

import 'package:task_manager/screens/st_picking_packing/edit_picking.dart';
//import 'package:task_manager/screens/upcoming_schedules/add_memo_upcoming_schedule_screen.dart';

import 'package:provider/provider.dart';
//import 'package:task_manager/screens/upcoming_schedules/show_memo_upcoming_schedule_screen.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class StPickingPackingTile extends StatefulWidget {
  final String shopName;
  String picker;
  final String missingItems;
  final String checker;
  final int numberOfBox;
  final DateTime deliveryDate;
  final String additionalItems;
  final int numberOfBoxAdd;
  final String officeItems;
  final int numberOfBoxOffice;
  final bool pickupCompleted;
  final bool checkCompleted;
  final bool additionalCompleted;
  final bool officeCompleted;
  final String checkerAdditional;
  final String checkerOffice;
  final FirestoreServiceSTPP fb;
  final String docID;

  StPickingPackingTile({
    super.key,
    required this.shopName,
    required this.picker,
    required this.missingItems,
    required this.checker,
    required this.numberOfBox,
    required this.deliveryDate,
    required this.additionalItems,
    required this.numberOfBoxAdd,
    required this.officeItems,
    required this.numberOfBoxOffice,
    required this.pickupCompleted,
    required this.checkCompleted,
    required this.additionalCompleted,
    required this.officeCompleted,
    required this.checkerAdditional,
    required this.checkerOffice,
    required this.fb,
    required this.docID,
  });

  @override
  State<StPickingPackingTile> createState() => _StPickingPackingTileState();
}

class _StPickingPackingTileState extends State<StPickingPackingTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      // In order to give space between (Card + Slidable)
      padding: const EdgeInsets.only(bottom: 7.0),
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.7,
          motion: const ScrollMotion(), //StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                StPickingPacking item = StPickingPacking(
                    widget.shopName,
                    widget.picker,
                    widget.missingItems,
                    widget.checker,
                    widget.numberOfBox,
                    widget.deliveryDate,
                    widget.additionalItems,
                    widget.numberOfBoxAdd,
                    widget.officeItems,
                    widget.numberOfBoxOffice,
                    widget.pickupCompleted,
                    widget.checkCompleted,
                    widget.additionalCompleted,
                    widget.officeCompleted,
                    widget.checkerAdditional,
                    widget.checkerOffice);
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.9, // to make bottom sheet be expanded
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            //borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: EditPicking(fb: widget.fb, docID: widget.docID, item: item)),
                    );
                  },
                );
              },
              icon: Icons.check_outlined,
              backgroundColor: Colors.purple.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            SlidableAction(
              onPressed: (context) {
                StPickingPacking item = StPickingPacking(
                    widget.shopName,
                    widget.picker,
                    widget.missingItems,
                    widget.checker,
                    widget.numberOfBox,
                    widget.deliveryDate,
                    widget.additionalItems,
                    widget.numberOfBoxAdd,
                    widget.officeItems,
                    widget.numberOfBoxOffice,
                    widget.pickupCompleted,
                    widget.checkCompleted,
                    widget.additionalCompleted,
                    widget.officeCompleted,
                    widget.checkerAdditional,
                    widget.checkerOffice);
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.9, // to make bottom sheet be expanded
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            //borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: EditPicking(fb: widget.fb, docID: widget.docID, item: item)),
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
                StPickingPacking item = StPickingPacking(
                    widget.shopName,
                    widget.picker,
                    widget.missingItems,
                    widget.checker,
                    widget.numberOfBox,
                    widget.deliveryDate,
                    widget.additionalItems,
                    widget.numberOfBoxAdd,
                    widget.officeItems,
                    widget.numberOfBoxOffice,
                    widget.pickupCompleted,
                    widget.checkCompleted,
                    widget.additionalCompleted,
                    widget.officeCompleted,
                    widget.checkerAdditional,
                    widget.checkerOffice);
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.9, // to make bottom sheet be expanded
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            //borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: EditPicking(fb: widget.fb, docID: widget.docID, item: item)),
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
                StPickingPacking item = StPickingPacking(
                    widget.shopName,
                    widget.picker,
                    widget.missingItems,
                    widget.checker,
                    widget.numberOfBox,
                    widget.deliveryDate,
                    widget.additionalItems,
                    widget.numberOfBoxAdd,
                    widget.officeItems,
                    widget.numberOfBoxOffice,
                    widget.pickupCompleted,
                    widget.checkCompleted,
                    widget.additionalCompleted,
                    widget.officeCompleted,
                    widget.checkerAdditional,
                    widget.checkerOffice);
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.9, // to make bottom sheet be expanded
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            //borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: EditPicking(fb: widget.fb, docID: widget.docID, item: item)), // edit office
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
                widget.fb.deleteStPickingPacking(widget.docID);
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
                      //flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 7.0),
                        child: Text(
                          widget.shopName,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 130,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(topRight: Radius.circular(20)),
                        color: Theme.of(context).colorScheme.onSurface,
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
                            const SizedBox(height: 2),
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

                StepProgressIndicator(
                  totalSteps: 4,
                  currentStep: 4,
                  size: 20,
                  selectedColor: Colors.purple,
                  unselectedColor: Colors.transparent,
                  customStep: (index, color, _) => Container(
                    height: 40,
                    color: color,
                    alignment: Alignment.center,
                    child: Text('pickup by siwan'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 7.0, top: 7),
                      child: Row(
                        children: [
                          const Text(
                            "PickUp : ",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          Text(
                            widget.picker,
                            style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 7.0, top: 7),
                      child: Row(
                        children: [
                          const Text(
                            "PO Check : ",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          Text(
                            widget.checker,
                            style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 7.0, top: 7),
                      child: Row(
                        children: [
                          const Text(
                            "Additional Order : ",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          Text(
                            widget.checkerAdditional,
                            style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 12),
                          ),
                        ],
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
                            "Missing : ",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          Text(
                            widget.missingItems,
                            style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 7.0, top: 7),
                      child: Row(
                        children: [
                          const Text(
                            "BOX : ",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          Text(
                            widget.numberOfBox.toString(),
                            style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 7.0, top: 7),
                      child: Row(
                        children: [
                          const Text(
                            "ST Office : ",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          Text(
                            widget.checkerOffice,
                            style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                //Row(
                //  mainAxisAlignment: MainAxisAlignment.end,
                //  children: [
                //    Padding(
                //      padding: const EdgeInsets.only(top: 7.0, right: 5.0),
                //      child: Row(
                //        children: [
                //          widget.taskCompleted
                //              ? const Icon(Icons.check_circle, color: Colors.greenAccent, size: 20)
                //              : const Icon(Icons.error, color: Colors.orangeAccent, size: 20),
                //          widget.taskCompleted
                //              ? Text(" by ${widget.checker}", style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 12))
                //              : const Text(""),
                //          const SizedBox(width: 10),
                //          widget.memo == ""
                //              ? const SizedBox(width: 0, height: 0)
                //              : GestureDetector(
                //                  onTap: () {
                //                    showModalBottomSheet(
                //                      context: context,
                //                      builder: (BuildContext context) {
                //                        return SingleChildScrollView(
                //                          child: Container(
                //                              decoration: BoxDecoration(
                //                                color: Theme.of(context).colorScheme.secondary,
                //                              ),
                //                              padding: const EdgeInsets.all(16),
                //                              child: ShowMemoUpcomingSchedule(memo: widget.memo)),
                //                        );
                //                      },
                //                    );
                //                  },
                //                  child: const Icon(
                //                    Icons.comment,
                //                    color: Colors.white60,
                //                    size: 20,
                //                  )),
                //        ],
                //      ),
                //    )
                //  ],
                //),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

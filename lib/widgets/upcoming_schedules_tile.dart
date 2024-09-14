import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/data/database.dart';
import 'package:task_manager/models/upcoming_schedule.dart';

import 'package:task_manager/screens/upcoming_schedules/edit_upcoming_schedule_screen.dart';
import 'package:task_manager/screens/upcoming_schedules/add_memo_upcoming_schedule_screen.dart';
//import 'package:task_manager/screens/low_stock_item/show_memo_low_stock_item_screen.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/screens/upcoming_schedules/show_memo_upcoming_schedule_screen.dart';

class UpcomingSchedulesTile extends StatefulWidget {
  final String category;
  final String title;
  final String contents;
  final DateTime etda;
  final String poster;
  final bool taskCompleted;
  String checker;
  final String memo;
  final FirestoreServiceUpcomingSchedule fb;
  final String docID;

  UpcomingSchedulesTile({
    super.key,
    required this.category,
    required this.title,
    required this.contents,
    required this.etda,
    required this.poster,
    required this.taskCompleted,
    required this.checker,
    required this.memo,
    required this.fb,
    required this.docID,
  });

  @override
  State<UpcomingSchedulesTile> createState() => _UpcomingSchedulesTileState();
}

class _UpcomingSchedulesTileState extends State<UpcomingSchedulesTile> {
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
                UpcomingSchedule item = UpcomingSchedule(
                    widget.category, widget.title, widget.contents, widget.etda, widget.poster, widget.taskCompleted, widget.checker, widget.memo);
                setState(() {
                  item.taskCompleted = !item.taskCompleted;
                  if (item.taskCompleted) {
                    item.checker = Provider.of<UserInfoProvider>(context, listen: false).userName;
                    widget.checker = item.checker;
                  } else {
                    item.checker = "";
                  }
                  widget.fb.updateUpcomingSchedule(widget.docID, item);
                });
              },
              icon: Icons.check_outlined,
              backgroundColor: Colors.purple.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            SlidableAction(
              onPressed: (context) {
                UpcomingSchedule item = UpcomingSchedule(
                    widget.category, widget.title, widget.contents, widget.etda, widget.poster, widget.taskCompleted, widget.checker, widget.memo);
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
                          child: AddMemoUpcomingSchedule(fb: widget.fb, docID: widget.docID, item: item)),
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
                UpcomingSchedule item = UpcomingSchedule(
                    widget.category, widget.title, widget.contents, widget.etda, widget.poster, widget.taskCompleted, widget.checker, widget.memo);
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
                          child: EditUpcomingSchedule(fb: widget.fb, docID: widget.docID, item: item)),
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
                widget.fb.deleteUpcomingSchedule(widget.docID);
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
                        child: Row(
                          children: [
                            Text(
                              widget.category,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(width: 7),
                            const Icon(Icons.person, color: Colors.greenAccent, size: 14),
                            const SizedBox(width: 2),
                            Text(
                              widget.poster,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface, fontSize: 12),
                            ),
                          ],
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
                              "Scheduled Date",
                              style: TextStyle(color: Colors.white, fontSize: 10),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              DateFormat('dd/MM/yyyy').format(widget.etda),
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 7.0, top: 7),
                    child: Text(
                      widget.title,
                      style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 17, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 7, top: 7.0),
                    child: Text(
                      widget.contents,
                      style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 7.0, right: 5.0),
                      child: Row(
                        children: [
                          widget.taskCompleted
                              ? const Icon(Icons.check_circle, color: Colors.greenAccent, size: 20)
                              : const Icon(Icons.error, color: Colors.orangeAccent, size: 20),
                          widget.taskCompleted
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
                                              child: ShowMemoUpcomingSchedule(memo: widget.memo)),
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

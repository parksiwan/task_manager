import 'package:flutter/material.dart';
import 'package:task_manager/data/database.dart';
import 'package:task_manager/models/upcoming_schedule.dart';

class AddMemoUpcomingSchedule extends StatefulWidget {
  final FirestoreServiceUpcomingSchedule fb;
  final String docID;
  final UpcomingSchedule item;
  const AddMemoUpcomingSchedule({
    super.key,
    required this.fb,
    required this.docID,
    required this.item,
  });

  @override
  State<AddMemoUpcomingSchedule> createState() => _AddMemoUpcomingScheduleState();
}

class _AddMemoUpcomingScheduleState extends State<AddMemoUpcomingSchedule> {
  final TextEditingController _memoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // edit comment
    if (widget.item.memo != "") {
      _memoController.text = widget.item.memo;
    }
  }

  void addMemoUpcomingSchedule(String docID, UpcomingSchedule data) {
    setState(() {
      data.memo = _memoController.text;
    });
    widget.fb.updateUpcomingSchedule(docID, data);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.item.memo == "") {
      // add memo
      return Container(
        child: Column(
          children: [
            const Text(
              "Post memo, if any.",
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _memoController,
              maxLines: 2,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(labelText: 'Memo', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.onSurface)),
              onPressed: () {
                addMemoUpcomingSchedule(widget.docID, widget.item);
              },
              child: const Text('Add', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      );
    } else {
      return SizedBox(
        width: 700,
        child: Column(
          children: [
            const Text(
              "Edit memo, if any",
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _memoController,
              maxLines: 2,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(labelText: 'Memo', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.onSurface)),
              onPressed: () {
                addMemoUpcomingSchedule(widget.docID, widget.item);
              },
              child: const Text('Edit', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      );
    }
  }
}

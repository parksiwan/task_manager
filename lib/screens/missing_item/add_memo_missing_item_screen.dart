import 'package:flutter/material.dart';
import 'package:task_manager/data/database.dart';
import 'package:task_manager/models/missing_item.dart';

class AddMemoMissingItem extends StatefulWidget {
  final FirestoreServiceMI fb;
  final String docID;
  final MissingItem item;
  const AddMemoMissingItem({
    Key? key,
    required this.fb,
    required this.docID,
    required this.item,
  }) : super(key: key);

  @override
  State<AddMemoMissingItem> createState() => _AddMemoMissingItemState();
}

class _AddMemoMissingItemState extends State<AddMemoMissingItem> {
  final TextEditingController _memoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // edit comment
    if (widget.item.memo != "") {
      _memoController.text = widget.item.memo;
    }
  }

  void addMemoMissingItem(String docID, MissingItem data) {
    setState(() {
      data.memo = _memoController.text;
    });
    widget.fb.updateMissingItem(docID, data);
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
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.onBackground)),
              onPressed: () {
                addMemoMissingItem(widget.docID, widget.item);
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
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.onBackground)),
              onPressed: () {
                addMemoMissingItem(widget.docID, widget.item);
              },
              child: const Text('Edit', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      );
    }
  }
}

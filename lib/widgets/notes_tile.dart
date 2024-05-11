import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/data/database.dart';
import 'package:task_manager/models/notes.dart';

import 'package:task_manager/screens/notes/edit_note_screen.dart';

class NotesTile extends StatefulWidget {
  final String title;
  final String category;
  final String contents;
  final DateTime postDate;
  final String poster;
  final String priority;
  final FirestoreServiceNotes fb;
  final String docID;

  const NotesTile({
    super.key,
    required this.title,
    required this.category,
    required this.contents,
    required this.postDate,
    required this.poster,
    required this.priority,
    required this.fb,
    required this.docID,
  });

  @override
  State<NotesTile> createState() => _NotesTileState();
}

class _NotesTileState extends State<NotesTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      // In order to give space between (Card + Slidable)
      padding: const EdgeInsets.only(bottom: 7.0),
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.35,
          motion: const ScrollMotion(), //StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                Note note = Note(widget.title, widget.category, widget.contents, widget.postDate, widget.poster, widget.priority);
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      child: Container(padding: const EdgeInsets.all(16), child: EditNote(fb: widget.fb, docID: widget.docID, note: note)),
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
                widget.fb.deleteNote(widget.docID);
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
                        child: Row(
                          children: [
                            Text(
                              widget.category,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.onBackground, fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(width: 3),
                            widget.priority == 'Normal' ? const Text("") : const SizedBox(width: 0, height: 0),
                            widget.priority == "High" ? const Icon(Icons.star, color: Colors.amberAccent, size: 14) : const SizedBox(width: 0, height: 0),
                            widget.priority == "Very High" ? const Icon(Icons.star, color: Colors.amberAccent, size: 14) : const SizedBox(width: 0, height: 0),
                            widget.priority == "Very High" ? const Icon(Icons.star, color: Colors.amberAccent, size: 14) : const SizedBox(width: 0, height: 0),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 130,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(20)),
                          color: Color.fromRGBO(136, 189, 241, 1) //Theme.of(context).colorScheme.onBackground,
                          ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Post Date",
                              style: TextStyle(color: Colors.white, fontSize: 10),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              DateFormat('dd/MM/yyyy').format(widget.postDate),
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
                      style: const TextStyle(color: Color.fromRGBO(136, 189, 241, 1), fontSize: 17, fontWeight: FontWeight.bold),
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
                      style: const TextStyle(color: Color.fromRGBO(136, 189, 241, 1), fontSize: 12),
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
                          const Icon(Icons.person, color: Colors.greenAccent, size: 20),
                          Text(" by ${widget.poster}", style: const TextStyle(color: Color.fromRGBO(136, 189, 241, 1), fontSize: 12)),
                          const SizedBox(width: 10),
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

import 'package:flutter/material.dart';
import 'package:task_manager/models/notes.dart';
import 'package:intl/intl.dart';

class ShowNote extends StatelessWidget {
  final Note note;

  const ShowNote({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 700,
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      //decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Theme.of(context).colorScheme.secondary),
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
                          note.category,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.onBackground, fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(width: 3),
                        note.priority == 'Normal' ? const Text("") : const SizedBox(width: 0, height: 0),
                        note.priority == "High" ? const Icon(Icons.star, color: Colors.amberAccent, size: 14) : const SizedBox(width: 0, height: 0),
                        note.priority == "Very High" ? const Icon(Icons.star, color: Colors.amberAccent, size: 14) : const SizedBox(width: 0, height: 0),
                        note.priority == "Very High" ? const Icon(Icons.star, color: Colors.amberAccent, size: 14) : const SizedBox(width: 0, height: 0),
                      ],
                    ),
                  ),
                ),
                Container(
                  //height: 50,
                  //width: 130,
                  //decoration: BoxDecoration(
                  //    borderRadius: BorderRadius.only(topRight: Radius.circular(20)),
                  //    color: Color.fromRGBO(136, 189, 241, 1) //Theme.of(context).colorScheme.onBackground,
                  //    ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      DateFormat('dd/MM/yyyy').format(note.postDate),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 7.0, top: 7),
                child: Text(
                  note.title,
                  style: const TextStyle(color: Color.fromRGBO(136, 189, 241, 1), fontSize: 17, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 7, top: 7.0),
                child: Text(
                  note.contents,
                  style: const TextStyle(color: Color.fromRGBO(136, 189, 241, 1), fontSize: 12),
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 7.0, right: 5.0),
                  child: Row(
                    children: [
                      const Icon(Icons.person, color: Colors.greenAccent, size: 20),
                      Text(" by ${note.poster}", style: const TextStyle(color: Color.fromRGBO(136, 189, 241, 1), fontSize: 12)),
                      const SizedBox(width: 10),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

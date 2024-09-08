import 'package:flutter/material.dart';

class NotesDisplay extends StatelessWidget {
  final String title, contents;
  const NotesDisplay({super.key, required this.title, required this.contents});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        alignment: Alignment.bottomLeft,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
                colors: [Colors.black.withOpacity(.8), Colors.black.withOpacity(.1)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: const [.2, .8])),
        child: Column(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
            ),
            Text(
              contents,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

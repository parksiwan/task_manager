import 'package:flutter/material.dart';
import 'package:task_manager/screens/missing_item/missing_items_screen.dart';
import 'package:task_manager/screens/low_stock_item/low_stock_items_screen.dart';
import 'package:task_manager/screens/upcoming_schedules/upcoming_schedules_screen.dart';
import 'package:task_manager/screens/notes/notes_screen.dart';

class TaskServiceTile extends StatefulWidget {
  final String iconName;
  final String title;
  String stats;
  final int taskMenu;

  TaskServiceTile({
    super.key,
    required this.iconName,
    required this.title,
    required this.stats,
    required this.taskMenu,
    //required this.deleteFunction,
  });

  @override
  State<TaskServiceTile> createState() => _TaskServiceTileState();
}

class _TaskServiceTileState extends State<TaskServiceTile> {
  final string2IconData = <String, IconData>{
    "priority_high": Icons.priority_high,
    "gpp maybe": Icons.gpp_maybe_outlined,
    "event_available": Icons.event_available,
    "speaker_notes": Icons.speaker_notes,
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        switch (widget.taskMenu) {
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MissingItems()),
            );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LowStockItems()),
            );
            break;
          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UpcomingSchedules()),
            );
            break;
          case 4:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Notes()),
            );
        }
      },
      child: Card(
        color: Theme.of(context).colorScheme.secondary, // Card background color
        elevation: 5, // Elevation (shadow) of the card
        shadowColor: Colors.black, // Shadow color
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.onSurface, // Circle background color
            radius: 17, // Circle radius
            child: Icon(
              string2IconData[widget.iconName], // Icon to display inside the circle
              color: Colors.black, // Icon color
              size: 20, // Icon size
            ),
          ),
          title: Text(widget.title, style: const TextStyle(color: Colors.white), textAlign: TextAlign.left),
          subtitle: Text(widget.stats,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.primary), textAlign: TextAlign.left),
          //contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          trailing: Icon(
            Icons.navigate_next,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}

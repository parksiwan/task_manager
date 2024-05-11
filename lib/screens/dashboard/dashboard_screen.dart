import 'package:flutter/material.dart';
import 'package:task_manager/widgets/task_service_tile.dart';
import 'package:task_manager/widgets/notes_display.dart';
import 'package:task_manager/screens/missing_item/missing_items_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 40,
        leading: Container(
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
        ),
        title: const Text(
          'Task Manager',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        //backgroundColor: Theme.of(context).primaryColorDark,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.white70, width: 2), shape: BoxShape.circle),
                child: const CircleAvatar(radius: 15, child: Text("SI"))),
          ),
        ],
      ),
      body: Column(children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 100, left: 15, right: 15, bottom: 30),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Please post & share every information and make them valuable for our jobs.',
                style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w300, height: 1.5),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 10),
            children: [
              ListTile(
                title: Text(
                  'Tasks',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10, left: 5, right: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  //padding: const EdgeInsets.only(top: 5, bottom: 10, left: 5, right: 5),
                  //scrollDirection: Axis.vertical,
                  children: [
                    TaskServiceTile(
                      iconName: "priority_high",
                      title: 'Missing Items',
                      stats: '5 items',
                      taskMenu: 1,
                    ),
                    SizedBox(height: 7),
                    TaskServiceTile(
                      iconName: "gpp maybe",
                      title: 'Low Stock Alarm',
                      stats: '5 items',
                      taskMenu: 1,
                    ), // week view calaendar
                    SizedBox(height: 7),
                    TaskServiceTile(
                      iconName: "event_available",
                      title: 'Upcoming Schedules',
                      stats: '5 items',
                      taskMenu: 1,
                    ),
                    SizedBox(height: 7),
                    TaskServiceTile(
                      iconName: "speaker_notes",
                      title: 'Notes',
                      stats: '5 items',
                      taskMenu: 1,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              ListTile(
                title: Text("Today's Notes", style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.grey, fontWeight: FontWeight.bold)),
              ),
              const Column(
                children: [
                  NotesDisplay(title: 'test1', contents: 'test1 display'),
                  NotesDisplay(title: 'test2', contents: 'test2 display'),
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}

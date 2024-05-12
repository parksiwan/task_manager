import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:task_manager/data/database.dart';
import 'package:task_manager/widgets/upcoming_schedules_tile.dart';
import 'package:task_manager/screens/upcoming_schedules/add_upcoming_schedule_screen.dart';
import 'package:table_calendar/table_calendar.dart';

class UpcomingSchedules extends StatefulWidget {
  const UpcomingSchedules({super.key});

  @override
  State<UpcomingSchedules> createState() => _UpcomingSchedulesState();
}

class _UpcomingSchedulesState extends State<UpcomingSchedules> {
  final FirestoreServiceUpcomingSchedule _fb = FirestoreServiceUpcomingSchedule();
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();

  void logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Log out successful
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 40,
        title: const Text(
          'Upcoming Schedules', // + Provider.of<SharedStats>(context).stats.toString(),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        //backgroundColor: Colors.transparent,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          Container(
            child: IconButton(
              onPressed: () {
                logout();
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.logout),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.all(16),
                    child: AddUpcomingSchedule(
                      fb: _fb,
                    )),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 100, left: 15, right: 15, bottom: 30),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))),
            child: const SizedBox(height: 1),
          ),
          Expanded(
            child: Column(
              children: [
                TableCalendar(
                  firstDay: DateTime.utc(2024, 1, 1),
                  lastDay: DateTime.utc(2028, 12, 31),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay; // update `_focusedDay` here as well
                    });
                  },
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                  calendarStyle: CalendarStyle(
                    selectedDecoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    selectedTextStyle: TextStyle(color: Colors.white),
                  ),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: _fb.getUpcomingScheduleStream(_selectedDay!),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List lowStockItemsList = snapshot.data!.docs;
                          //print('3333333');
                          //print(lowStockItemsList.length);
                          return ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            itemCount: lowStockItemsList.length,
                            itemBuilder: (context, index) {
                              //get each individual doc
                              DocumentSnapshot document = lowStockItemsList[index];
                              String docID = document.id;
                              // get missing item from each doc
                              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                              data['checker'] = data['checker'] ?? "";
                              data['memo'] = data['memo'] ?? "";
                              print('==============');
                              print(_selectedDay);
                              print(Timestamp.fromDate(data['etda'].toDate()));
                              return UpcomingSchedulesTile(
                                category: data['category'],
                                title: data['title'],
                                contents: data['contents'],
                                etda: data['etda'].toDate(),
                                poster: data['poster'],
                                taskCompleted: data['taskCompleted'],
                                checker: data['checker'],
                                memo: data['memo'],
                                fb: _fb,
                                docID: docID,
                              );
                            },
                          );
                        } else {
                          return const Text("no data");
                        }
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

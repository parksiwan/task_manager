import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:task_manager/data/database.dart';
import 'package:task_manager/models/st_picking_packing.dart';

import 'package:task_manager/widgets/st_picking_packing_tile.dart';
import 'package:task_manager/screens/st_picking_packing/add_st_picking_packing_screen.dart';

import 'package:table_calendar/table_calendar.dart';

class StPickingPacking extends StatefulWidget {
  const StPickingPacking({super.key});

  @override
  State<StPickingPacking> createState() => _StPickingPackingState();
}

class _StPickingPackingState extends State<StPickingPacking> {
  final FirestoreServiceSTPP _fb = FirestoreServiceSTPP();
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
          'ST Picking & Packing', // + Provider.of<SharedStats>(context).stats.toString(),
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
                    child: AddStPickingPacking(
                      fb: _fb,
                    )),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      // ---------------------------------------
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 100, left: 15, right: 15, bottom: 0),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))),
            child: const SizedBox(height: 1),
          ),
          Expanded(
            child: Column(
              children: [
                TableCalendar(
                  firstDay: DateTime.now().subtract(const Duration(days: 360)),
                  lastDay: DateTime.now().add(const Duration(days: 360)),
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
                    weekendTextStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                    selectedDecoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    selectedTextStyle: const TextStyle(color: Colors.white),
                  ),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: _fb.getStPickingPackingStream(_selectedDay!),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List stPickingPackingList = snapshot.data!.docs;
                          //print('3333333');
                          //print(lowStockItemsList.length);
                          return ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            itemCount: stPickingPackingList.length,
                            itemBuilder: (context, index) {
                              //get each individual doc
                              DocumentSnapshot document = stPickingPackingList[index];
                              String docID = document.id;
                              // get missing item from each doc
                              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                              //data['checker'] = data['checker'] ?? "";
                              //data['memo'] = data['memo'] ?? "";
                              return GestureDetector(
                                //onTap: () {
                                //  StPickingPacking stPickingPacking = StPickingPacking(data['category'], data['title'], data['contents'], data['etda'].toDate(),
                                //      data['poster'], data['taskCompleted'], data['checker'], data['memo']);
                                //  showModalBottomSheet(
                                //    context: context,
                                //    builder: (BuildContext context) {
                                //      return SingleChildScrollView(
                                //        child: Container(
                                //            padding: const EdgeInsets.all(16),
                                //            child: ShowUpcomingSchedule(
                                //              upcomingSchedule: upcomingSchedule,
                                //            )),
                                //      );
                                //    },
                                //  );
                                //},
                                child: StPickingPackingTile(
                                  shopName: data['shopName'],
                                  picker: data['picker'],
                                  missingItems: data['missingItems'],
                                  checker: data['checker'],
                                  numberOfBox: data['numberOfBox'],
                                  deliveryDate: data['deliveryDate'].toDate(),
                                  additionalItems: data['additionalItems'],
                                  numberOfBoxAdd: data['numberOfBoxAdd'],
                                  officeItems: data['officeItems'],
                                  numberOfBoxOffice: data['numberOfBoxOffice'],
                                  pickupCompleted: data['pickupCompleted'],
                                  checkCompleted: data['checkCompleted'],
                                  additionalCompleted: data['additionalCompleted'],
                                  officeCompleted: data['officeCompleted'],
                                  checkerAdditional: data['checkerAdditional'],
                                  checkerOffice: data['checkerOffice'],
                                  fb: _fb,
                                  docID: docID,
                                ),
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

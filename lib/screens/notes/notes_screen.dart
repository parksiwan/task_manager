import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:task_manager/data/database.dart';
import 'package:task_manager/screens/notes/add_note_screen.dart';
import 'package:task_manager/models/notes.dart';
import 'package:task_manager/widgets/notes_tile.dart';
import 'package:task_manager/screens/notes/show_note_screen.dart';
//import 'package:provider/provider.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final FirestoreServiceNotes _fb = FirestoreServiceNotes();

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
          'Notes',
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
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    padding: const EdgeInsets.all(16),
                    child: AddNote(
                      fb: _fb,
                    )),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Column(children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 100, left: 15, right: 15, bottom: 30),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))),
          child: const SizedBox(height: 1),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
              stream: _fb.getNotesStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List missingItemsList = snapshot.data!.docs;
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemCount: missingItemsList.length,
                    itemBuilder: (context, index) {
                      //get each individual doc
                      DocumentSnapshot document = missingItemsList[index];
                      String docID = document.id;
                      // get missing item from each doc
                      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

                      return GestureDetector(
                        onTap: () {
                          Note note = Note(data['title'], data['category'], data['contents'], data['postDate'].toDate(), data['poster'], data['priority']);
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return SingleChildScrollView(
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.secondary,
                                    ),
                                    padding: const EdgeInsets.all(16),
                                    child: ShowNote(
                                      note: note,
                                    )),
                              );
                            },
                          );
                        },
                        child: NotesTile(
                          title: data['title'],
                          contents: data['contents'],
                          category: data['category'],
                          postDate: data['postDate'].toDate(),
                          poster: data['poster'],
                          priority: data['priority'],
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
      ]),
    );
  }
}

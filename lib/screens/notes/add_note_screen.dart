import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/data/database.dart';
import 'package:task_manager/models/notes.dart';
import 'package:task_manager/screens/helper/constants.dart';
import 'package:provider/provider.dart';

class AddNote extends StatefulWidget {
  final FirestoreServiceNotes fb;
  const AddNote({
    super.key,
    required this.fb,
  });

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  //final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _contentsController = TextEditingController();
  final TextEditingController _postDateController = TextEditingController();
  final TextEditingController _posterController = TextEditingController();
  //final TextEditingController _priorityController = TextEditingController();
  String dropdownPriorityValue = "Normal";
  String dropdownTeamValue = "WH-General";

  @override
  void initState() {
    super.initState();
    String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    _postDateController.text = formattedDate;
  }

  // save new task
  void addNote() {
    setState(() {
      Note note = Note(_titleController.text, dropdownTeamValue, _contentsController.text, DateFormat('dd/MM/yyyy').parse(_postDateController.text),
          _posterController.text, dropdownPriorityValue);
      widget.fb.addNote(note);

      _titleController.clear();
      _contentsController.clear();
      _posterController.clear();
    });
    Navigator.of(context).pop();
    //widget.loadNewMissingItem();
  }

  void dropdownPriorityCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        dropdownPriorityValue = selectedValue;
      });
    }
  }

  void dropdownTeamCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        dropdownTeamValue = selectedValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _posterController.text = Provider.of<UserInfoProvider>(context).userName;
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Post note:',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField(
                    items: teamNames.map((map) {
                      return DropdownMenuItem<String>(
                        value: map['value'],
                        child: Text(map['name']),
                      );
                    }).toList(),
                    value: dropdownTeamValue,
                    onChanged: dropdownTeamCallback,
                    decoration: InputDecoration(
                      labelText: "Category",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    controller: _postDateController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(labelText: 'Post Date', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter Post date";
                      }
                      return null;
                    },
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2050),
                      );
                      if (pickedDate != null) {
                        String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
                        _postDateController.text = formattedDate.toString();
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: _titleController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(labelText: 'Title', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter title";
                }
                return null;
              },
            ),
            const SizedBox(height: 5),
            TextFormField(
              maxLines: 3,
              controller: _contentsController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(labelText: 'Contents', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter contents";
                }
                return null;
              },
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField(
                    items: priority.map((map) {
                      return DropdownMenuItem<String>(
                        value: map['value'],
                        child: Text(map['name']),
                      );
                    }).toList(),
                    value: dropdownPriorityValue,
                    onChanged: dropdownPriorityCallback,
                    decoration: InputDecoration(
                      labelText: "Priority",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    controller: _posterController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(labelText: 'Poster', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter Poster";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.onSurface)),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        addNote();
                      });
                      //Navigator.pop(context); // Close the bottom sheet when button is pressed
                    }
                  },
                  child: const Text('Post', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/data/database.dart';
import 'package:task_manager/models/upcoming_schedule.dart';
import 'package:task_manager/screens/helper/constants.dart';

class EditUpcomingSchedule extends StatefulWidget {
  final FirestoreServiceUpcomingSchedule fb;
  final String docID;
  final UpcomingSchedule item;
  //final Function() loadNewMissingItem;
  const EditUpcomingSchedule({
    super.key,
    required this.fb,
    required this.docID,
    required this.item,
    //required this.loadNewMissingItem,
  });

  @override
  State<EditUpcomingSchedule> createState() => _EditUpcomingScheduleState();
}

class _EditUpcomingScheduleState extends State<EditUpcomingSchedule> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentsController = TextEditingController();
  final TextEditingController _etdaDateController = TextEditingController();
  final TextEditingController _posterController = TextEditingController();
  String dropdownCategoryValue = "";

  @override
  void initState() {
    super.initState();
    dropdownCategoryValue = widget.item.category;
    _titleController.text = widget.item.title;
    _contentsController.text = widget.item.contents;
    _etdaDateController.text = DateFormat('dd/MM/yyyy').format(widget.item.etda);
    _posterController.text = widget.item.poster;
  }

  // save new task
  void editUpcomingSchedule() {
    setState(() {
      UpcomingSchedule item = UpcomingSchedule(dropdownCategoryValue, _titleController.text, _contentsController.text,
          DateFormat('dd/MM/yyyy').parse(_etdaDateController.text), _posterController.text, false, "", "");
      widget.fb.updateUpcomingSchedule(widget.docID, item);

      _titleController.clear();
      _contentsController.clear();
      _posterController.clear();
    });
    Navigator.of(context).pop();
  }

  void dropdownCategoryCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        dropdownCategoryValue = selectedValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Edit Upcoming Schedule:',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField(
                    items: category.map((map) {
                      return DropdownMenuItem<String>(
                        value: map['value'],
                        child: Text(map['name']),
                      );
                    }).toList(),
                    value: dropdownCategoryValue,
                    onChanged: dropdownCategoryCallback,
                    decoration: InputDecoration(
                      labelText: "Category",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
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
                  child: TextFormField(
                    controller: _etdaDateController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(labelText: 'Post Date', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter scheduled date";
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
                        _etdaDateController.text = formattedDate.toString();
                      }
                    },
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
                        editUpcomingSchedule();
                      });
                      //Navigator.pop(context); // Close the bottom sheet when button is pressed
                    }
                  },
                  child: const Text('Edit', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

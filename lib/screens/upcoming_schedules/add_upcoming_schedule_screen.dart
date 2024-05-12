import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/data/database.dart';
import 'package:task_manager/models/upcoming_schedule.dart';
import 'package:task_manager/screens/helper/constants.dart';
import 'package:provider/provider.dart';

class AddUpcomingSchedule extends StatefulWidget {
  final FirestoreServiceUpcomingSchedule fb;
  const AddUpcomingSchedule({
    Key? key,
    required this.fb,
  }) : super(key: key);

  @override
  State<AddUpcomingSchedule> createState() => _AddUpcomingScheduleState();
}

class _AddUpcomingScheduleState extends State<AddUpcomingSchedule> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentsController = TextEditingController();
  final TextEditingController _etdaDateController = TextEditingController();
  final TextEditingController _posterController = TextEditingController();
  String dropdownCategoryValue = "Dispatch";

  @override
  void initState() {
    super.initState();
    String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    _etdaDateController.text = formattedDate;
  }

  // save new task
  void addUpcomingSchedule() {
    setState(() {
      UpcomingSchedule upcomingSchedule = UpcomingSchedule(dropdownCategoryValue, _titleController.text, _contentsController.text,
          DateFormat('dd/MM/yyyy').parse(_etdaDateController.text), _posterController.text, false, "", "");
      widget.fb.addUpcomingSchedule(upcomingSchedule);

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
    _posterController.text = Provider.of<UserInfoProvider>(context).userName;
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Post Upcoming Schedule:',
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
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.onBackground)),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        addUpcomingSchedule();
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

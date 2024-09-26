import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/data/database.dart';
import 'package:task_manager/models/st_picking_packing.dart';
import 'package:task_manager/screens/helper/constants.dart';
import 'package:provider/provider.dart';

class AddStPickingPacking extends StatefulWidget {
  final FirestoreServiceSTPP fb;
  const AddStPickingPacking({
    super.key,
    required this.fb,
  });

  @override
  State<AddStPickingPacking> createState() => _AddStPickingPackingState();
}

class _AddStPickingPackingState extends State<AddStPickingPacking> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _deliveryDateController = TextEditingController();
  String dropdownShopNameValue = "ST-RW";

  @override
  void initState() {
    super.initState();
    String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    _deliveryDateController.text = formattedDate;
  }

  // save new task
  void addStPickingPacking() {
    setState(() {
      StPickingPacking stPickingPacking = StPickingPacking(
          dropdownShopNameValue, "", "", "", 0, DateFormat('dd/MM/yyyy').parse(_deliveryDateController.text), "", 0, "", 0, false, false, false, false, "", "");
      widget.fb.addStPickingPacking(stPickingPacking);
    });
    Navigator.of(context).pop();
  }

  void dropdownShopNameCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        dropdownShopNameValue = selectedValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //_posterController.text = Provider.of<UserInfoProvider>(context).userName;
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Post ST Picking Packing:',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField(
                    items: stShops.map((map) {
                      return DropdownMenuItem<String>(
                        value: map['value'],
                        child: Text(map['name']),
                      );
                    }).toList(),
                    value: dropdownShopNameValue,
                    onChanged: dropdownShopNameCallback,
                    decoration: InputDecoration(
                      labelText: "Shop Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    controller: _deliveryDateController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(labelText: 'Delivery Date', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter delivery date";
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
                        _deliveryDateController.text = formattedDate.toString();
                      }
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
                        addStPickingPacking();
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

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/data/database.dart';
import 'package:task_manager/models/low_stock_item.dart';
import 'package:provider/provider.dart';

class AddLowStockItem extends StatefulWidget {
  final FirestoreServiceLowStock fb;
  const AddLowStockItem({
    Key? key,
    required this.fb,
  }) : super(key: key);

  @override
  State<AddLowStockItem> createState() => _AddLowStockItemState();
}

class _AddLowStockItemState extends State<AddLowStockItem> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _currentQtyController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _reportDateController = TextEditingController();
  final TextEditingController _pickerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    _reportDateController.text = formattedDate;
  }

  // save new task
  void addLowStockItem() {
    setState(() {
      LowStockItem lowStockItem = LowStockItem(_productNameController.text, _codeController.text, _currentQtyController.text, _locationController.text,
          DateFormat('dd/MM/yyyy').parse(_reportDateController.text), _pickerController.text, false, "", "");
      widget.fb.addLowStockItem(lowStockItem);

      _productNameController.clear();
      _codeController.clear();
      _currentQtyController.clear();
      _locationController.clear();
      _reportDateController.clear();
      _pickerController.clear();
    });
    Navigator.of(context).pop();
    //widget.loadNewMissingItem();
  }

  @override
  Widget build(BuildContext context) {
    _pickerController.text = Provider.of<UserInfoProvider>(context).userName;
    return Container(
      child: Form(
        // -->into function
        key: _formKey,
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter low stock item information:',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _productNameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(labelText: 'Product Name', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter Product name";
                }
                return null;
              },
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _codeController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(labelText: 'Code', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter Code";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: TextFormField(
                    controller: _currentQtyController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(labelText: 'Current Qty', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter Quantity";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: TextFormField(
                    controller: _locationController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(labelText: 'Location', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter Location";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _reportDateController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(labelText: 'Report Date', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter Report date";
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
                        _reportDateController.text = formattedDate.toString();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: TextFormField(
                    controller: _pickerController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(labelText: 'Picker', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter Picker";
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
                        addLowStockItem();
                      });
                      //Navigator.pop(context); // Close the bottom sheet when button is pressed
                    }
                  },
                  child: const Text('Submit', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

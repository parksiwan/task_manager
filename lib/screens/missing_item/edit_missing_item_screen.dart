import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/data/database.dart';
import 'package:task_manager/models/missing_item.dart';

class EditMissingItem extends StatefulWidget {
  final FirestoreServiceMI fb;
  final String docID;
  final MissingItem item;
  //final Function() loadNewMissingItem;
  const EditMissingItem({
    Key? key,
    required this.fb,
    required this.docID,
    required this.item,
    //required this.loadNewMissingItem,
  }) : super(key: key);

  @override
  State<EditMissingItem> createState() => _EditMissingItemState();
}

class _EditMissingItemState extends State<EditMissingItem> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _shopController = TextEditingController();
  final TextEditingController _deliveryDateController = TextEditingController();
  final TextEditingController _pickerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now().add(const Duration(days: 1)));
    //_deliveryDateController.text = formattedDate;
    _productNameController.text = widget.item.productName;
    _codeController.text = widget.item.productCode;
    _qtyController.text = widget.item.qty;
    _locationController.text = widget.item.location;
    _shopController.text = widget.item.shopName;
    _deliveryDateController.text = DateFormat('dd/MM/yyyy').format(widget.item.deliveryDate);
    _pickerController.text = widget.item.picker;
  }

  // save new task
  void editMissingItem() {
    setState(() {
      MissingItem missingItem = MissingItem(
          _productNameController.text,
          _codeController.text,
          _qtyController.text,
          _locationController.text,
          _shopController.text,
          DateFormat('dd/MM/yyyy').parse(_deliveryDateController.text),
          _pickerController.text,
          widget.item.pickupCompleted,
          widget.item.checker,
          widget.item.memo);
      widget.fb.updateMissingItem(widget.docID, missingItem);

      _productNameController.clear();
      _codeController.clear();
      _qtyController.clear();
      _locationController.clear();
      _shopController.clear();
      _deliveryDateController.clear();
      _pickerController.clear();
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        // -->into function
        key: _formKey,
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Edit missing item information:',
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
                    controller: _qtyController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(labelText: 'Qty', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
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
            TextFormField(
              controller: _shopController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(labelText: 'Shop Name', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter Shop name";
                }
                return null;
              },
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _deliveryDateController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(labelText: 'Delivery Date', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter Delivery date";
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
                        editMissingItem();
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

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/data/database.dart';
import 'package:task_manager/models/st_picking_packing.dart';
import 'package:task_manager/screens/helper/constants.dart';

class EditPicking extends StatefulWidget {
  final FirestoreServiceSTPP fb;
  final String docID;
  final StPickingPacking item;
  //final Function() loadNewMissingItem;
  const EditPicking({
    super.key,
    required this.fb,
    required this.docID,
    required this.item,
    //required this.loadNewMissingItem,
  });

  @override
  State<EditPicking> createState() => _EditPickingState();
}

class _EditPickingState extends State<EditPicking> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _missingItemsController = TextEditingController();
  String _shopName = "";
  String _picker = "";

  @override
  void initState() {
    super.initState();
    _missingItemsController.text = widget.item.missingItems;
    _shopName = widget.item.shopName;
    _picker = widget.item.picker;
  }

  // save new task
  void editPicking() {
    setState(() {
      StPickingPacking item = StPickingPacking(
          widget.item.shopName,
          _picker,
          _missingItemsController.text,
          widget.item.checker,
          widget.item.numberOfBox,
          widget.item.deliveryDate,
          widget.item.additionalItems,
          widget.item.numberOfBoxAdd,
          widget.item.officeItems,
          widget.item.numberOfBoxOffice,
          widget.item.pickupCompleted,
          widget.item.checkCompleted,
          widget.item.additionalCompleted,
          widget.item.officeCompleted,
          widget.item.checkerAdditional,
          widget.item.checkerOffice);
      widget.fb.updateStPickingPacking(widget.docID, item);

      _missingItemsController.clear();
    });
    Navigator.of(context).pop();
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
              'Pick Up',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(widget.item.shopName),
                ),
                const SizedBox(width: 5),
                Expanded(
                  flex: 1,
                  child: Text(widget.item.picker),
                ),
              ],
            ),
            const SizedBox(height: 5),
            TextFormField(
              maxLines: 3,
              controller: _missingItemsController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(labelText: 'Missing Items', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
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
                        editPicking();
                      });
                      //Navigator.pop(context); // Close the bottom sheet when button is pressed
                    }
                  },
                  child: const Text('PickUp Done', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

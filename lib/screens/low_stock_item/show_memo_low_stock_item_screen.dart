import 'package:flutter/material.dart';

class ShowMemoLowStockItem extends StatelessWidget {
  final String memo;

  const ShowMemoLowStockItem({
    super.key,
    required this.memo,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 700,
      child: Column(
        children: [
          const Text(
            "Memo",
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.normal),
          ),
          const SizedBox(height: 10),
          Text(
            memo,
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.onBackground)),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ShowMemoMissingItem extends StatelessWidget {
  final String memo;

  const ShowMemoMissingItem({
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
            style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.onSurface)),
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

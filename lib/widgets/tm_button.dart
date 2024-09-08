import 'package:flutter/material.dart';

class TMButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const TMButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSurface,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(25),
        child: Center(
          child: Text(text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              )),
        ),
      ),
    );
  }
}

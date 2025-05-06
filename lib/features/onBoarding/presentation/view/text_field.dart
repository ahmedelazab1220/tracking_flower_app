import 'package:flutter/material.dart';

class TextField extends StatelessWidget {
  final String label;
  final TextStyle? textStyle;

  const TextField({super.key, required this.label, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        label,
        style: textStyle ?? Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}

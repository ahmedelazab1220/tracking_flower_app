import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? color;
  final TextStyle? textStyle;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: color ?? Theme.of(context).primaryColor,
            border: Border.all(color: Colors.black, width: .5),
            borderRadius: BorderRadius.circular(22), 
          ),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            child: Text(
              label,
              style: textStyle ?? Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
      ),
    );
  }
}
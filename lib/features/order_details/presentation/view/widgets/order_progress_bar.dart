import 'package:flutter/material.dart';

class OrderProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const OrderProgressBar({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(totalSteps, (index) {
        int stepIndex = (index ~/ 1) + 1;
        return Container(
          width: 65,
          height: 6,
          decoration: BoxDecoration(
            color: stepIndex <= currentStep ? Colors.green : Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../core/assets/app_colors.dart';

class ScanningOverlay extends StatefulWidget {
  final String text;
  const ScanningOverlay({super.key, required this.text});

  @override
  State<ScanningOverlay> createState() => _ScanningOverlayState();
}

class _ScanningOverlayState extends State<ScanningOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<int> _dotAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();

    _dotAnimation = IntTween(begin: 0, end: 3).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.75, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.black.withAlpha(200),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(color: AppColors.white),
            const SizedBox(height: 16),
            AnimatedBuilder(
              animation: _dotAnimation,
              builder: (context, child) {
                return Text(
                  '${widget.text}${'.' * _dotAnimation.value}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({Key? key, required this.fill});

  final double fill;

  @override
  Widget build(BuildContext context) {
    // Ensure that fill is within the valid range [0.0, 1.0]
    final validFill = fill.clamp(0.0, 1.0);

    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: FractionallySizedBox(
          heightFactor: validFill,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)),
              color: isDarkMode
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.primary.withOpacity(0.7),
            ),
          ),
        ),
      ),
    );
  }
}

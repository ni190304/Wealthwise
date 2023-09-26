import 'package:flutter/material.dart';

class Neubox7 extends StatelessWidget {
  final child;
  const Neubox7({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: child,
      ),
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade500,
                blurRadius: 15,
                offset: Offset(5, 5)),
            const BoxShadow(
                color: Colors.white, blurRadius: 15, offset: Offset(-5, -5))
          ]),
    );
  }
}

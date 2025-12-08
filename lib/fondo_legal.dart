import 'package:flutter/material.dart';

class FondoLegal extends StatelessWidget {
  final Widget child;

  const FondoLegal({required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/FondoLegal.png',
            fit: BoxFit.cover,
          ),
        ),
        child,
      ],
    );
  }
}

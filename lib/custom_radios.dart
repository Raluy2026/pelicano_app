import 'package:flutter/material.dart';

class CustomCheckCircle extends StatelessWidget {
  final bool checked;
  final VoidCallback onTap;

  const CustomCheckCircle({required this.checked, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 22, height: 22,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
          color: checked ? Colors.white : Colors.transparent,
        ),
        child: checked
            ? Center(
                child: Icon(
                  Icons.check,
                  size: 15,
                  color: Color(0xFF154360),
                ),
              )
            : null,
      ),
    );
  }
}

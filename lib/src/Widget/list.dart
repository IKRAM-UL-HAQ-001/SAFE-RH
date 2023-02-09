import 'package:flutter/material.dart';

class CoffeType extends StatelessWidget {
  final String coffeType;
  final bool selected;
  final VoidCallback onTap;
  CoffeType(
      {required this.coffeType, required this.selected, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: Text(
          coffeType,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: selected ? Colors.orange : Colors.black,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class GroceryCardViewModel {
  final String name;
  final Color color;
  final String quantity;

  const GroceryCardViewModel({
    required this.name,
    required this.color,
    required this.quantity,
  });
}

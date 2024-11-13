import 'package:flutter/material.dart';

enum Category {
  vegetables(rawValue: "vegetables"),
  fruit(rawValue: "fruit"),
  meat(rawValue: "meat"),
  dairy(rawValue: "dairy"),
  carbs(rawValue: "carbs"),
  sweets(rawValue: "sweets"),
  spices(rawValue: "spices"),
  convenience(rawValue: "convenience"),
  hygiene(rawValue: "hygiene"),
  other(rawValue: "other");

  String get title {
    switch (this) {
      case Category.vegetables:
        return "Vegetables";
      case Category.fruit:
        return "Fruit";
      case Category.meat:
        return "Meat";
      case Category.dairy:
        return "Dairy";
      case Category.carbs:
        return "Carbs";
      case Category.sweets:
        return "Sweets";
      case Category.spices:
        return "Spices";
      case Category.convenience:
        return "Convenience";
      case Category.hygiene:
        return "Hygiene";
      case Category.other:
        return "Other";
    }
  }

  Color get color {
    switch (this) {
      case Category.vegetables:
        return Colors.blue;
      case Category.fruit:
        return Colors.teal;
      case Category.meat:
        return Colors.orange;
      case Category.dairy:
        return Colors.purple;
      case Category.carbs:
        return Colors.green;
      case Category.sweets:
        return Colors.amber;
      case Category.spices:
        return Colors.cyan;
      case Category.convenience:
        return Colors.pink;
      case Category.hygiene:
        return Colors.red;
      case Category.other:
        return Colors.yellow;
    }
  }

  final String rawValue;

  const Category({required this.rawValue});

  factory Category.fromRawValue(String rawValue) {
    return values.firstWhere((e) => e.rawValue == rawValue);
  }
}

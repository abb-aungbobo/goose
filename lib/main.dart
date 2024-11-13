import 'package:flutter/material.dart';
import 'package:goose/app/goose_app.dart';
import 'package:goose/locator/locator.dart';

void main() {
  setupLocator();
  runApp(const GooseApp());
}

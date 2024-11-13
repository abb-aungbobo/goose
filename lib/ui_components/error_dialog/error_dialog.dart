import 'package:flutter/material.dart';

Future<void> showErrorDialog(
  BuildContext context, {
  required Object? error,
}) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Oops!"),
        content: Text(error.toString()),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Dismiss"),
          ),
        ],
      );
    },
  );
}

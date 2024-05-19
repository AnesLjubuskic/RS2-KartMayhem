import 'package:flutter/material.dart';

Future<dynamic> showErrorDialog(BuildContext context, String? message) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Error', style: TextStyle(color: Color(0xFF870000))),
        content: Text(message ?? 'Dogodila se greška.',
            style: const TextStyle(color: Colors.black)),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

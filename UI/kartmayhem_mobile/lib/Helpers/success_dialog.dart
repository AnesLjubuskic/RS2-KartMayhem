import 'package:flutter/material.dart';

Future<dynamic> showSuccessDialog(BuildContext context, String? message) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Uspjeh', style: TextStyle(color: Colors.black)),
        content: Text(message ?? 'Operacija uspješno izvršena',
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

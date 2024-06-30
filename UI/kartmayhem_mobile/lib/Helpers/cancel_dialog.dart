import 'package:flutter/material.dart';

Future<dynamic> showCancelDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Važno!'),
        content: const Text(
            'Moguće je samo otkazati rezervaciju ukoliko ste odabrali gotovinu kao metodu naplate i koje su najranije sutradan!',
            style: TextStyle(color: Colors.black)),
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

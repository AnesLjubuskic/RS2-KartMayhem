import 'package:flutter/material.dart';
import 'package:kartmayhem_mobile/Helpers/error_dialog.dart';
import 'package:kartmayhem_mobile/Helpers/success_dialog.dart';
import 'package:kartmayhem_mobile/Providers/rezencije_provider.dart';

Future<dynamic> showRecenzijeDialog(BuildContext context, int stazaId) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Ocijenite stazu'),
        content: Text('Ocijenite stazu od 1 do 4'),
        actions: <Widget>[
          Row(
            children: [
              for (int i = 1; i <= 4; i++)
                TextButton(
                  child: Text('$i'),
                  onPressed: () {
                    Navigator.of(context).pop(i);
                  },
                ),
            ],
          ),
        ],
      );
    },
  ).then(
    (value) async {
      if (value != null) {
        var provider = RezencijeProvider();
        Map rezencija = {'ocjena': value, 'stazaId': stazaId};
        try {
          await provider.insert(rezencija);
          showSuccessDialog(context, 'Ocijenili ste stazu sa ocjenom $value');
        } on Exception catch (e) {
          String errorMessage = e.toString().replaceFirst('Exception: ', '');
          // ignore: use_build_context_synchronously
          showErrorDialog(context, errorMessage);
        }
      }
    },
  );
}

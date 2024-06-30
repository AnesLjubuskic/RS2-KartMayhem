import 'package:flutter/material.dart';
import 'package:kartmayhem_mobile/Helpers/error_dialog.dart';
import 'package:kartmayhem_mobile/Helpers/success_dialog.dart';
import 'package:kartmayhem_mobile/Providers/feedback_provider.dart';
import 'package:kartmayhem_mobile/Utils/util.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  late FeedbackProvider _feedbackProvider;
  String _feedback = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
        backgroundColor: const Color(0xFF870000),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const Center(
              child: Text(
                "Ostavite komentar o aplikaciji",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Unesite vaš feedback',
                  border: OutlineInputBorder(),
                ),
                maxLength: 150,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Feedback ne može biti prazan';
                  }
                  if (value.length > 150) {
                    return 'Feedback mora biti ispod 150 karaktera';
                  }
                  return null;
                },
                onSaved: (value) {
                  _feedback = value!;
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  try {
                    _feedbackProvider = FeedbackProvider();
                    Map feedback = {
                      'komentar': _feedback,
                      'korisnikId': Authorization.id
                    };
                    await _feedbackProvider.insert(feedback);
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                    // ignore: use_build_context_synchronously
                    showSuccessDialog(
                        context, "Uspješno ste ostavili komentar!");
                  } on Exception catch (e) {
                    String errorMessage =
                        e.toString().replaceFirst('Exception: ', '');
                    // ignore: use_build_context_synchronously
                    showErrorDialog(context, errorMessage);
                    // ignore: use_build_context_synchronously
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF870000),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20, 10.0),
                child: Text('Spasi',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

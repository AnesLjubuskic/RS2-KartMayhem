import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register';

  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _ime;
  String? _prezime;
  String? _email;
  String? _lozinka;
  File? _picture;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _picture = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: const Color(0xFF870000),
        foregroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'Kart Mayhem',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF870000)),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Ime'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ime je obavezno';
                    }
                    return null;
                  },
                  onSaved: (value) => _ime = value,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Prezime'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Prezime je obavezno';
                    }
                    return null;
                  },
                  onSaved: (value) => _prezime = value,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email je obavezan';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Unesite validan email';
                    }
                    return null;
                  },
                  onSaved: (value) => _email = value,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Lozinka'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lozinka je obavezna';
                    }
                    if (value.length < 6) {
                      return 'Lozinka mora sadržavati najmanje 6 karaktera!';
                    }
                    return null;
                  },
                  onSaved: (value) => _lozinka = value,
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _pickImage,
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            backgroundColor: const Color(0xFF870000),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: const Text('Upload Photo'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                if (_picture != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Image.file(
                      _picture!,
                      height: 200,
                    ),
                  ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _formKey.currentState?.save();
                          } else {
                            print('Validation failed');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            backgroundColor: const Color(0xFF870000),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: const Text('Register'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

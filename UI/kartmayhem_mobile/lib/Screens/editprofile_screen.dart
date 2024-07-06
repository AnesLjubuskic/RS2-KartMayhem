import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kartmayhem_mobile/Helpers/error_dialog.dart';
import 'package:kartmayhem_mobile/Helpers/success_dialog.dart';
import 'package:kartmayhem_mobile/Models/korisnik.dart';
import 'package:kartmayhem_mobile/Providers/korisnik_provider.dart';
import 'package:kartmayhem_mobile/Utils/util.dart';

RegExp regexEmail = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

class EditProfileScreen extends StatefulWidget {
  static const routeName = "/editprofile";
  final Korisnik korisnik;

  const EditProfileScreen({
    super.key,
    required this.korisnik,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late KorisnikProvider _korisnikProvider;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController _imeController;
  late TextEditingController _prezimeController;
  late TextEditingController _emailController;
  String? _pictureBase64;
  final ImagePicker _picker = ImagePicker();

  File? _picture;

  @override
  void initState() {
    super.initState();
    _imeController = TextEditingController(text: widget.korisnik.ime);
    _prezimeController = TextEditingController(text: widget.korisnik.prezime);
    _emailController = TextEditingController(text: widget.korisnik.email);
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _picture = File(pickedFile.path);
        _pictureBase64 = imageToBase64(_picture!.readAsBytesSync());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit'),
        backgroundColor: const Color(0xFF870000),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Text(
                  "Kliknite na sliku da je promijenite",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              odaberiteSliku(),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Ime *",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              imeInput(),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Prezime *",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              prezimeInput(),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Email *",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              emailInput(),
              const SizedBox(
                height: 20,
              ),
              spasiButton()
            ],
          ),
        ),
      ),
    );
  }

  Padding emailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Colors.grey),
        ),
        child: TextFormField(
          controller: _emailController,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 10, right: 10, left: 10),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Ovo polje je obavezno';
            } else if (!regexEmail.hasMatch(value)) {
              return 'Unesite ispravnu email adresu';
            }
            return null;
          },
        ),
      ),
    );
  }

  Padding prezimeInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Colors.grey),
        ),
        child: TextFormField(
          controller: _prezimeController,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 10, right: 10, left: 10),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Ovo polje je obavezno';
            }
            return null;
          },
        ),
      ),
    );
  }

  Padding imeInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Colors.grey),
        ),
        child: TextFormField(
          controller: _imeController,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 10, right: 10, left: 10),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Ovo polje je obavezno';
            }
            return null;
          },
        ),
      ),
    );
  }

  Center odaberiteSliku() {
    return Center(
      child: GestureDetector(
        onTap: _pickImage,
        child: ClipOval(
          child: _picture != null
              ? Image.file(
                  _picture!,
                  fit: BoxFit.cover,
                  height: 180,
                  width: 180,
                )
              : widget.korisnik.slika != null
                  ? imageFromBase64String(
                      widget.korisnik.slika!,
                      fit: BoxFit.cover,
                      height: 180,
                      width: 180,
                    )
                  : Container(
                      color: Colors.grey,
                      height: 180,
                      width: 180,
                    ),
        ),
      ),
    );
  }

  Center spasiButton() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 0.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    _korisnikProvider = KorisnikProvider();
                    try {
                      if (_picture == null) {
                        await _korisnikProvider.editUser(Authorization.id!, {
                          'ime': _imeController.text,
                          'prezime': _prezimeController.text,
                          'email': _emailController.text,
                        });
                      } else {
                        await _korisnikProvider.editUser(Authorization.id!, {
                          'ime': _imeController.text,
                          'prezime': _prezimeController.text,
                          'email': _emailController.text,
                          'slika': _pictureBase64
                        });
                      }
                      if (context.mounted) {
                        Authorization.email = _emailController.text;
                        Navigator.pop(context);
                        showSuccessDialog(
                            context, 'Uspješno ste editovali korisnika!');
                      }
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
                  backgroundColor: const Color(0xFFE8E8E8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Spasi",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

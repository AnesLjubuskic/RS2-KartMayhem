// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartmayhem_desktop/Models/korisnik.dart';

class EditKorisniciModal extends StatefulWidget {
  final Korisnik korisnik;
  final Function handleEdit;

  const EditKorisniciModal({
    super.key,
    required this.korisnik,
    required this.handleEdit,
  });

  @override
  State<EditKorisniciModal> createState() => _EditKorisniciModalState();
}

class _EditKorisniciModalState extends State<EditKorisniciModal> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController _imeController;
  late TextEditingController _prezimeController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _imeController = TextEditingController(text: widget.korisnik.ime);
    _prezimeController = TextEditingController(text: widget.korisnik.prezime);
    _emailController = TextEditingController(text: widget.korisnik.email);
  }

  @override
  void dispose() {
    _imeController.dispose();
    _prezimeController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Text(
                  "Uređivanje korisnika",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Ime *",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextFormField(
                  controller: _imeController,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.only(bottom: 10, right: 10, left: 10),
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
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Prezime *",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextFormField(
                  controller: _prezimeController,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.only(bottom: 10, right: 10, left: 10),
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
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Email *",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.only(bottom: 10, right: 10, left: 10),
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
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xFF870000),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          child: const Text(
            'Otkaži',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              widget.handleEdit(widget.korisnik.id!, _imeController.text,
                  _prezimeController.text, _emailController.text);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD7D2DC),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          child: const Text(
            'Spasi',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}

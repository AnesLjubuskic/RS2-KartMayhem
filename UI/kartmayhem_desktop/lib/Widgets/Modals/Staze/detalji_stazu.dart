// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartmayhem_desktop/Models/staze.dart';

class DetailStazeModal extends StatefulWidget {
  final Staze staze;

  const DetailStazeModal({
    super.key,
    required this.staze,
  });

  @override
  State<DetailStazeModal> createState() => _DetailStazeModalState();
}

class _DetailStazeModalState extends State<DetailStazeModal> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController _nazivStazeController;
  late TextEditingController _opisStazeController;
  late TextEditingController _cijenaPoOsobiController;
  late TextEditingController _duzinaStazeController;
  late TextEditingController _brojKrugovaController;
  late TextEditingController _maxBrojOsobaController;

  String? initialText = '';
  String? initialGradText = '';

  @override
  void initState() {
    super.initState();
    _nazivStazeController =
        TextEditingController(text: widget.staze.nazivStaze);
    _opisStazeController = TextEditingController(text: widget.staze.opisStaze);
    _cijenaPoOsobiController =
        TextEditingController(text: widget.staze.cijenaPoOsobi?.toString());
    _duzinaStazeController =
        TextEditingController(text: widget.staze.duzinaStaze?.toString());
    _brojKrugovaController =
        TextEditingController(text: widget.staze.brojKrugova?.toString());
    _maxBrojOsobaController =
        TextEditingController(text: widget.staze.maxBrojOsoba?.toString());
    initialGradText = widget.staze.gradovi?.nazivGrada;
    initialText = widget.staze.tezina?.naziv;
  }

  @override
  void dispose() {
    _nazivStazeController.dispose();
    _opisStazeController.dispose();
    _cijenaPoOsobiController.dispose();
    _duzinaStazeController.dispose();
    _brojKrugovaController.dispose();
    _maxBrojOsobaController.dispose();
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
                  "Detalji staze",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Naziv",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextFormField(
                  enabled: false,
                  controller: _nazivStazeController,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.only(bottom: 20, right: 10, left: 10),
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
              const SizedBox(height: 5),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Deskripcija",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextFormField(
                  enabled: false,
                  controller: _opisStazeController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Dužina staze",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: 30,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: TextFormField(
                              enabled: false,
                              controller: _duzinaStazeController,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d*'),
                                ),
                              ],
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    bottom: 20, right: 10, left: 10),
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
                        ),
                        const SizedBox(height: 5),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Max broj osoba",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: 30,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: TextFormField(
                              enabled: false,
                              controller: _maxBrojOsobaController,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    bottom: 20, right: 10, left: 10),
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
                        ),
                        const SizedBox(height: 5),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Težina",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: TextFormField(
                            enabled: false,
                            initialValue: initialText ?? "",
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  bottom: 10, right: 10, left: 10),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            onChanged: (value) {},
                            validator: (value) {
                              if (value == null) {
                                return 'Ovo polje je obavezno';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Broj krugova",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: 30,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: TextFormField(
                              enabled: false,
                              controller: _brojKrugovaController,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    bottom: 20, right: 10, left: 10),
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
                        ),
                        const SizedBox(height: 5),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Cijena po osobi",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: 30,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: TextFormField(
                              enabled: false,
                              controller: _cijenaPoOsobiController,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    bottom: 20, right: 10, left: 10),
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
                        ),
                        const SizedBox(height: 5),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Grad",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: TextFormField(
                            enabled: false,
                            initialValue: initialGradText ?? "",
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  bottom: 10, right: 10, left: 10),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            onChanged: (value) {},
                            validator: (value) {
                              if (value == null) {
                                return 'Ovo polje je obavezno';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF870000),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 45, vertical: 16),
              ),
              child: const Text(
                'Zatvori',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

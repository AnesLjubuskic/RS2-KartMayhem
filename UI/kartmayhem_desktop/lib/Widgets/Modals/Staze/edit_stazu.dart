// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartmayhem_desktop/Models/gradovi.dart';
import 'package:kartmayhem_desktop/Models/search_result.dart';
import 'package:kartmayhem_desktop/Models/staze.dart';
import 'package:kartmayhem_desktop/Models/tezine.dart';
import 'package:kartmayhem_desktop/Providers/gradovi_provider.dart';
import 'package:kartmayhem_desktop/Providers/tezina_provider.dart';

class EditStazeModal extends StatefulWidget {
  final Staze staze;
  final Function handleEdit;

  const EditStazeModal({
    super.key,
    required this.staze,
    required this.handleEdit,
  });

  @override
  State<EditStazeModal> createState() => _EditStazeModalState();
}

class _EditStazeModalState extends State<EditStazeModal> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late GradoviProvider _gradoviProvider;
  late TezinaProvider _tezinaProvider;
  late TextEditingController _nazivStazeController;
  late TextEditingController _opisStazeController;
  late TextEditingController _cijenaPoOsobiController;
  late TextEditingController _duzinaStazeController;
  late TextEditingController _brojKrugovaController;
  late TextEditingController _maxBrojOsobaController;
  SearchResult<Gradovi>? result;
  SearchResult<Tezine>? resultTezine;

  int? _selectedTezinaId;
  int? _selectedGradId;

  @override
  void initState() {
    super.initState();
    _initializeData();
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
    _selectedTezinaId = widget.staze.tezina?.id;
    _selectedGradId = widget.staze.gradovi?.id;
  }

  String? nazivStazeError;
  String? opisStazeError;
  String? cijenaPoOsobiError;
  String? duzinaStazeError;
  String? brojKrugovaError;
  String? maxBrojOsobaError;
  String? tezinaIdError;
  String? gradoviIdError;

  Future<void> _initializeData() async {
    _gradoviProvider = GradoviProvider();
    _tezinaProvider = TezinaProvider();
    var data = await _gradoviProvider.get();
    setState(() {
      result = data;
    });
    var data2 = await _tezinaProvider.get();
    setState(() {
      resultTezine = data2;
    });
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
                  "Uređivanje staze",
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
                  "Naziv *",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextFormField(
                  controller: _nazivStazeController,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.only(bottom: 20, right: 10, left: 10),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  onChanged: (value) {
                    setState(() {
                      nazivStazeError = null;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      setState(() {
                        nazivStazeError = 'Ovo polje je obavezno';
                      });
                      return;
                    }
                    return null;
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(40),
                  ],
                ),
              ),
              if (nazivStazeError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      nazivStazeError!,
                      style: TextStyle(color: Color(0xFF870000)),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              if (nazivStazeError == null) Text(""),
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Deskripcija *",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextFormField(
                  controller: _opisStazeController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  onChanged: (value) {
                    setState(() {
                      opisStazeError = null;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      setState(() {
                        opisStazeError = 'Ovo polje je obavezno';
                      });
                      return;
                    }
                    return null;
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(200),
                  ],
                ),
              ),
              if (opisStazeError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      opisStazeError!,
                      style: TextStyle(color: Color(0xFF870000)),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              if (opisStazeError == null) Text(""),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Dužina staze *",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: TextFormField(
                            controller: _duzinaStazeController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
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
                            onChanged: (value) {
                              setState(() {
                                duzinaStazeError = null;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                setState(() {
                                  duzinaStazeError = 'Ovo polje je obavezno';
                                });
                                return;
                              }
                              double? duzina = double.tryParse(value);
                              if (duzina == null) {
                                setState(() {
                                  duzinaStazeError =
                                      'Unesite ispravnu vrijednost';
                                });
                                return;
                              }
                              if (duzina < 0.5 || duzina > 10.0) {
                                setState(() {
                                  duzinaStazeError =
                                      'Vrijednost mora biti između 0.5 i 10.0';
                                });
                                return;
                              }
                              return null;
                            },
                          ),
                        ),
                        if (duzinaStazeError != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 0.0),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                duzinaStazeError!,
                                style: TextStyle(color: Color(0xFF870000)),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                        if (duzinaStazeError == null) Text(""),
                        const SizedBox(height: 10),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Max broj osoba *",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: TextFormField(
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
                            onChanged: (value) {
                              setState(() {
                                maxBrojOsobaError = null;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                setState(() {
                                  maxBrojOsobaError = 'Ovo polje je obavezno';
                                });
                                return;
                              }
                              int? broj = int.tryParse(value);
                              if (broj == null) {
                                setState(() {
                                  maxBrojOsobaError =
                                      'Unesite ispravnu vrijednost';
                                });
                                return;
                              }
                              if (broj < 1 || broj > 8) {
                                setState(() {
                                  maxBrojOsobaError =
                                      'Vrijednost mora biti između 1 i 8';
                                });
                                return;
                              }
                              return null;
                            },
                          ),
                        ),
                        if (maxBrojOsobaError != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 0.0),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                maxBrojOsobaError!,
                                style: TextStyle(color: Color(0xFF870000)),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                        if (maxBrojOsobaError == null) Text(""),
                        const SizedBox(height: 10),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Težina *",
                            style: TextStyle(
                              fontSize: 16,
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
                          child: DropdownButtonFormField<int>(
                            value: _selectedTezinaId,
                            items: resultTezine?.result.map((tezina) {
                              return DropdownMenuItem<int>(
                                value: tezina.id,
                                child: Text(tezina.naziv!),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedTezinaId = value;
                                tezinaIdError = null;
                              });
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  bottom: 10, right: 10, left: 10),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value == null) {
                                setState(() {
                                  tezinaIdError = 'Ovo polje je obavezno';
                                });
                                return;
                              }
                              return null;
                            },
                          ),
                        ),
                        if (tezinaIdError != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 0.0),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                tezinaIdError!,
                                style: TextStyle(color: Color(0xFF870000)),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                        if (tezinaIdError == null) Text(""),
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
                            "Broj krugova *",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: TextFormField(
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
                            onChanged: (value) {
                              setState(() {
                                brojKrugovaError = null;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                setState(() {
                                  brojKrugovaError = 'Ovo polje je obavezno';
                                });
                                return;
                              }
                              int? broj = int.tryParse(value);
                              if (broj == null) {
                                setState(() {
                                  brojKrugovaError =
                                      'Unesite ispravnu vrijednost';
                                });
                                return;
                              }
                              if (broj < 1 || broj > 5) {
                                setState(() {
                                  brojKrugovaError =
                                      'Vrijednost mora biti između 1 i 5';
                                });
                                return;
                              }
                              return null;
                            },
                          ),
                        ),
                        if (brojKrugovaError != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 0.0),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                brojKrugovaError!,
                                style: TextStyle(color: Color(0xFF870000)),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                        if (brojKrugovaError == null) Text(""),
                        const SizedBox(height: 10),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Cijena po osobi *",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: TextFormField(
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
                            onChanged: (value) {
                              setState(() {
                                cijenaPoOsobiError = null;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                setState(() {
                                  cijenaPoOsobiError = 'Ovo polje je obavezno';
                                });
                                return;
                              }
                              int? cijena = int.tryParse(value);
                              if (cijena == null) {
                                setState(() {
                                  cijenaPoOsobiError =
                                      'Unesite ispravnu vrijednost';
                                });
                                return;
                              }
                              if (cijena < 1 || cijena > 999) {
                                setState(() {
                                  cijenaPoOsobiError =
                                      'Vrijednost mora biti između 1 i 999';
                                });
                                return;
                              }
                              return null;
                            },
                          ),
                        ),
                        if (cijenaPoOsobiError != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 0.0),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                cijenaPoOsobiError!,
                                style: TextStyle(color: Color(0xFF870000)),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                        if (cijenaPoOsobiError == null) Text(""),
                        const SizedBox(height: 10),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Grad *",
                            style: TextStyle(
                              fontSize: 16,
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
                          child: DropdownButtonFormField<int>(
                            value: _selectedGradId,
                            items: result?.result.map((grad) {
                              return DropdownMenuItem<int>(
                                value: grad.id,
                                child: Text(grad.nazivGrada!),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedGradId = value;
                                gradoviIdError = null;
                              });
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  bottom: 10, right: 10, left: 10),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value == null) {
                                setState(() {
                                  gradoviIdError = "Ovo polje je obavezno";
                                });
                              }
                              return null;
                            },
                          ),
                        ),
                        if (gradoviIdError != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 0.0),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                gradoviIdError!,
                                style: TextStyle(color: Color(0xFF870000)),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                        if (gradoviIdError == null) Text(""),
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
            if (formKey.currentState!.validate() &&
                nazivStazeError == null &&
                opisStazeError == null &&
                cijenaPoOsobiError == null &&
                duzinaStazeError == null &&
                brojKrugovaError == null &&
                maxBrojOsobaError == null &&
                tezinaIdError == null &&
                gradoviIdError == null &&
                _nazivStazeController.text.isNotEmpty &&
                _opisStazeController.text.isNotEmpty &&
                _cijenaPoOsobiController.text.isNotEmpty &&
                _duzinaStazeController.text.isNotEmpty &&
                _brojKrugovaController.text.isNotEmpty &&
                _maxBrojOsobaController.text.isNotEmpty) {
              widget.handleEdit(
                  widget.staze.id!,
                  _nazivStazeController.text,
                  _opisStazeController.text,
                  int.tryParse(_cijenaPoOsobiController.text),
                  double.tryParse(_duzinaStazeController.text),
                  int.tryParse(_brojKrugovaController.text),
                  int.tryParse(_maxBrojOsobaController.text),
                  _selectedTezinaId,
                  _selectedGradId);
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

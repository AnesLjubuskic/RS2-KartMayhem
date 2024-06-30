// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartmayhem_desktop/Models/gradovi.dart';
import 'package:kartmayhem_desktop/Models/search_result.dart';
import 'package:kartmayhem_desktop/Models/tezine.dart';
import 'package:kartmayhem_desktop/Providers/gradovi_provider.dart';
import 'package:kartmayhem_desktop/Providers/tezina_provider.dart';

class AddStazeModal extends StatefulWidget {
  final Function handleAdd;

  const AddStazeModal({
    super.key,
    required this.handleAdd,
  });

  @override
  State<AddStazeModal> createState() => _AddStazeModalState();
}

class _AddStazeModalState extends State<AddStazeModal> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late GradoviProvider _gradoviProvider;
  late TezinaProvider _tezinaProvider;
  SearchResult<Gradovi>? result;
  SearchResult<Tezine>? resultTezine;
  String? nazivStaze;
  String? opisStaze;
  int? cijenaPoOsobi;
  double? duzinaStaze;
  int? brojKrugova;
  int? maxBrojOsoba;
  int? tezinaId;
  int? gradoviId;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

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
                  "Dodavanje staze",
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
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.only(bottom: 20, right: 10, left: 10),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  onChanged: (value) {
                    nazivStaze = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ovo polje je obavezno';
                    }
                    return null;
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(40),
                  ],
                ),
              ),
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
                  maxLines: 3,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  onChanged: (value) {
                    opisStaze = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ovo polje je obavezno';
                    }
                    return null;
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(200),
                  ],
                ),
              ),
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
                                duzinaStaze = double.tryParse(value);
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ovo polje je obavezno';
                              }
                              double? duzina = double.tryParse(value);
                              if (duzina == null) {
                                return 'Unesite ispravnu vrijednost';
                              }
                              if (duzina < 0.5 || duzina > 10.0) {
                                return 'Vrijednost mora biti između 0.5 i 10.0';
                              }
                              return null;
                            },
                          ),
                        ),
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
                                maxBrojOsoba = int.tryParse(value);
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ovo polje je obavezno';
                              }
                              int? broj = int.tryParse(value);
                              if (broj == null) {
                                return 'Unesite ispravnu vrijednost';
                              }
                              if (broj < 1 || broj > 8) {
                                return 'Vrijednost mora biti između 1 i 8';
                              }
                              return null;
                            },
                          ),
                        ),
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
                            value: tezinaId,
                            items: resultTezine?.result.map((tezina) {
                              return DropdownMenuItem<int>(
                                value: tezina.id,
                                child: Text(tezina.naziv!),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                tezinaId = value;
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
                                brojKrugova = int.tryParse(value);
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ovo polje je obavezno';
                              }
                              int? broj = int.tryParse(value);
                              if (broj == null) {
                                return 'Unesite ispravnu vrijednost';
                              }
                              if (broj < 1 || broj > 5) {
                                return 'Vrijednost mora biti između 1 i 5';
                              }
                              return null;
                            },
                          ),
                        ),
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
                                cijenaPoOsobi = int.tryParse(value);
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ovo polje je obavezno';
                              }
                              int? cijena = int.tryParse(value);
                              if (cijena == null) {
                                return 'Unesite ispravnu vrijednost';
                              }
                              if (cijena < 1 || cijena > 999) {
                                return 'Vrijednost mora biti između 1 i 999';
                              }
                              return null;
                            },
                          ),
                        ),
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
                            value: gradoviId,
                            items: result?.result.map((grad) {
                              return DropdownMenuItem<int>(
                                value: grad.id,
                                child: Text(grad.nazivGrada!),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                gradoviId = value;
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
              widget.handleAdd(nazivStaze, opisStaze, cijenaPoOsobi,
                  duzinaStaze, brojKrugova, maxBrojOsoba, tezinaId, gradoviId);
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

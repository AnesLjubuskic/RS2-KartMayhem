// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:kartmayhem_mobile/Helpers/error_dialog.dart';
import 'package:kartmayhem_mobile/Models/rezervacijeUpsert.dart';
import 'package:kartmayhem_mobile/Models/staze.dart';
import 'package:kartmayhem_mobile/Providers/reservationUpsert_provider.dart';
import 'package:kartmayhem_mobile/Providers/reservation_provider.dart';
import 'package:kartmayhem_mobile/Providers/staze_provider.dart';
import 'package:kartmayhem_mobile/Utils/util.dart';

class ReservationScreen extends StatefulWidget {
  final int stazeId;
  const ReservationScreen({Key? key, required this.stazeId}) : super(key: key);
  static const routeName = "/reservation";

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  late StazeProvider _stazeProvider;
  late RezervacijeProvider _rezervacijeProvider;
  late RezervacijeUpsertProvider _rezervacijeUpsertProvider;

  Staze? staza;
  late List<String> timeSlots = [];
  int selectedSlot = -1;
  int? brojOsoba = 1;
  bool kartica = false;
  bool gotovina = false;
  DateTime selectedDate = DateTime.now().add(Duration(days: 1));
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
    _initializeData();
    _timeSlotsUpdate();
  }

  Future<void> _initializeData() async {
    _stazeProvider = StazeProvider();
    var data = await _stazeProvider.getById(widget.stazeId);
    setState(() {
      staza = data;
    });
  }

  Future<void> _timeSlotsUpdate() async {
    _rezervacijeProvider = RezervacijeProvider();
    var data = await _rezervacijeProvider.getReservationTimeSlots(
        widget.stazeId, dateFormat.format(selectedDate));
    setState(() {
      timeSlots = data;
    });
  }

  void setSlotIndex(int index) {
    setState(() {
      selectedSlot = index;
    });
  }

  void submitReservation() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rezervacija'),
        backgroundColor: const Color(0xFF870000),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              child: staza?.slika != null
                  ? imageFromBase64String(
                      staza!.slika!,
                      fit: BoxFit.cover,
                      height: 250,
                      width: double.infinity,
                    )
                  : Container(
                      color: Colors.grey,
                      height: 250,
                      width: double.infinity,
                    ),
            ),
            const Center(
              child: Text(
                "Rezervišite termin za",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            Center(
              child: Text(
                staza?.nazivStaze ?? "",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                staza?.opisStaze ?? "",
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 20),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
              child: Text(
                "Detalji:",
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
              child: Text(
                "Težina: ${staza?.tezina?.naziv ?? ""}",
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
              child: Text(
                "Cijena po osobi: ${staza?.cijenaPoOsobi ?? ""}KM",
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
              child: Text(
                "Dužina: ${staza?.duzinaStaze ?? ""}km",
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
              child: Text(
                "Broj krugova: ${staza?.brojKrugova ?? ""}",
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 20.0),
              child: Text(
                "Maksimalan broj osoba: ${staza?.maxBrojOsoba ?? ""}",
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 18),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    color: const Color(0xFF870000),
                    child: const Center(
                      child: Text(
                        "REZERVACIJA",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 5.0),
              child: Text(
                "Datum ${dateFormat.format(selectedDate)}",
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 18),
              ),
            ),
            InkWell(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now().add(Duration(days: 1)),
                  firstDate: DateTime.now().add(Duration(days: 1)),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  setState(() {
                    selectedDate = pickedDate;
                    _timeSlotsUpdate();
                  });
                }
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF870000),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Text(
                      "Izaberite datum",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 10.0),
              child: Text(
                "Dostupni termini",
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 18),
              ),
            ),

            //amar
            listTimeSlots(),
            //
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 5.0),
              child: Text(
                "Broj osoba",
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 18),
              ),
            ),
            brojOsobaInput(),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 0.0),
              child: Text(
                "Ukupna cijena",
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 10.0),
              child: staza != null
                  ? Text(
                      "${staza!.cijenaPoOsobi! * brojOsoba!}KM ",
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30),
                    )
                  : SizedBox.shrink(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 0.0),
              child: Text(
                "Način plaćanja",
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 18),
              ),
            ),
            paymentButtons(),
            otkaziButton(),
            spremiButton(),
          ],
        ),
      ),
    );
  }

  Padding listTimeSlots() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: List.generate(timeSlots.length, (index) {
          return GestureDetector(
            onTap: () {
              setSlotIndex(index);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: selectedSlot == index
                    ? const Color(0xFF870000)
                    : const Color(0xFFE8E8E8),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  timeSlots[index],
                  style: TextStyle(
                    color: selectedSlot == index ? Colors.white : Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Center spremiButton() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 10.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  // if (gotovina) {
                  RezervacijeUpsert rezervacijeUpsertRequest =
                      RezervacijeUpsert(
                          cijenaPoOsobi: staza!.cijenaPoOsobi,
                          brojOsoba: brojOsoba,
                          dayOfReservation: dateFormat.format(selectedDate),
                          timeSlot: timeSlots[selectedSlot],
                          korisnikId: Authorization.id,
                          stazaId: staza!.id);
                  try {
                    _rezervacijeUpsertProvider = RezervacijeUpsertProvider();
                    await _rezervacijeUpsertProvider
                        .insert(rezervacijeUpsertRequest);
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  } catch (e) {
                    // String errorMessage =
                    //     e.toString().replaceFirst('Exception: ', '');
                    // ignore: use_build_context_synchronously
                    // showErrorDialog(context, errorMessage);
                  }
                  // }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE8E8E8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Spremi",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Center otkaziButton() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 0.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    gotovina = false;
                    kartica = !kartica;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF870000),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Otkaži",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding brojOsobaInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFFE8E8E8),
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Colors.grey),
        ),
        child: TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 10, right: 10, left: 10),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          initialValue: "1",
          onChanged: (value) {
            setState(() {
              brojOsoba = int.tryParse(value);
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
            if (broj < 1 || broj > staza!.maxBrojOsoba!) {
              return 'Vrijednost mora biti između 1 i 8';
            }
            return null;
          },
        ),
      ),
    );
  }

  Row paymentButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 5.0, 5.0, 0.0),
          child: SizedBox(
            width: 150,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  gotovina = false;
                  kartica = !kartica;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    kartica ? const Color(0xFF870000) : const Color(0xFFE8E8E8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Kartica",
                style: TextStyle(
                    color: kartica ? Colors.white : Colors.black, fontSize: 18),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(5.0, 5.0, 20.0, 0.0),
          child: SizedBox(
            width: 150,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  kartica = false;
                  gotovina = !gotovina;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: gotovina
                    ? const Color(0xFF870000)
                    : const Color(0xFFE8E8E8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Gotovina",
                style: TextStyle(
                    color: gotovina ? Colors.white : Colors.black,
                    fontSize: 18),
              ),
            ),
          ),
        )
      ],
    );
  }
}

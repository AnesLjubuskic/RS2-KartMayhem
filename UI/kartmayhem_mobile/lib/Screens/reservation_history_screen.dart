// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartmayhem_mobile/Helpers/rezencija_dialog.dart';
import 'package:kartmayhem_mobile/Models/rezervacije.dart';
import 'package:kartmayhem_mobile/Providers/reservation_provider.dart';
import 'package:kartmayhem_mobile/Utils/util.dart';

class ReservationHistoryScreen extends StatefulWidget {
  final int reservationId;
  const ReservationHistoryScreen({super.key, required this.reservationId});
  static const routeName = "/reservationhistory";

  @override
  State<ReservationHistoryScreen> createState() =>
      _ReservationHistoryScreenState();
}

class _ReservationHistoryScreenState extends State<ReservationHistoryScreen> {
  late RezervacijeProvider _rezervacijeProvider;
  Rezervacije? rezervacije;
  DateTime selectedDate = DateTime.now().add(Duration(days: 1));

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    _rezervacijeProvider = RezervacijeProvider();
    var data = await _rezervacijeProvider.getById(widget.reservationId);
    setState(() {
      rezervacije = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalji rezervacije'),
        backgroundColor: const Color(0xFF870000),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: rezervacije == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    child: rezervacije?.staza?.slika != null
                        ? imageFromBase64String(
                            rezervacije!.staza!.slika!,
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
                  Center(
                    child: Text(
                      rezervacije?.staza?.nazivStaze ?? "Loading...",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      rezervacije?.staza?.opisStaze ?? "Loading description...",
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                    child: Text(
                      "Težina: ${rezervacije?.staza?.tezina?.naziv ?? "Loading..."}",
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                    child: Text(
                      "Cijena po osobi: ${rezervacije?.staza?.cijenaPoOsobi?.toString() ?? "Loading..."} KM",
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                    child: Text(
                      "Dužina: ${rezervacije?.staza?.duzinaStaze?.toString() ?? "Loading..."} km",
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                    child: Text(
                      "Broj krugova: ${rezervacije?.staza?.brojKrugova?.toString() ?? "Loading..."}",
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 20.0),
                    child: Text(
                      "Maksimalan broj osoba: ${rezervacije?.staza?.maxBrojOsoba?.toString() ?? "Loading..."}",
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
                    padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 0.0),
                    child: Text(
                      "Datum: ${rezervacije?.dayOfReservation ?? "Loading..."}",
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                    child: Text(
                      "Termin: ${rezervacije?.timeSlot ?? "Loading..."}",
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                    child: Text(
                      "Broj osoba: ${rezervacije?.brojOsoba?.toString() ?? "Loading..."}",
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                    child: Text(
                      "Ukupna cijena",
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 10.0),
                    child: Text(
                      "${rezervacije?.cijenaRezervacije?.toString() ?? "Loading..."} KM ",
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                  ocijeniteStazuButton()
                ],
              ),
            ),
    );
  }

  Center ocijeniteStazuButton() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 10.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  showRecenzijeDialog(context, rezervacije!.staza!.id!);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF870000),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Ocijenite stazu",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

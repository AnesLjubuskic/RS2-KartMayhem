import 'package:flutter/material.dart';
import 'package:kartmayhem_mobile/Models/rezervacije.dart';
import 'package:kartmayhem_mobile/Providers/reservation_provider.dart';
import 'package:kartmayhem_mobile/Utils/util.dart';
import 'package:provider/provider.dart';

class KartingCardCancel extends StatelessWidget {
  final Rezervacije rezervacija;
  final VoidCallback onCancel;

  const KartingCardCancel({
    super.key,
    required this.rezervacija,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RezervacijeProvider(),
      child: Consumer<RezervacijeProvider>(
        builder: (context, stazeProvider, child) {
          return GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: imageFromBase64String(
                      rezervacija.staza!.slika!,
                      fit: BoxFit.cover,
                      height: 150,
                      width: double.infinity,
                    ),
                  ),
                  Text(
                    rezervacija.staza!.nazivStaze!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                              child: Text(
                                "Datum: ${rezervacija.dayOfReservation}",
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                "Termin: ${rezervacija.timeSlot}",
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                              child: Text(
                                "Cijena: ${rezervacija.cijenaRezervacije}KM",
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 5.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF870000),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: () =>
                                _showConfirmationDialog(context, stazeProvider),
                            child: const Text(
                              "Otkaži",
                              style: TextStyle(fontSize: 20),
                            )),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showConfirmationDialog(
      BuildContext context, RezervacijeProvider rezervacijeProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Potvrda'),
          content:
              const Text('Da li ste sigurni da želite otkazati rezervaciju?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Ne'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                rezervacijeProvider.cancelReservation(rezervacija.id!);
                onCancel();
              },
              child: const Text('Da'),
            ),
          ],
        );
      },
    );
  }
}

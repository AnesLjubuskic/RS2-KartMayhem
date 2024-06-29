import 'package:flutter/material.dart';
import 'package:kartmayhem_mobile/Models/rezervacije.dart';
import 'package:kartmayhem_mobile/Providers/reservation_provider.dart';
import 'package:kartmayhem_mobile/Utils/util.dart';
import 'package:provider/provider.dart';

class KartingCardHistory extends StatelessWidget {
  final Rezervacije rezervacije;

  const KartingCardHistory({
    super.key,
    required this.rezervacije,
  });

  void navigateToReservationScreen(BuildContext context) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => ReservationScreen(
    //       stazeId: staze.id!,
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RezervacijeProvider(),
      child: Consumer<RezervacijeProvider>(
        builder: (context, stazeProvider, child) {
          return GestureDetector(
            onTap: () => navigateToReservationScreen(context),
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
                      rezervacije.staza!.slika!,
                      fit: BoxFit.cover,
                      height: 150,
                      width: double.infinity,
                    ),
                  ),
                  Text(
                    rezervacije.staza!.nazivStaze!,
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
                                "Težina: ${rezervacije.staza!.tezina!.naziv!}",
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                "Broj osoba: ${rezervacije.brojOsoba}",
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                              child: Text(
                                "Dužina: ${rezervacije.cijenaRezervacije}KM",
                                style: const TextStyle(fontSize: 13),
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
          );
        },
      ),
    );
  }
}

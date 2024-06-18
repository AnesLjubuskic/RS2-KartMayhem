import 'package:flutter/material.dart';
import 'package:kartmayhem_mobile/Models/staze.dart';
import 'package:kartmayhem_mobile/Providers/staze_provider.dart';
import 'package:kartmayhem_mobile/Screens/reservation_screen.dart';
import 'package:kartmayhem_mobile/Utils/util.dart';
import 'package:provider/provider.dart';

class KartingCardButton1 extends StatelessWidget {
  final Staze staze;
  final VoidCallback onFavouriteMarked;

  const KartingCardButton1({
    super.key,
    required this.staze,
    required this.onFavouriteMarked,
  });

  void navigateToReservationScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReservationScreen(
          stazeId: staze.id!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StazeProvider(),
      child: Consumer<StazeProvider>(
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
                      staze.slika!,
                      fit: BoxFit.cover,
                      height: 150,
                      width: double.infinity,
                    ),
                  ),
                  Text(
                    staze.nazivStaze!,
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
                                "Težina: ${staze.tezina!.naziv!}",
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                "Cijena po osobi: ${staze.cijenaPoOsobi!}KM",
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                              child: Text(
                                "Dužina: ${staze.duzinaStaze!}km",
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          try {
                            await stazeProvider.MarkFavouriteTrack(search: {
                              'userId': Authorization.id,
                              "id": staze.id
                            });
                            onFavouriteMarked();
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())),
                            );
                          }
                        },
                        icon: Icon(
                          staze.favourite!
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: staze.favourite!
                              ? const Color(0xFF870000)
                              : Colors.black,
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

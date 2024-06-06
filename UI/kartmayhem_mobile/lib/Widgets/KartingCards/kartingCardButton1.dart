import 'package:flutter/material.dart';
import 'package:kartmayhem_mobile/Models/staze.dart';
import 'package:kartmayhem_mobile/Utils/util.dart';

class KartingCardButton1 extends StatelessWidget {
  final Staze staze;
  const KartingCardButton1({super.key, required this.staze});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                onPressed: () {},
                icon: const Icon(Icons.favorite_outline),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kartmayhem_mobile/Models/rezervacije.dart';
import 'package:kartmayhem_mobile/Models/search_result.dart';
import 'package:kartmayhem_mobile/Providers/reservation_provider.dart';
import 'package:kartmayhem_mobile/Utils/util.dart';
import 'package:kartmayhem_mobile/Widgets/KartingCards/kartingCardHistory.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});
  static const routeName = "/historija";

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late RezervacijeProvider _rezervacijeProvider;
  SearchResult<Rezervacije>? result;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    _rezervacijeProvider = RezervacijeProvider();

    var data = await _rezervacijeProvider
        .getHistory(search: {'userId': Authorization.id});
    setState(() {
      result = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Historija'),
          backgroundColor: const Color(0xFF870000),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: (result == null || result!.result.isEmpty)
                  ? const Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Text(
                        "Da bi se rezervacija pojavila u historiji termin mora biti u prošlosti!",
                        style: TextStyle(fontSize: 25),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 20,
                          );
                        },
                        itemCount: result!.count,
                        itemBuilder: (context, index) {
                          final rezervacija = result!.result[index];
                          return KartingCardHistory(
                            rezervacije: rezervacija,
                          );
                        },
                      ),
                    ),
            )
          ],
        ));
  }
}

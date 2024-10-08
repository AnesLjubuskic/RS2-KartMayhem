import 'package:flutter/material.dart';
import 'package:kartmayhem_mobile/Helpers/cancel_dialog.dart';
import 'package:kartmayhem_mobile/Models/rezervacije.dart';
import 'package:kartmayhem_mobile/Models/search_result.dart';
import 'package:kartmayhem_mobile/Providers/reservation_provider.dart';
import 'package:kartmayhem_mobile/Utils/util.dart';
import 'package:kartmayhem_mobile/Widgets/KartingCards/kartingCardCancel.dart';

class CancelReservationScreen extends StatefulWidget {
  const CancelReservationScreen({super.key});
  static const routeName = "/cancel";

  @override
  State<CancelReservationScreen> createState() =>
      _CancelReservationScreenState();
}

class _CancelReservationScreenState extends State<CancelReservationScreen> {
  late RezervacijeProvider _rezervacijeProvider;
  SearchResult<Rezervacije>? result;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    _rezervacijeProvider = RezervacijeProvider();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showCancelDialog(context);
    });
    await Future.delayed(const Duration(milliseconds: 1000));
    var data = await _rezervacijeProvider
        .getCashReservations(search: {'userId': Authorization.id});
    setState(() {
      result = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Poništi rezervaciju'),
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
                        "Ne postoji rezervacija koju možete poništiti!",
                        style: TextStyle(fontSize: 20),
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
                          return KartingCardCancel(
                            rezervacija: rezervacija,
                            onCancel: _initializeData,
                          );
                        },
                      ),
                    ),
            )
          ],
        ));
  }
}

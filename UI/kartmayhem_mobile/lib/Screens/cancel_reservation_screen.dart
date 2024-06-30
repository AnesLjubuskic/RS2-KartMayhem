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
              child: result == null
                  ? const SizedBox()
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

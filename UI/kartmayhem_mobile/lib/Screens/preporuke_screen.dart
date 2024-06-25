import 'package:flutter/material.dart';
import 'package:kartmayhem_mobile/Models/search_result.dart';
import 'package:kartmayhem_mobile/Models/staze.dart';
import 'package:kartmayhem_mobile/Providers/staze_provider.dart';
import 'package:kartmayhem_mobile/Utils/util.dart';
import 'package:kartmayhem_mobile/Widgets/KartingCards/kartingCardButton1.dart';

class PreporukeScreen extends StatefulWidget {
  const PreporukeScreen({super.key});
  static const routeName = "/preporuke";

  @override
  State<PreporukeScreen> createState() => _PreporukeScreenState();
}

class _PreporukeScreenState extends State<PreporukeScreen> {
  late StazeProvider _stazeProvider;
  SearchResult<Staze>? result;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    _stazeProvider = StazeProvider();

    var data = await _stazeProvider
        .getRecommended(search: {'userId': Authorization.id});
    setState(() {
      result = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Preporuke'),
          backgroundColor: const Color(0xFF870000),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Preporuke za korisnika",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
              ),
            ),
            Expanded(
              child: result == null
                  ? SizedBox()
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
                          final staza = result!.result[index];
                          return KartingCardButton1(
                            staze: staza,
                            onFavouriteMarked: _initializeData,
                          );
                        },
                      ),
                    ),
            )
          ],
        ));
  }
}

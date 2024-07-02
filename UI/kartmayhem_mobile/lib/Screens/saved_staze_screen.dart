import 'package:flutter/material.dart';
import 'package:kartmayhem_mobile/Models/search_result.dart';
import 'package:kartmayhem_mobile/Models/staze.dart';
import 'package:kartmayhem_mobile/Providers/staze_provider.dart';
import 'package:kartmayhem_mobile/Utils/util.dart';
import 'package:kartmayhem_mobile/Widgets/KartingCards/kartingCardButton1.dart';

class SavedStazeScreen extends StatefulWidget {
  const SavedStazeScreen({super.key});
  static const routeName = "/saved";

  @override
  State<SavedStazeScreen> createState() => _SavedStazeScreenState();
}

class _SavedStazeScreenState extends State<SavedStazeScreen> {
  late StazeProvider _stazeProvider;
  SearchResult<Staze>? result;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    _stazeProvider = StazeProvider();
    var data =
        await _stazeProvider.getFavourite(search: {'userId': Authorization.id});
    setState(() {
      result = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Spremljeno'),
          backgroundColor: const Color(0xFF870000),
          foregroundColor: Colors.white,
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Spremljene staze",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              ),
            ),
            Expanded(
              child: (result == null || result!.result.isEmpty)
                  ? const Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Text(
                        "Nemate spremljenih staza, označite stazu kao favorit na home ekranu!",
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

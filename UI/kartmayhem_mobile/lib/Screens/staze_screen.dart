import 'package:flutter/material.dart';
import 'package:kartmayhem_mobile/Models/search_result.dart';
import 'package:kartmayhem_mobile/Models/staze.dart';
import 'package:kartmayhem_mobile/Providers/staze_provider.dart';
import 'package:kartmayhem_mobile/Utils/util.dart';
import 'package:kartmayhem_mobile/Widgets/KartingCards/kartingCardButton1.dart';

class StazeScreen extends StatefulWidget {
  const StazeScreen({super.key});
  static const routeName = "/staze";

  @override
  State<StazeScreen> createState() => _StazeScreenState();
}

class _StazeScreenState extends State<StazeScreen> {
  late StazeProvider _stazeProvider;
  SearchResult<Staze>? result;
  final TextEditingController _searchController = new TextEditingController();

  bool amater = false;
  bool pocetnik = false;
  bool pro = false;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    _stazeProvider = StazeProvider();
    List<int> tezineId = [];

    if (pocetnik) tezineId.add(1);
    if (amater) tezineId.add(2);
    if (pro) tezineId.add(3);

    var data = await _stazeProvider.get(search: {
      'nazivStaze': _searchController.text,
      'tezineId': tezineId,
      'userId': Authorization.id
    });
    setState(() {
      result = data;
    });
  }

  void resetSearch() {
    _searchController.text = '';
    pocetnik = false;
    amater = false;
    pro = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          backgroundColor: const Color(0xFF870000),
          foregroundColor: Colors.white,
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            filterWidget(context),
            Expanded(
              child: result == null
                  ? SizedBox()
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return SizedBox(
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

  Widget filterWidget(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  onSubmitted: (value) {
                    _initializeData();
                  },
                  controller: _searchController,
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                      onPressed: () {
                        _initializeData();
                      },
                      icon: const Icon(Icons.search),
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    isDense: true,
                    hintText: 'Pretraga po imenu...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: Text(
                    "Filtriraj staze po težini:",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: pocetnik
                                  ? const Color(0xFF870000)
                                  : const Color(0xFFE8E8E8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {
                            pocetnik = !pocetnik;
                            _initializeData();
                          },
                          child: Text(
                            'Početnik',
                            style: TextStyle(
                                color: pocetnik ? Colors.white : Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: amater
                                  ? const Color(0xFF870000)
                                  : const Color(0xFFE8E8E8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {
                            amater = !amater;
                            _initializeData();
                          },
                          child: Text(
                            'Amater',
                            style: TextStyle(
                                color: amater ? Colors.white : Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: pro
                                  ? const Color(0xFF870000)
                                  : const Color(0xFFE8E8E8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.zero),
                          onPressed: () {
                            pro = !pro;
                            _initializeData();
                          },
                          child: Text(
                            style: TextStyle(
                                color: pro ? Colors.white : Colors.black),
                            'Profesionalac',
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

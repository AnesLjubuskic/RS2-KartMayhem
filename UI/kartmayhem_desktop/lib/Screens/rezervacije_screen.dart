import 'package:flutter/material.dart';
import 'package:kartmayhem_desktop/Models/rezervacije.dart';
import 'package:kartmayhem_desktop/Models/search_result.dart';
import 'package:kartmayhem_desktop/Models/staze.dart';
import 'package:kartmayhem_desktop/Providers/rezervacije_provider.dart';
import 'package:kartmayhem_desktop/Providers/staze_provider.dart';
import 'package:kartmayhem_desktop/Screens/korisnici_screen.dart';
import 'package:kartmayhem_desktop/Screens/nagradi_screen.dart';
import 'package:kartmayhem_desktop/Screens/sidebar_navigation.dart';
import 'package:kartmayhem_desktop/Screens/staze_screen.dart';
import 'package:provider/provider.dart';

class RezervacijeScreen extends StatefulWidget {
  static const String routeName = '/rezervacije';

  const RezervacijeScreen({Key? key}) : super(key: key);

  @override
  State<RezervacijeScreen> createState() => _RezervacijeScreenState();
}

class _RezervacijeScreenState extends State<RezervacijeScreen> {
  late RezervacijeProvider _rezervacijeProvider;
  late StazeProvider _stazeProvider;
  SearchResult<Rezervacije>? result;
  SearchResult<Staze>? resultStaze;
  int? _selectedStazaId;

  @override
  void initState() {
    super.initState();
    _selectedStazaId = -1;
    _initializeData();
  }

  Future<void> _initializeData() async {
    _rezervacijeProvider = RezervacijeProvider();
    _stazeProvider = StazeProvider();
    var dataStaze = await _stazeProvider.get();
    {
      setState(() {
        resultStaze = dataStaze;
      });
    }

    if (_selectedStazaId == -1) {
      var data = await _rezervacijeProvider.get(search: {});
      setState(() {
        result = data;
      });
    } else {
      var data =
          await _rezervacijeProvider.get(search: {'idStaze': _selectedStazaId});
      {
        setState(() {
          result = data;
        });
      }
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _rezervacijeProvider = context.read<RezervacijeProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          SidebarNavigation(
            selectedPage: 'rezervacije',
            onPageSelected: (page) {
              if (page == 'staze') {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder<void>(
                    transitionDuration: Duration.zero,
                    pageBuilder: (_, __, ___) => const StazeScreen(),
                  ),
                );
              } else if (page == 'rezervacije') {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder<void>(
                    transitionDuration: Duration.zero,
                    pageBuilder: (_, __, ___) => const RezervacijeScreen(),
                  ),
                );
              } else if (page == 'korisnici') {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder<void>(
                    transitionDuration: Duration.zero,
                    pageBuilder: (_, __, ___) => const KorisniciScreen(),
                  ),
                );
              } else if (page == 'nagradi') {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder<void>(
                    transitionDuration: Duration.zero,
                    pageBuilder: (_, __, ___) => const NagradiScreen(),
                  ),
                );
              }
            },
          ),
          // Main content area
          Expanded(
            child: Container(
              alignment: Alignment.topCenter,
              padding:
                  const EdgeInsets.symmetric(horizontal: 140.0, vertical: 50.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Rezervacije",
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20), // Adjust spacing as needed
                    Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(
                                  10.0, 10.0, 0.0, 10.0),
                              height: MediaQuery.of(context).size.width * 0.1,
                              alignment: Alignment.topLeft,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                height: 55,
                                child: DropdownButtonFormField<int>(
                                  value: _selectedStazaId,
                                  items: [
                                    DropdownMenuItem<int>(
                                      value: -1,
                                      child: Text('All'),
                                    ),
                                    ...resultStaze?.result.map((staze) {
                                          return DropdownMenuItem<int>(
                                            value: staze.id,
                                            child: Text(staze.nazivStaze!),
                                          );
                                        }).toList() ??
                                        [],
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedStazaId = value;
                                      _initializeData();
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: SizedBox(),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.width * 0.1,
                          padding: const EdgeInsets.all(10.0),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color(0xFFD9D9D9),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Broj rezervacija",
                                  style: TextStyle(
                                    fontSize: 23,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  result?.count.toString() ?? 'Učitavanje...',
                                  style: const TextStyle(
                                      fontSize: 35,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.16,
                          height: MediaQuery.of(context).size.width * 0.1,
                          padding: const EdgeInsets.all(10.0),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color(0xFFD9D9D9),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Ukupna zarada",
                                  style: TextStyle(
                                    fontSize: 23,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  result?.count.toString() ?? 'Učitavanje...',
                                  style: const TextStyle(
                                      fontSize: 35,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50), // Adjust spacing as needed
                    _buildDataListView(), // Adding the table here
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataListView() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0), // Border radius of 10
        border: Border.all(
            color: const Color(0xFFD7D2DC),
            width: 1.0), // Border color and width
      ),
      child: Center(
        child: SizedBox(
          width: double.infinity, // Expand to maximum width
          child: DataTable(
            columns: const [
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Naziv staze',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Korisnik',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Cijena',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
            rows: result?.result.map((Rezervacije rezervacije) {
                  return DataRow(cells: [
                    DataCell(Text('${rezervacije.imeStaze}')),
                    DataCell(Text('${rezervacije.korisnik!.punoIme}')),
                    DataCell(Text('${rezervacije.cijenaRezervacije}KM')),
                  ]);
                }).toList() ??
                [],
          ),
        ),
      ),
    );
  }
}

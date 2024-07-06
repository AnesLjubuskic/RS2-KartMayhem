import 'package:flutter/material.dart';
import 'package:kartmayhem_desktop/Models/search_result.dart';
import 'package:kartmayhem_desktop/Models/staze.dart';
import 'package:kartmayhem_desktop/Providers/staze_provider.dart';
import 'package:kartmayhem_desktop/Screens/feedback_screen.dart';
import 'package:kartmayhem_desktop/Screens/korisnici_screen.dart';
import 'package:kartmayhem_desktop/Screens/nagradi_screen.dart';
import 'package:kartmayhem_desktop/Screens/rezervacije_screen.dart';
import 'package:kartmayhem_desktop/Screens/sidebar_navigation.dart';
import 'package:kartmayhem_desktop/Screens/staze_screen.dart';

class IzvjestajScreen extends StatefulWidget {
  static const String routeName = '/izvjestaj';

  const IzvjestajScreen({Key? key}) : super(key: key);

  @override
  State<IzvjestajScreen> createState() => _IzvjestajScreenState();
}

class _IzvjestajScreenState extends State<IzvjestajScreen> {
  String _selectedYear = '2024';
  String _selectedStaza = 'Sve';
  int _selectedStazaInt = -1;
  late StazeProvider _stazeProvider;
  SearchResult<Staze>? result;

  final List<String> _years = ['2024', '2025', '2026'];

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    _stazeProvider = StazeProvider();
    var data = await _stazeProvider.get();
    setState(() {
      result = data;
    });
  }

  void resetSearch() {
    _selectedYear = '2024';
    _selectedStaza = 'Sve';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          SidebarNavigation(
            selectedPage: 'izvjestaj',
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
              } else if (page == 'feedback') {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder<void>(
                    transitionDuration: Duration.zero,
                    pageBuilder: (_, __, ___) => const FeedbackScreen(),
                  ),
                );
              } else if (page == 'izvjestaj') {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder<void>(
                    transitionDuration: Duration.zero,
                    pageBuilder: (_, __, ___) => const IzvjestajScreen(),
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
                        "Izvještaj",
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        godine(),
                        staze(),
                      ],
                    ),
                    const SizedBox(height: 50),
                    Container(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: (_selectedStaza == "Sve")
                            ? Text(
                                "Statistika za sve staze u $_selectedYear godini:",
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )
                            : Text(
                                "Statistika za ${result!.result.where((x) => x.id.toString() == _selectedStaza).first.nazivStaze} u $_selectedYear godini:",
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Broj rezervacija: ${_selectedYear}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Ukupna zarada: ${_selectedYear}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Ostatala statistika",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Ukupan broj korisnika aplikacije: ${_selectedYear}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Ukupna zarada kroz aplikaciju: ${_selectedYear}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                    ),
                    pdfButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Center pdfButton() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF870000),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: () {},
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Skinite PDF statistike',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Column staze() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Staza:',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 40,
          width: 180,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: Colors.grey),
          ),
          child: DropdownButtonFormField<int>(
            value: _selectedStaza == 'Sve' ? -1 : int.tryParse(_selectedStaza),
            items: [
              const DropdownMenuItem<int>(
                value: -1,
                child: Text('Sve'),
              ),
              if (result != null && result!.result.isNotEmpty)
                ...result!.result.map((staza) {
                  return DropdownMenuItem<int>(
                    value: staza.id,
                    child: Text(staza.nazivStaze!),
                  );
                }).toList(),
            ],
            onChanged: (value) {
              setState(() {
                _selectedStazaInt = value!;
                _selectedStaza = value == -1 ? 'Sve' : value.toString();
              });
            },
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 10, right: 10, left: 10),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
            validator: (value) {
              if (value == null) {
                return 'Ovo polje je obavezno';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Column godine() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Godina:',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 40,
          width: 180,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: Colors.grey),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedYear,
              items: _years.map((String year) {
                return DropdownMenuItem<String>(
                  value: year,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(year),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedYear = newValue!;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}

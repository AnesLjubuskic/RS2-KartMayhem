import 'package:flutter/material.dart';
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
  late StazeProvider _stazaProvider;

  final List<String> _years = ['2024', '2025', '2026'];

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
                                "Statistika za $_selectedStaza u $_selectedYear godini:",
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
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
                        "Broj korisnika aplikacije: ${_selectedYear}",
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

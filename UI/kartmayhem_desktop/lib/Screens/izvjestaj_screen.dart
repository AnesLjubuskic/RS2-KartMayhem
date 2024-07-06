import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kartmayhem_desktop/Models/izvjestaji.dart';
import 'package:kartmayhem_desktop/Models/search_result.dart';
import 'package:kartmayhem_desktop/Models/staze.dart';
import 'package:kartmayhem_desktop/Providers/izvjestaji_provider.dart';
import 'package:kartmayhem_desktop/Providers/staze_provider.dart';
import 'package:kartmayhem_desktop/Screens/feedback_screen.dart';
import 'package:kartmayhem_desktop/Screens/korisnici_screen.dart';
import 'package:kartmayhem_desktop/Screens/nagradi_screen.dart';
import 'package:kartmayhem_desktop/Screens/rezervacije_screen.dart';
import 'package:kartmayhem_desktop/Screens/sidebar_navigation.dart';
import 'package:kartmayhem_desktop/Screens/staze_screen.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

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
  late IzvjestajiProvider _izvjestajProvider;
  SearchResult<Staze>? result;
  Izvjestaji? izvjestaj;

  final List<String> _years = ['2024', '2025', '2026'];

  @override
  void initState() {
    super.initState();
    _initializeData();
    _initializeStatistic();
  }

  Future<void> _initializeData() async {
    _stazeProvider = StazeProvider();
    var data = await _stazeProvider.get();
    setState(() {
      result = data;
    });
  }

  Future<void> _initializeStatistic() async {
    _izvjestajProvider = IzvjestajiProvider();
    if (_selectedStazaInt == -1) {
      var data = await _izvjestajProvider.getIzvjestaj(search: {
        'godina': _selectedYear,
      });
      setState(() {
        izvjestaj = data;
      });
    } else {
      var data = await _izvjestajProvider.getIzvjestaj(
          search: {'godina': _selectedYear, 'stazaId': _selectedStazaInt});
      setState(() {
        izvjestaj = data;
      });
    }
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
                    Align(
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
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Broj rezervacija: ${izvjestaj?.brojRezervacijeStaze}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Ukupna zarada: ${izvjestaj?.ukupnaZaradaStaze}KM",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Ostala statistika",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Ukupan broj korisnika aplikacije: ${izvjestaj?.ukupanBrojKorisnikaAplikacije}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Ukupna zarada kroz aplikaciju: ${izvjestaj?.ukupnaZaradaAplikacije}KM",
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

  Future<void> _pdfGenerator() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              (_selectedStaza == "Sve")
                  ? pw.Text(
                      "Statistika za sve staze u $_selectedYear godini:",
                      style: const pw.TextStyle(fontSize: 20),
                    )
                  : pw.Text(
                      "Statistika za ${result!.result.where((x) => x.id.toString() == _selectedStaza).first.nazivStaze} u $_selectedYear godini:",
                      style: const pw.TextStyle(fontSize: 20),
                    ),
              pw.SizedBox(height: 20),
              pw.Text('Broj rezervacija: ${izvjestaj?.brojRezervacijeStaze}'),
              pw.Text('Ukupna zarada: ${izvjestaj?.ukupnaZaradaStaze}KM'),
              pw.SizedBox(height: 20),
              pw.Text('Ostatala statistika',
                  style: const pw.TextStyle(fontSize: 20)),
              pw.SizedBox(height: 20),
              pw.Text(
                  'Ukupan broj korisnika aplikacije: ${izvjestaj?.ukupanBrojKorisnikaAplikacije}'),
              pw.Text(
                  'Ukupna zarada kroz aplikaciju: ${izvjestaj?.ukupnaZaradaAplikacije}KM'),
            ],
          );
        },
      ),
    );
    final directory = await getApplicationDocumentsDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final path = "${directory.path}/izvjestaj_$timestamp.pdf";
    final File file = File(path);
    await file.writeAsBytes(await pdf.save());

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Izvještaj spremljen na lokaciji $path')),
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
          onPressed: () async {
            await _pdfGenerator();
          },
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
                _initializeStatistic();
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
                  _initializeStatistic();
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}

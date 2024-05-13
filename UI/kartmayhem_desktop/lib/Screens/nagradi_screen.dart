import 'package:flutter/material.dart';
import 'package:kartmayhem_desktop/Models/topuser.dart';
import 'package:kartmayhem_desktop/Providers/korisnik_provider.dart';
import 'package:kartmayhem_desktop/Screens/korisnici_screen.dart';
import 'package:kartmayhem_desktop/Screens/sidebar_navigation.dart';
import 'package:kartmayhem_desktop/Screens/rezervacije_screen.dart';
import 'package:kartmayhem_desktop/Screens/staze_screen.dart';
import 'package:provider/provider.dart';

class NagradiScreen extends StatefulWidget {
  static const String routeName = '/nagradi';

  const NagradiScreen({Key? key}) : super(key: key);

  @override
  State<NagradiScreen> createState() => _NagradiScreenState();
}

class _NagradiScreenState extends State<NagradiScreen> {
  late KorisnikProvider _korisnikProvider;
  List<TopUser>? result;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    _korisnikProvider = KorisnikProvider(); // Initialize your provider
    var data = await _korisnikProvider
        .gettopkorisnike(); // Call your method to get data
    setState(() {
      result = data;
    });
    print("GLAVNI SCREEN" + result!.toString());
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _korisnikProvider = context.read<KorisnikProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          SidebarNavigation(
            selectedPage: 'nagradi',
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
                        "Nagradi korisnika",
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30), // Adjust spacing as needed
                    const Center(
                      child: Text(
                        'Sistem "Nagradi korisnika" sluzi kako bi nase lojalne korisnike nagradili popustom od 50% na sljedecu rezervaciju. Broj ispunjenih rezervacija odnosi se na trenutnu godinu.',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
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
                    'Naziv korisnika',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Broj ispunjenih rezervacija',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Akcija',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
            rows: result?.map((TopUser user) {
                  return DataRow(cells: [
                    DataCell(
                        Text('${user.punoIme}')), // Combine ime and prezime
                    DataCell(Text('${user.brojRezervacija}')), // Display email
                    DataCell(
                      Container(
                        width: double.infinity,
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.1),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (user.isNagrada != null) {
                              if (user.isNagrada!) {
                                var success = await _korisnikProvider
                                    .cancelUserAward(user.id!.toInt());
                                if (success) {
                                  setState(() {
                                    user.isNagrada = false;
                                  });
                                }
                              } else {
                                var success = await _korisnikProvider
                                    .awardUser(user.id!.toInt());
                                if (success) {
                                  setState(() {
                                    user.isNagrada = true;
                                  });
                                }
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: user.isNagrada ?? false
                                  ? const Color(0xFF870000)
                                  : const Color(0xFFE8E8E8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: Text(
                            user.isNagrada ?? false ? 'Otkazi' : 'Nagradi',
                            style: TextStyle(
                                color: user.isNagrada ?? false
                                    ? Colors.white
                                    : Colors
                                        .black), // Text color based on isNagrada
                          ),
                        ),
                      ),
                    ),
                  ]);
                }).toList() ??
                [],
          ),
        ),
      ),
    );
  }
}

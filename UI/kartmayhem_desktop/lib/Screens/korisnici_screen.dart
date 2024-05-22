import 'package:flutter/material.dart';
import 'package:kartmayhem_desktop/Helpers/error_dialog.dart';
import 'package:kartmayhem_desktop/Models/korisnik.dart';
import 'package:kartmayhem_desktop/Models/search_result.dart';
import 'package:kartmayhem_desktop/Providers/korisnik_provider.dart';
import 'package:kartmayhem_desktop/Screens/nagradi_screen.dart';
import 'package:kartmayhem_desktop/Screens/sidebar_navigation.dart';
import 'package:kartmayhem_desktop/Screens/rezervacije_screen.dart';
import 'package:kartmayhem_desktop/Screens/staze_screen.dart';
import 'package:kartmayhem_desktop/Widgets/Modals/Korisnici/edit_korisnici.dart';
import 'package:provider/provider.dart';

class KorisniciScreen extends StatefulWidget {
  static const String routeName = '/korisnici';

  const KorisniciScreen({Key? key}) : super(key: key);

  @override
  State<KorisniciScreen> createState() => _KorisniciScreenState();
}

class _KorisniciScreenState extends State<KorisniciScreen> {
  late KorisnikProvider _korisnikProvider;
  SearchResult<Korisnik>? result;
  TextEditingController _searchController = new TextEditingController();
  int currentPage = 1;
  int pageSize = 5;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    _korisnikProvider = KorisnikProvider();
    var data = await _korisnikProvider.get(search: {
      'ime': _searchController.text,
      'page': currentPage - 1,
      'pageSize': pageSize
    });
    setState(() {
      result = data;
    });
  }

  void handleEdit(
    int id,
    String? ime,
    String? prezime,
    String? email,
  ) async {
    try {
      await _korisnikProvider.editUser(id, {
        'ime': ime,
        'prezime': prezime,
        'email': email,
      });
      if (context.mounted) {
        Navigator.pop(context);
        _initializeData();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).primaryColor,
            content: const Text('Uspješno ste editovali korisnika!'),
          ),
        );
      }
    } on Exception catch (e) {
      String errorMessage = e.toString().replaceFirst('Exception: ', '');
      showErrorDialog(context, errorMessage);
      // ignore: use_build_context_synchronously
    }
  }

  void openEditModal(Korisnik korisnik) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditKorisniciModal(
          korisnik: korisnik,
          handleEdit: handleEdit,
        );
      },
    );
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
            selectedPage: 'korisnici',
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
                        "Korisnici",
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
                              padding: const EdgeInsets.all(10.0),
                              height: MediaQuery.of(context).size.width * 0.1,
                              alignment: Alignment.topLeft,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                height: 50,
                                child: TextField(
                                  onSubmitted: (value) {
                                    _resetPage();
                                    _initializeData();
                                  },
                                  controller: _searchController,
                                  decoration: InputDecoration(
                                    prefixIcon: IconButton(
                                      onPressed: () {
                                        _resetPage();
                                        _initializeData();
                                      },
                                      icon: Icon(Icons.search),
                                    ),
                                    hintText: 'Pretraga po imenu...',
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
                          width: MediaQuery.of(context).size.width * 0.2,
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
                                  "Broj korisnika",
                                  style: TextStyle(
                                    fontSize: 25,
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
                    _buildDataListView(),
                    _buildPaginationControls()
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
                    'Email korisnika',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Uredi',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Izbrisi',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
            rows: result?.result.map((Korisnik user) {
                  return DataRow(cells: [
                    DataCell(
                        Text('${user.punoIme}')), // Combine ime and prezime
                    DataCell(Text('${user.email}')), // Display email
                    DataCell(IconButton(
                      icon: const Icon(Icons.edit, color: Colors.black),
                      onPressed: () {
                        openEditModal(user);
                      },
                    )),
                    DataCell(IconButton(
                      icon:
                          const Icon(Icons.dangerous, color: Color(0xFF870000)),
                      onPressed: () {
                        openDeleteModal(user.id!);
                      },
                    )),
                  ]);
                }).toList() ??
                [],
          ),
        ),
      ),
    );
  }

  void openDeleteModal(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Obriši'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Da li ste sigurni da želite da izbrišete korisnika?'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Poništi'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await _korisnikProvider.deactivateUser(id);
                  if (context.mounted) {
                    Navigator.pop(context);
                    _initializeData();
                  }
                } on Exception catch (e) {
                  String errorMessage =
                      e.toString().replaceFirst('Exception: ', '');
                  showErrorDialog(context, errorMessage);
                  // ignore: use_build_context_synchronously
                }
              },
              child: const Text(
                'Obriši',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPaginationControls() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_left),
            onPressed: _canGoToPreviousPage() ? _previousPage : null,
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF870000),
            ),
            child: Text(
              '$currentPage',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
          IconButton(
            icon: Icon(Icons.arrow_right),
            onPressed: _canGoToNextPage() ? _nextPage : null,
          ),
        ],
      ),
    );
  }

  void _previousPage() {
    setState(() {
      currentPage--;
      _initializeData();
    });
  }

  bool _canGoToPreviousPage() {
    if (currentPage > 1) {
      return true;
    }
    return false;
  }

  bool _canGoToNextPage() {
    if (result != null) {
      int totalResults = 0;

      if (_searchController.text.isEmpty) {
        totalResults = result!.totalCount;
      } else {
        totalResults = result!.count;
      }

      int totalPages = (totalResults / pageSize).ceil();
      return currentPage < totalPages;
    }
    return false;
  }

  void _nextPage() {
    setState(() {
      currentPage++;
      _initializeData();
    });
  }

  void _resetPage() {
    setState(() {
      currentPage = 1;
      _initializeData();
    });
  }
}

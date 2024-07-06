import 'package:flutter/material.dart';
import 'package:kartmayhem_desktop/Helpers/error_dialog.dart';
import 'package:kartmayhem_desktop/Models/search_result.dart';
import 'package:kartmayhem_desktop/Models/staze.dart';
import 'package:kartmayhem_desktop/Providers/staze_provider.dart';
import 'package:kartmayhem_desktop/Screens/feedback_screen.dart';
import 'package:kartmayhem_desktop/Screens/izvjestaj_screen.dart';
import 'package:kartmayhem_desktop/Screens/korisnici_screen.dart';
import 'package:kartmayhem_desktop/Screens/nagradi_screen.dart';
import 'package:kartmayhem_desktop/Screens/rezervacije_screen.dart';
import 'package:kartmayhem_desktop/Screens/sidebar_navigation.dart';
import 'package:kartmayhem_desktop/Widgets/Modals/Staze/detalji_stazu.dart';
import 'package:kartmayhem_desktop/Widgets/Modals/Staze/dodaj_stazu.dart';
import 'package:kartmayhem_desktop/Widgets/Modals/Staze/edit_stazu.dart';

class StazeScreen extends StatefulWidget {
  static const String routeName = '/staze';

  const StazeScreen({Key? key}) : super(key: key);

  @override
  State<StazeScreen> createState() => _StazeScreenState();
}

class _StazeScreenState extends State<StazeScreen> {
  late StazeProvider _stazeProvider;
  SearchResult<Staze>? result;
  TextEditingController _searchController = new TextEditingController();
  bool amater = false;
  bool pocetnik = false;
  bool pro = false;

  int currentPage = 1;
  int pageSize = 4;

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
      'page': currentPage - 1,
      'pageSize': pageSize
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

  void handleAdd(
      String? nazivStaze,
      String? opisStaze,
      int? cijenaPoOsobi,
      double? duzinaStaze,
      int? brojKrugova,
      int? maxBrojOsoba,
      int? tezinaId,
      int? gradoviId) async {
    try {
      await _stazeProvider.insert({
        'nazivStaze': nazivStaze,
        'opisStaze': opisStaze,
        'cijenaPoOsobi': cijenaPoOsobi,
        'duzinaStaze': duzinaStaze,
        'brojKrugova': brojKrugova,
        'maxBrojOsoba': maxBrojOsoba,
        'tezinaId': tezinaId,
        'gradoviId': gradoviId
      });

      if (context.mounted) {
        Navigator.pop(context);
        resetSearch();
        _initializeData();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Color(0xFF870000),
            content: Text('Dodali ste novu stazu!'),
          ),
        );
      }
    } on Exception catch (e) {
      String errorMessage = e.toString().replaceFirst('Exception: ', '');
      // ignore: use_build_context_synchronously
      showErrorDialog(context, errorMessage);
    }
  }

  void handleEdit(
      int id,
      String? nazivStaze,
      String? opisStaze,
      int? cijenaPoOsobi,
      double? duzinaStaze,
      int? brojKrugova,
      int? maxBrojOsoba,
      int? tezinaId,
      int? gradoviId) async {
    try {
      await _stazeProvider.update(id, {
        'nazivStaze': nazivStaze,
        'opisStaze': opisStaze,
        'cijenaPoOsobi': cijenaPoOsobi,
        'duzinaStaze': duzinaStaze,
        'brojKrugova': brojKrugova,
        'maxBrojOsoba': maxBrojOsoba,
        'tezinaId': tezinaId,
        'gradoviId': gradoviId
      });
      if (context.mounted) {
        Navigator.pop(context);
        _initializeData();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Color(0xFF870000),
            content: const Text('Uspješno ste editovali stazu!'),
          ),
        );
      }
    } on Exception catch (e) {
      String errorMessage = e.toString().replaceFirst('Exception: ', '');
      // ignore: use_build_context_synchronously
      showErrorDialog(context, errorMessage);
    }
  }

  void openEditModal(Staze staze) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditStazeModal(
          staze: staze,
          handleEdit: handleEdit,
        );
      },
    );
  }

  void openDetailModal(Staze staze) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DetailStazeModal(
          staze: staze,
        );
      },
    );
  }

  void openAddModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddStazeModal(handleAdd: handleAdd);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          SidebarNavigation(
            selectedPage: 'staze',
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
                        "Staze",
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              height: MediaQuery.of(context).size.width * 0.05,
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
                            Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: const Text(
                                "Filtriraj staze po težini:",
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              height: MediaQuery.of(context).size.width * 0.05,
                              alignment: Alignment.topLeft,
                              child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: pocetnik
                                                ? const Color(0xFF870000)
                                                : const Color(0xFFE8E8E8),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                        onPressed: () {
                                          pocetnik = !pocetnik;
                                          _resetPage();
                                          _initializeData();
                                        },
                                        child: Text(
                                          'Početnik',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: pocetnik
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: amater
                                                ? const Color(0xFF870000)
                                                : const Color(0xFFE8E8E8),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                        onPressed: () {
                                          amater = !amater;
                                          _resetPage();
                                          _initializeData();
                                        },
                                        child: Text(
                                          'Amater',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: amater
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: pro
                                                ? const Color(0xFF870000)
                                                : const Color(0xFFE8E8E8),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                        onPressed: () {
                                          pro = !pro;
                                          _resetPage();
                                          _initializeData();
                                        },
                                        child: Text(
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: pro
                                                  ? Colors.white
                                                  : Colors.black),
                                          'Profesionalac',
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        ),
                        Expanded(
                          child: SizedBox(),
                        ),
                        //Dodaj Stazu
                        Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.width * 0.05,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.15,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF870000),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  onPressed: () {
                                    openAddModal();
                                  },
                                  child: const Text(
                                    'Dodaj stazu',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 100,
                            )
                          ],
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
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: const Color(0xFFD7D2DC), width: 1.0),
      ),
      child: Center(
        child: SizedBox(
          width: double.infinity,
          child: DataTable(
            columns: const [
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Naziv staze',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Težina',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Dužina kruga',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Cijena po osobi',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Detalji',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Uredi',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Izbriši',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ),
            ],
            rows: result?.result.map((Staze staze) {
                  return DataRow(cells: [
                    DataCell(Text('${staze.nazivStaze}')),
                    DataCell(Text('${staze.tezina?.naziv}')),
                    DataCell(Text('${staze.duzinaStaze}')),
                    DataCell(Text('${staze.cijenaPoOsobi}')),
                    DataCell(IconButton(
                      icon: const Icon(Icons.info, color: Colors.black),
                      onPressed: () {
                        openDetailModal(staze);
                      },
                    )),
                    DataCell(IconButton(
                      icon: const Icon(Icons.edit, color: Colors.black),
                      onPressed: () {
                        openEditModal(staze);
                      },
                    )),
                    DataCell(IconButton(
                      icon:
                          const Icon(Icons.dangerous, color: Color(0xFF870000)),
                      onPressed: () {
                        openDeleteModal(staze.id!);
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
              Text(
                  'Brisanjem staze poništavate sve rezervacije vezane za nju.'),
              Text('Da li ste sigurni da želite da izbrišete ovu stazu?'),
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
                  await _stazeProvider.deactivateTrack(id);
                  if (context.mounted) {
                    Navigator.pop(context);
                    _initializeData();
                  }
                } catch (e) {
                  if (context.mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('Ne možete obrisati ovu stazu!'),
                      ),
                    );
                  }
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

      if (_searchController.text.isEmpty && !pro && !amater && !pocetnik) {
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kartmayhem_desktop/Models/search_result.dart';
import 'package:kartmayhem_desktop/Providers/feedback_provider.dart';
import 'package:kartmayhem_desktop/Screens/izvjestaj_screen.dart';
import 'package:kartmayhem_desktop/Screens/korisnici_screen.dart';
import 'package:kartmayhem_desktop/Screens/nagradi_screen.dart';
import 'package:kartmayhem_desktop/Screens/rezervacije_screen.dart';
import 'package:kartmayhem_desktop/Screens/sidebar_navigation.dart';
import 'package:kartmayhem_desktop/Screens/staze_screen.dart';
import 'package:kartmayhem_desktop/Models/feedback.dart' as feedbacktree;

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});
  static const String routeName = '/feedback';

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  late FeedbackProvider _feedbackProvider;
  SearchResult<feedbacktree.Feedback>? result;
  int currentPage = 1;
  int pageSize = 5;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    _feedbackProvider = FeedbackProvider();
    var data = await _feedbackProvider
        .get(search: {'page': currentPage - 1, 'pageSize': pageSize});
    setState(() {
      result = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          SidebarNavigation(
            selectedPage: 'feedback',
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
                        "Feedback",
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (result == null)
                      Center(child: CircularProgressIndicator())
                    else
                      Expanded(
                        child: ListView.builder(
                          itemCount: result!.result.length,
                          itemBuilder: (context, index) {
                            String komentar = result!.result[index].komentar!;
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Text(
                                komentar,
                                style: const TextStyle(fontSize: 16.0),
                              ),
                            );
                          },
                        ),
                      ),
                    // Pagination controls
                    _buildPaginationControls(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaginationControls() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_left),
            onPressed: _canGoToPreviousPage() ? _previousPage : null,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF870000),
            ),
            child: Text(
              '$currentPage',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_right),
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
    return currentPage > 1;
  }

  bool _canGoToNextPage() {
    if (result != null) {
      int totalResults = result!.totalCount;

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
}

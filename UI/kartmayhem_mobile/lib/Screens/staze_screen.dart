import 'package:flutter/material.dart';

class StazeScreen extends StatefulWidget {
  const StazeScreen({super.key});
  static const routeName = "/staze";

  @override
  State<StazeScreen> createState() => _StazeScreenState();
}

class _StazeScreenState extends State<StazeScreen> {
  bool amater = false;
  bool pocetnik = false;
  bool pro = false;
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: TextField(
          onSubmitted: (value) {
            //_resetPage();
            //_initializeData();
          },
          //controller: _searchController,
          decoration: InputDecoration(
            prefixIcon: IconButton(
              onPressed: () {
                //_resetPage();
                //_initializeData();
              },
              icon: Icon(Icons.search),
            ),
            contentPadding: EdgeInsets.fromLTRB(0, 8, 0, 8),
            isDense: true,
            hintText: 'Pretraga po imenu...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ),
    );
  }
}

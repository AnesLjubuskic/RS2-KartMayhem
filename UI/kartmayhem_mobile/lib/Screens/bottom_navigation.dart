import 'package:flutter/material.dart';
import 'package:kartmayhem_mobile/Screens/profile_screen.dart';
import 'package:kartmayhem_mobile/Screens/saved_staze_screen.dart';
import 'package:kartmayhem_mobile/Screens/staze_screen.dart';

class BottomNavigation extends StatefulWidget {
  static const routeName = '/home';
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final List<Widget> _screens = [
    const StazeScreen(),
    const SavedStazeScreen(),
    const ProfileScreen(),
  ];

  final List<IconData> _icons = const [
    Icons.home,
    Icons.favorite,
    Icons.account_circle
  ];

  final List<String> _labels = const [
    'Home',
    'Spremljeno',
    'Profil',
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: List.generate(_icons.length, (index) {
          return BottomNavigationBarItem(
            icon: Icon(_icons[index], size: 30),
            label: _labels[index],
          );
        }),
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        backgroundColor: const Color(0xFF870000),
      ),
    );
  }
}

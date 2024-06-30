import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kartmayhem_desktop/Screens/korisnici_screen.dart';
import 'package:kartmayhem_desktop/Screens/nagradi_screen.dart';
import 'package:kartmayhem_desktop/Screens/rezervacije_screen.dart';
import 'package:kartmayhem_desktop/Screens/sidebar_navigation.dart';
import 'package:kartmayhem_desktop/Screens/staze_screen.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});
  static const String routeName = '/feedback';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [
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
            }
          },
        ),
        // Main content area  }
      ]),
    );
  }
}

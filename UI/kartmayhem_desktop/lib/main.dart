import 'package:flutter/material.dart';
import 'package:kartmayhem_desktop/Providers/auth_provider.dart';
import 'package:kartmayhem_desktop/Providers/feedback_provider.dart';
import 'package:kartmayhem_desktop/Providers/korisnik_provider.dart';
import 'package:kartmayhem_desktop/Providers/rezervacije_provider.dart';
import 'package:kartmayhem_desktop/Providers/staze_provider.dart';
import 'package:kartmayhem_desktop/Screens/feedback_screen.dart';
import 'package:kartmayhem_desktop/Screens/korisnici_screen.dart';
import 'package:kartmayhem_desktop/Screens/login_screen.dart';
import 'package:kartmayhem_desktop/Screens/nagradi_screen.dart';
import 'package:kartmayhem_desktop/Screens/rezervacije_screen.dart';
import 'package:kartmayhem_desktop/Screens/staze_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => KorisnikProvider()),
        ChangeNotifierProvider(create: (_) => StazeProvider()),
        ChangeNotifierProvider(create: (_) => RezervacijeProvider()),
        ChangeNotifierProvider(create: (_) => FeedbackProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kart Mayhem',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: LoginScreen.routeName,
      routes: {
        '/': (context) => const LoginScreen(),
        StazeScreen.routeName: (context) => const StazeScreen(),
        RezervacijeScreen.routeName: (context) => const RezervacijeScreen(),
        KorisniciScreen.routeName: (context) => const KorisniciScreen(),
        NagradiScreen.routeName: (context) => const NagradiScreen(),
        FeedbackScreen.routeName: (context) => const FeedbackScreen()
      },
    );
  }
}

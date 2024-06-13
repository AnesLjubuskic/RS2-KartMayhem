import 'package:flutter/material.dart';
import 'package:kartmayhem_mobile/Providers/auth_provider.dart';
import 'package:kartmayhem_mobile/Providers/korisnik_provider.dart';
import 'package:kartmayhem_mobile/Providers/reservation_provider.dart';
import 'package:kartmayhem_mobile/Providers/staze_provider.dart';
import 'package:kartmayhem_mobile/Screens/bottom_navigation.dart';
import 'package:kartmayhem_mobile/Screens/login_screen.dart';
import 'package:kartmayhem_mobile/Screens/register_screen.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => KorisnikProvider()),
        ChangeNotifierProvider(create: (_) => StazeProvider()),
        ChangeNotifierProvider(create: (_) => RezervacijeProvider())
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
      theme: ThemeData(primarySwatch: Colors.red, useMaterial3: true),
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
        BottomNavigation.routeName: ((context) => const BottomNavigation()),
        //RezervacijeScreen.routeName: (context) => const RezervacijeScreen(),
        //KorisniciScreen.routeName: (context) => const KorisniciScreen(),
        //NagradiScreen.routeName: (context) => const NagradiScreen()
      },
    );
  }
}

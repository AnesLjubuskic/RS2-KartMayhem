import 'package:flutter/material.dart';
import 'package:kartmayhem_mobile/Providers/auth_provider.dart';
import 'package:kartmayhem_mobile/Providers/korisnik_provider.dart';
import 'package:kartmayhem_mobile/Providers/kupovina_provider.dart';
import 'package:kartmayhem_mobile/Providers/reservation_provider.dart';
import 'package:kartmayhem_mobile/Providers/staze_provider.dart';
import 'package:kartmayhem_mobile/Screens/bottom_navigation.dart';
import 'package:kartmayhem_mobile/Screens/login_screen.dart';
import 'package:kartmayhem_mobile/Screens/register_screen.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51PQyD6AODczbXypSFFepFm5izKRGH0LsQaOR8EGeYiBoWQYGk1XOHLkjLm74JI8SrBgPeTQM654wRIHGxGnrRyr700ISmx6rWm";
  Stripe.merchantIdentifier = 'any string works';
  Stripe.urlScheme = "flutterstripe";
  await Stripe.instance.applySettings();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => KorisnikProvider()),
        ChangeNotifierProvider(create: (_) => StazeProvider()),
        ChangeNotifierProvider(create: (_) => RezervacijeProvider()),
        ChangeNotifierProvider(create: (_) => KupovinaProvider())
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
      },
    );
  }
}

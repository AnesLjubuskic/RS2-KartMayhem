import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartmayhem_mobile/Models/korisnik.dart';
import 'package:kartmayhem_mobile/Providers/auth_provider.dart';
import 'package:kartmayhem_mobile/Providers/korisnik_provider.dart';
import 'package:kartmayhem_mobile/Screens/cancel_reservation_screen.dart';
import 'package:kartmayhem_mobile/Screens/editprofile_screen.dart';
import 'package:kartmayhem_mobile/Screens/feedback_screen.dart';
import 'package:kartmayhem_mobile/Screens/history_screen.dart';
import 'package:kartmayhem_mobile/Screens/login_screen.dart';
import 'package:kartmayhem_mobile/Screens/preporuke_screen.dart';
import 'package:kartmayhem_mobile/Utils/util.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const routeName = "/profile";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late KorisnikProvider _korisnikProvider;
  late AuthProvider _authProvider;

  Korisnik? korisnik;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    _korisnikProvider = KorisnikProvider();
    var data = await _korisnikProvider.getById(Authorization.id!);
    setState(() {
      korisnik = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profil'),
          backgroundColor: const Color(0xFF870000),
          foregroundColor: Colors.white,
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Center(
                child: ClipOval(
                  child: korisnik?.slika != null
                      ? imageFromBase64String(
                          korisnik!.slika!,
                          fit: BoxFit.cover,
                          height: 150,
                          width: 150,
                        )
                      : Container(
                          color: Colors.grey,
                          height: 150,
                          width: 150,
                        ),
                ),
              ),
              editButton(),
              const Padding(
                padding: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
                child: Text(
                  "Naziv",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8E8E8),
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            bottom: 10, right: 8, left: 8),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: korisnik?.punoIme),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
                child: Text(
                  "Email",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8E8E8),
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            bottom: 10, right: 8, left: 8),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: korisnik?.email),
                  ),
                ),
              ),
              ponistiRezervaciju(),
              preporuceneStaze(),
              historija(),
              feedback(),
              logoutButton(),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ));
  }

  Center ponistiRezervaciju() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 0.0),
        child: SizedBox(
          width: 280,
          height: 45,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CancelReservationScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF870000),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              "Poništi rezervaciju",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }

  Center preporuceneStaze() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 0.0),
        child: SizedBox(
          width: 280,
          height: 45,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PreporukeScreen(),
                ),
              ).then((value) => _initializeData());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF870000),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              "Preporučene staze",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }

  Center historija() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 0.0),
        child: SizedBox(
          width: 280,
          height: 45,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HistoryScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF870000),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              "Historija",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }

  Center feedback() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 0.0),
        child: SizedBox(
          width: 280,
          height: 45,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FeedbackScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF870000),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              "Feedback",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }

  Center logoutButton() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 0.0),
        child: SizedBox(
          width: 280,
          height: 45,
          child: ElevatedButton(
            onPressed: () {
              _authProvider = AuthProvider();
              _authProvider.logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF870000),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              "Logout",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }

  Center editButton() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 0.0),
        child: SizedBox(
          width: 150,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfileScreen(
                    korisnik: korisnik!,
                  ),
                ),
              ).then((value) => _initializeData());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF870000),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              "Edit",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}

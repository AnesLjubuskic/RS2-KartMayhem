import 'package:flutter/material.dart';
import 'package:kartmayhem_desktop/Screens/staze_screen.dart';
import 'package:kartmayhem_desktop/Utils/util.dart';
import 'package:provider/provider.dart';

import '../Providers/auth_provider.dart';

RegExp regexLozinka = RegExp(r'^.{6,}$');
RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

class LoginScreen extends StatefulWidget {
  static const routeName = "/login";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  AuthProvider? _authProvider;
  String? email;
  String? password;
  bool loginFailed = false;

  @override
  void initState() {
    super.initState();
    _authProvider = context.read<AuthProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kart Mayhem'),
        backgroundColor: const Color(0xFF870000),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SizedBox(
            width: 500,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Kart Mayhem',
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF870000)),
                  ),
                  const SizedBox(height: 100.0),
                  TextFormField(
                    onSaved: (newValue) => email = newValue,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Ovo polje je obavezno";
                      }
                      if (!emailRegex.hasMatch(value)) {
                        return 'Email nije validan!';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'user@example.com',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onSaved: (newValue) => password = newValue,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Ovo polje je obavezno";
                      }
                      if (!regexLozinka.hasMatch(value)) {
                        return 'Lozinka mora sadržavati 6 karaktera!';
                      }
                      if (loginFailed) {
                        return "Pogrešan email ili lozinka!";
                      }
                      return null;
                    },
                    obscureText: true,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      labelText: 'Lozinka',
                      hintText: '********',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  if (loginFailed)
                    const Text(
                      'Login Failed',
                      style: TextStyle(color: Color(0xFF870000)),
                    ),
                  const SizedBox(height: 40.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: const Color(0xFF870000),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () async {
                      loginFailed = false;
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        Map user = {'email': email, 'lozinka': password};
                        try {
                          var data = await _authProvider!.loginAdmin(user);

                          if (context.mounted) {
                            _authProvider!.setParameters(data!.id!.toInt());

                            Authorization.email = email;
                            Authorization.password = password;
                            Authorization.id = data.id!.toInt();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const StazeScreen(),
                              ),
                            );
                          }
                        } on Exception catch (error) {
                          print(error.toString());
                          if (error.toString().contains("Bad request")) {
                            loginFailed = true;
                            formKey.currentState!.validate();
                          }
                        }
                      }
                    },
                    child: const Text('Login', style: TextStyle(fontSize: 20)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

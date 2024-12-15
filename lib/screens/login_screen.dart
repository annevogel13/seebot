import 'package:flutter/material.dart';
import 'package:seebot/components/universal_appbar.dart';
import 'package:seebot/components/universal_background.dart';
import 'package:seebot/functions/current_location.dart';
import 'package:seebot/components/signup_component.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailadressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Map<String, String> validateInput() {
    final String emailAdress = _emailadressController.text;
    final String password = _passwordController.text;

    return {'emailAdress': emailAdress, 'password': password};
  }

  void _openSignupOverlay() {
    final result = validateInput();

    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => SignUp(
            email: result['emailAdress']!, password: result['password']!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UniversalAppBar(title: 'See bot'),
      body: UniversalBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextField(
                  maxLength: 50,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailadressController,
                  decoration: const InputDecoration(
                    labelText: 'Emailadress',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextField(
                  maxLength: 50,
                  keyboardType: TextInputType.visiblePassword,
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final result = validateInput();
                  Navigator.pushNamed(context, '/dashboard', arguments: result);
                },
                child: const Text('Log In'),
              ),
              ElevatedButton(
                onPressed: _openSignupOverlay,
                child: const Text('No account -> sign up'),
              ),
              Text(getCurrentLocation().toString()),
            ],
          ),
        ),
      ),
    );
  }
}

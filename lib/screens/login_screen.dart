import 'package:flutter/material.dart';
import 'package:seebot/components/universal_appbar.dart';
import 'package:seebot/functions/current_location.dart';

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


  Object validateInput(){

    final String emailAdress = _emailadressController.text; 
    final String password = _passwordController.text; 

    return {emailAdress : emailAdress, password : password};
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UniversalAppBar(title: 'See bot'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(20,0,20,0),
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
              padding: EdgeInsets.fromLTRB(20,0,20,0),
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
                validateInput(); 
                Navigator.pushNamed(context, '/dashboard');
              },
              child: const Text('Log In'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: const Text('No account -> sign up'),
            ),
            Text(getCurrentLocation().toString()),
          ],
        ),
      ),
    );
  }
}

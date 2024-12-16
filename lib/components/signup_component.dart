import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key, required this.email, required this.password});

  final String email;
  final String password;

  @override
  State<SignUp> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailadressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailadressController.text = widget.email;
    _passwordController.text = widget.password;
  }

  bool validateInput() {
    final String emailAdress = _emailadressController.text;
    final String password = _passwordController.text;

    ScaffoldMessenger.of(context).clearSnackBars();

    if (emailAdress != '' && password != '') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Account created'),
          duration: const Duration(seconds: 2),
        ),
      );

      return true;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Please fill in all fields'),
        duration: const Duration(seconds: 2),
      ),
    );

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF3ab5b0), Color(0xFF3d99be), Color(0xFF56317a)],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Create account',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: TextField(
              maxLength: 50,
              keyboardType: TextInputType.emailAddress,
              controller: _emailadressController,
              decoration: const InputDecoration(
                labelText: 'Emailadress',
                labelStyle: TextStyle(color: Color(0xFF56317A)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(color: Colors.white),
                ),
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
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // validate input
              final validated = validateInput();
              if (validated) {
                Navigator.pushNamed(context, '/dashboard');
              }
            },
            style: ElevatedButton.styleFrom(
              side:
                  BorderSide(color: Colors.white, width: 2), // Add white border
            ),
            child: const Text('Create account',
                style: TextStyle(color: Color(0xFF56317a))),
          ),
        ],
      ),
    );
  }
}

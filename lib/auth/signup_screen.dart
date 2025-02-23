import 'dart:developer';

import 'package:myapp/auth/auth_service.dart';
import 'package:myapp/auth/login_screen.dart';
import 'package:myapp/homeScreen/home_screen4.dart';
import 'package:myapp/initBalance/InitBalance_screen.dart';
import 'package:myapp/widgets/button.dart';
import 'package:myapp/widgets/textfield.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = AuthService();

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _name.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[700]!, Colors.blue[900]!],
          ),
        ),
        child: Column(
          children: [
            const Spacer(),
            const Text(
              'Ruppes',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            const Text(
              'Signup',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 64),
            // const Text("Signup",
            //     style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500)),
            // const SizedBox(
            //   height: 50,
            // ),
            CustomTextField(
              hint: "Enter Name",
              label: "Name",
              controller: _name,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hint: "Enter Email",
              label: "Email",
              controller: _email,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hint: "Enter Password",
              label: "Password",
              isPassword: true,
              controller: _password,
            ),
            const SizedBox(height: 30),
            CustomButton(
              label: "Signup",
              onPressed: _signup,
            ),
            const SizedBox(height: 5),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("Already have an account? "),
              InkWell(
                onTap: () => goToLogin(context),
                child: const Text("Login", style: TextStyle(color: Colors.red)),
              )
            ]),
            const Spacer()
          ],
        ),
      ),
    );
  }

  goToLogin(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );

  goToHome(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
  goToInitBalance(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AddBalanceScreen()),
      );
  _signup() async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
          _name.text, _email.text, _password.text);
      if (user != null) {
        log("User Created Succesfully");
        goToInitBalance(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(' error : $e')),
      );
    }
  }
}

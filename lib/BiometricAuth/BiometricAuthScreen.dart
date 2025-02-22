// ignore_for_file: unused_field, unused_local_variable, file_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import 'package:tt/main.dart';

class BiometricAuthScreen extends StatefulWidget {
  const BiometricAuthScreen({super.key});

  @override
  _BiometricAuthScreenState createState() => _BiometricAuthScreenState();
}

class _BiometricAuthScreenState extends State<BiometricAuthScreen> {
  late final LocalAuthentication auth;
  bool _supportState = false;
  @override
  void initState() {
    super.initState();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then((bool isSupported) {
      setState(() {
        _supportState = isSupported;
      });
      if (isSupported) {
        _getAvalibleBiometrics();
        _authenticate();
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const AuthWrapper()),
        );
      }
    });
  }

  Future<void> _getAvalibleBiometrics() async {
    List<BiometricType> avaloibeBiometrics =
        await auth.getAvailableBiometrics();
    if (!mounted) {
      return;
    }
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Please authenticate to unlock your app',
        options: const AuthenticationOptions(
          stickyAuth: true, // Keeps prompting until successful or canceled
          biometricOnly: false, // Uses only biometrics
        ),
      );
    } on PlatformException catch (e) {
      log("Error using biometrics: $e");
    }
    if (authenticated) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AuthWrapper()),
      );
    } else {
      SystemNavigator.pop(); // Exit app if authentication fails
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child:
            CircularProgressIndicator(), // Show loading indicator during authentication
      ),
    );
  }
}

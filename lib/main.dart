import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tt/BiometricAuth/BiometricAuthScreen.dart';
// import 'package:myapp/homeScreen/home_screen.dart';
import 'package:tt/homeScreen/home_screen4.dart';
import 'package:tt/auth/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue[600]!),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const BiometricAuthScreen());
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(), // Listens to auth state
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Display loading indicator while Firebase initializes
          return const Scaffold(
            backgroundColor: Color.fromARGB(255, 15, 73, 160),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        log("Snapshot of authstate = $snapshot");
        if (snapshot.hasData) {
          // User is logged in, navigate to HomeScreen
          return const HomeScreen();
        } else {
          // User is not logged in, navigate to LoginScreen
          return const LoginScreen();
        }
      },
    );
  }
}

// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: Center(
//           child: Text('Hello, World!'),
//         ),
//       ),
//     );
//   }
// }

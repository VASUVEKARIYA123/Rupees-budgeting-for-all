// import 'package:flutter/material.dart';
// import 'package:myapp/backend/auth.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final bool _isLoading = false;

//   void _handleGoogleSignIn() async {
//     await (signInWithGoogle());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Colors.blue[700]!, Colors.blue[900]!],
//           ),
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 32.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 const Text(
//                   'Ruppes',
//                   style: TextStyle(
//                     fontSize: 48,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 24),
//                 const Text(
//                   'Welcome to Ruppes',
//                   style: TextStyle(
//                     fontSize: 24,
//                     color: Colors.white70,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 64),
//                 ElevatedButton(
//                   onPressed: _handleGoogleSignIn,
//                   style:
//                   child: const Text(
//                     'Sign in with Google',
//                     style: TextStyle(
//                       fontSize: 20,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   checkInitialBalanceSet(Loginsuccess) {}
// }

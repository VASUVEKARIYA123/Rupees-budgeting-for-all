// import 'package:flutter/material.dart';
// import 'package:myapp/backend/auth.dart';

// class GoogleScreen extends StatefulWidget {
//   const GoogleScreen({super.key});

//   @override
//   _GoogleScreenState createState() => _GoogleScreenState();
// }

// class _GoogleScreenState extends State<GoogleScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Scaffold(
//         body: Container(
//           child: Column(children: [
//             const Text(
//               'Ruppes',
//               style: TextStyle(
//                 fontSize: 48,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 24),
//             const Text(
//               'Welcome to Ruppes',
//               style: TextStyle(
//                 fontSize: 24,
//                 color: Colors.white70,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             ElevatedButton(
//                 onPressed: () => authServices().googleAuth(),
//                 child: const Text("Sign in With google"))
//           ]),
//         ),
//       ),
//     );
//   }
// }

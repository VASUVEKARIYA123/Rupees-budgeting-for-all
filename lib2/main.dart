import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(ExpenseManagerApp());
}

class ExpenseManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Manager',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        hintColor: Colors.orangeAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto',
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
          bodyMedium: TextStyle(fontSize: 14.0),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

// import 'package:flutter/material.dart';
// void main() => runApp(MyApp());
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: BgImageSwitcher(),
//     );
//   }
// }
// class BgImageSwitcher extends StatefulWidget {
//   @override
//   _BgImageSwitcherState createState() => _BgImageSwitcherState();
// }
// class _BgImageSwitcherState extends State<BgImageSwitcher> {
//   // Two example URLs for background images
//   String bgImageUrl = 'https://cdn.pixabay.com/photo/2016/03/05/19/02/sunset-1230003_960_720.jpg';
//   String alternateImageUrl = 'https://cdn.pixabay.com/photo/2016/03/05/19/02/sunset-1230003_960_720.jpg';
//   bool isFirstImage = true;
//
//   void changeBackground() {
//     setState(() {
//       // Toggle between the two background images
//       isFirstImage = !isFirstImage;
//       bgImageUrl = isFirstImage
//           ?
//       'https://pixabay.com/photos/web-dew-spider-web-trap-silk-586177/'
//       :
//       'https://pixabay.com/photos/cobweb-web-dew-drip-raindrop-1630493/';
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Background Image Switcher'),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: NetworkImage(bgImageUrl), // Load image from the URL
//             fit: BoxFit.cover, // Make sure the image covers the whole screen
//           ),
//         ),
//         child: Center(
//           child: ElevatedButton(
//             onPressed: changeBackground, // Change background when clicked
//             child: Text('Change Background'),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: BgImageSwitcher(),
//     );
//   }
// }
//
// class BgImageSwitcher extends StatefulWidget {
//   @override
//   _BgImageSwitcherState createState() => _BgImageSwitcherState();
// }
//
// class _BgImageSwitcherState extends State<BgImageSwitcher> {
//   // Corrected direct image URLs
//   String bgImageUrl = 'https://cdn.pixabay.com/photo/2016/03/05/19/02/sunset-1230003_960_720.jpg';
//   String alternateImageUrl = 'https://cdn.pixabay.com/photo/2016/11/18/15/52/spider-web-1837642_960_720.jpg';
//   bool isFirstImage = true;
//
//   void changeBackground() {
//     setState(() {
//       // Toggle between the two valid background images
//       isFirstImage = !isFirstImage;
//       bgImageUrl = isFirstImage ? bgImageUrl : alternateImageUrl;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Background Image Switcher'),
//       ),
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           Image.network(
//             bgImageUrl,
//             fit: BoxFit.cover,
//             errorBuilder: (context, error, stackTrace) {
//               return Center(child: Text("Failed to load image", style: TextStyle(color: Colors.white)));
//             },
//           ),
//           Center(
//             child: ElevatedButton(
//               onPressed: changeBackground,
//               child: Text('Change Background'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

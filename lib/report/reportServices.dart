// import 'package:cloud_firestore/cloud_firestore.dart';

// class HomeService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<List<Map<String, dynamic>>> fetchMonthlyExpenses(DateTime date) async {
//     DateTime startDate = DateTime(date.year, date.month, 1);
//     DateTime endDate = DateTime(date.year, date.month + 1, 0, 23, 59, 59);

//     QuerySnapshot querySnapshot = await _firestore
//         .collection('expenses') // Replace with your collection name
//         .where('timestamp', isGreaterThan: startDate)
//         .where('timestamp', isLessThan: endDate)
//         .get();

//     return querySnapshot.docs.map((doc) => {
//       'id': doc.id,
//       ...doc.data() as Map<String, dynamic>
//     }).toList();
//   }
// }
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'dart:developer';

// final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// final FirebaseAuth _auth = FirebaseAuth.instance;

// // Get current user's ID
// String getUserId() {
//   return _auth.currentUser?.uid ?? '';
// }

// class ExpenseService {
//   // Add an expense to Firestore
//   Future<bool> addExpense(String title, String category, String amount) async {
//     String userId = getUserId();
//     var categ = int.parse(category);
//     var amunt = int.parse(amount);
//     var status = false;
//     CollectionReference expenses = _firestore
//         .collection('transactions')
//         .doc(userId)
//         .collection('users_expenses');

//     await expenses.add({
//       'title': title,
//       'category': categ,
//       'amount': amunt,
//       'timestamp': FieldValue
//           .serverTimestamp(), // To keep track of when the expense was added
//     }).then((value) {
//       status = true;
//       log("Chnage Status to True,Cuz $value");
//     }).catchError((error) {
//       log("Something went wrong");
//     });
//     log("### Defult return false ###");
//     return status;
//   }
// }

// class ExpenseService {
// // Add a transaction to Firestore (for both income and expenses)
// Future<bool> addExpense(
//     String title, String category, String amount, String type) async {
//   String userId = getUserId();
//   var categ = int.parse(category);
//   var amunt = int.parse(amount);
//   var status = false;
//   CollectionReference transactions = _firestore
//       .collection('transactions')
//       .doc(userId)
//       .collection('users_transactions'); // Combined collection for both income and expenses

//   await transactions.add({
//     'title': title,
//     'category': categ,
//     'amount': amunt,
//     'type': type, // Either 'income' or 'expense'
//     'timestamp': FieldValue.serverTimestamp(), // Timestamp
//   }).then((value) {
//     status = true;
//     log("Transaction added: $value");
//   }).catchError((error) {
//     log("Something went wrong: $error");
//   });

//   return status;
// }

//111111111111111111111111111111111111
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'dart:developer';

// final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// final FirebaseAuth _auth = FirebaseAuth.instance;

// // Get current user's ID
// String getUserId() {
//   return _auth.currentUser?.uid ?? '';
// }
// class ExpenseService {
//   // Add a transaction (expense or income) to Firestore
//   Future<bool> addExpense(
//       String title, String category, String amount, String type) async {
//     String userId = getUserId();
//     var categ = double.parse(category);
//     var amunt = double.parse(amount);
//     var status = false;

//     // Determine the collection based on transaction type
//     CollectionReference transactions = _firestore
//         .collection('transactions')
//         .doc(userId)
//         .collection(type == 'expense' ? 'users_expense' : 'users_income');

//     await transactions.add({
//       'title': title,
//       'category': categ,
//       'amount': amunt,
//       'timestamp': FieldValue
//           .serverTimestamp(), // To track when the transaction was added
//     }).then((value) {
//       status = true;
//       log("Transaction added successfully to $type collection");
//       return status;
//     }).catchError((error) {
//       log("Something went wrong: $error");
//           return status;

//     });

//     return status;
//   }
// }

//2222222222222222222222222222222222222
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

// Get current user's ID
String getUserId() {
  return _auth.currentUser?.uid ?? '';
}

class ExpenseService {
  // Add a transaction (expense or income) to Firestore
  Future<bool> addExpense(String title, String category, String amount,
      String type, DateTime dateTime) async {
    String userId = getUserId();
    var categ = category; // Assuming category is a string
    var amunt =
        double.tryParse(amount) ?? 0.0; // Safely parse the amount to a double
    var status = false;

    if (userId.isEmpty) {
      log("User not logged in");
      return false;
    }

    // Validate inputs
    if (title.isEmpty || categ.isEmpty || amunt <= 0) {
      log("Invalid input data");
      return false;
    }

    // Determine the collection based on transaction type
    CollectionReference transactions = _firestore
        .collection('transactions')
        .doc(userId)
        .collection('tansaction');

    try {
      await transactions.add({
        'title': title,
        'category': categ,
        'amount': amunt,
        'type': type,
        'timestamp':
            Timestamp.fromDate(dateTime), // Using the selected date and time
      });

      status = true;
      log("Transaction added successfully to $type collection");
    } catch (error) {
      log("Error adding transaction: $error");
      status = false;
    }

    return status;
  }
}

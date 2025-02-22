import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

// Get current user's ID
String getUserId() {
  log("Current User Value:-- ${_auth.currentUser}");
  return _auth.currentUser?.uid ?? '';
}

class HomeService {
  // Add an expense to Firestore
  Future<List<Map<String, dynamic>>> fetchUserExpenses() async {
    String userId = getUserId();

    try {
      QuerySnapshot snapshot1 = await _firestore
          .collection('transactions')
          .doc(userId)
          .collection('tansaction')
          .get();

      // Mapping and converting Timestamp to DateTime
      var expenses = snapshot1.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        // Convert timestamp to DateTime if it exists
        if (data['timestamp'] != null) {
          data['timestamp'] = (data['timestamp'] as Timestamp).toDate();
        }

        return data;
      }).toList();
      print(expenses);
      return expenses;
    } catch (e) {
      print('Error fetching expenses: $e');
      return [];
    }
  }

  Future<void> deleteExpense(String id) async {
    String userId = getUserId();
    final CollectionReference expensesRef = _firestore
        .collection('transactions')
        .doc(userId)
        .collection('tansaction');
    try {
        await expensesRef.doc(id).delete();
    } catch (e) {
      print("Error deleting expense: $e");
    }
  }
}

class UserService {
  /*// Future<Map<String, dynamic>?> getUserData() async {
  //   try {
  //     // Get the current user ID from the AuthService
  //     String userId = getUserId();
  //     log("User id d= $userId");

  //     // Fetch the user document from Firestore
  //     DocumentSnapshot userDoc =
  //         await _firestore.collection('users').doc(userId).get();
  //     log("User doc = $userDoc");

  //     // Check if the user document exists
  //     if (userDoc.exists) {
  //       print("USer Doc Service = $userDoc.data()");
  //       // print("User Data Balance = $userData['balance']");
  //       return userDoc.data() as Map<String, dynamic>?;
  //     }
  //   } catch (e) {
  //     print('Error fetching user data: $e');
  //   }

  //   // Return null if there's an error or no data is found
  //   return null;
  // }
*/
  Future<Map<String, dynamic>?> getUserData() async {
    try {
      String userId = getUserId();
      log("User id = $userId");

      DocumentSnapshot userDoc =
          await _firestore.collection('Users').doc(userId).get();

      log("User doc data = ${userDoc.data()}");

      if (userDoc.exists && userDoc.data() != null) {
        Map<String, dynamic>? userData =
            userDoc.data() as Map<String, dynamic>?;
        log("User data map = $userData");

        return userData;
      } else {
        log("User document does not exist or has no data.");
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }

    return null;
  }
}

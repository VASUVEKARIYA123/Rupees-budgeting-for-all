import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;

Future<bool> addIntiBalance(amount) async {
  try {
    final User? user = _auth.currentUser;
    final uid = user?.uid;
    CollectionReference Users = FirebaseFirestore.instance.collection('Users');

    // Check if the user already exists in Firestore
    DocumentSnapshot userDoc = await Users.doc(user!.uid).get();

    if (userDoc.exists) {
      // Create a new user document with their information
      await Users.doc(uid).update({
        'balance': amount,
      });
    } else {
      return false;
    }

    return true;
  } catch (e) {
    print(e.toString());
    return false;
  }
  // Access Firestore and the users collection

  // Check if the user already exists in Firestore
}

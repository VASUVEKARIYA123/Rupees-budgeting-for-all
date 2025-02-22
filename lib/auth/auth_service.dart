import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  Future<UserCredential?> LoginWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;
      final cred = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);
      final auth = await _auth.signInWithCredential(cred);
      final user = auth.user;
      final name = user!.displayName;
      await saveUserToFirestore(user, name);
      return auth;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<User?> createUserWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = cred.user;
      await saveUserToFirestore(user, name);
      return cred.user;
    } catch (e) {
      log("Something went wrong");
    }
    return null;
  }

  Future<User?> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      log("Something went wrong");
    }
    return null;
  }

  Future<void> signout() async {
    try {

      await _auth.signOut();
    } catch (e) {
      log("Something went wrong");
    }
  }

  Future<void> saveUserToFirestore(User? user, name) async {
    // Access Firestore and the users collection
    CollectionReference Users = FirebaseFirestore.instance.collection('Users');

    // Check if the user already exists in Firestore
    DocumentSnapshot userDoc = await Users.doc(user!.uid).get();

    if (!userDoc.exists) {
      final uid = user.uid;
      // Create a new user document with their information
      await Users.doc(uid).set({
        'uid': uid,
        'newUser': true,
        'balance': 0,
        'displayName': name,
        'email': user.email,
        'photoURL': user.photoURL,
      });
    }
  }
}


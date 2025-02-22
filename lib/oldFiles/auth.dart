import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // For Authenitcation Credentials
import 'package:google_sign_in/google_sign_in.dart'; // For Google Sign In

//To creat user account on firestore

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  print(credential);
  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

class authServices {
  googleAuth() async {
    print("Hello Google Auth");
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    print("Hello Google Auth");
    final instance =
        await FirebaseAuth.instance.signInWithCredential(credential);
    // NEw DB CODE

    User? user = instance.user;
    if (user != null) {
      await saveUserToFirestore(user);
    }

    // END oF DB CODE
    return instance;
  }
}

Future<void> saveUserToFirestore(User user) async {
  // Access Firestore and the users collection
  CollectionReference Users = FirebaseFirestore.instance.collection('Users');

  // Check if the user already exists in Firestore
  DocumentSnapshot userDoc = await Users.doc(user.uid).get();

  if (!userDoc.exists) {
    // Create a new user document with their information
    await Users.doc(user.uid).set({
      'uid': user.uid,
      'displayName': user.displayName,
      'email': user.email,
      'photoURL': user.photoURL,
    });
  }
}

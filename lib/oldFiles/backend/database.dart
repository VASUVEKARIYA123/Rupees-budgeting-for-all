import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  final _store = FirebaseFirestore.instance;
  createUser() {
    try {
      _store
          .collection("Users")
          .add({"name": "Abc xyz ", "email": "abc123@google.com"});
    } catch (e) {
      print(e.toString());
    }
  }
}

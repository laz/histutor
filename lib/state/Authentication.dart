import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:histutor/model/User.dart' as model;

class Authentication extends ChangeNotifier {
  User _auth;
  User get auth => _auth;

  Stream<model.User> getUser(String studentId) {
    return FirebaseFirestore.instance.collection('Users').doc(studentId).snapshots().map((user) => model.User.fromFirebase(user));
  }

  Stream<User> getAuth() {
    return FirebaseAuth.instance.authStateChanges();
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    if (googleUser.email.split('@')[1] != 'handong.edu') {
      handong(context);
      GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
    } else {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      _auth = userCredential.user;
      String id = _auth.email.split('@')[0];

      final snapshot = await FirebaseFirestore.instance.collection('Users').doc(id).get();

      // first time login
      if (!snapshot.exists) {
        await FirebaseFirestore.instance.collection('Users').doc(id).set({
          'uid': _auth.uid,
          'email': _auth.email,
          'nickname': id,
          'id': id,
          'studentId': 0,
          'time': 0,
          'type': 'tutee',
          'isNew': true,
        });
      }
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  void handong(BuildContext context) {
    var alert = AlertDialog(
      title: Text('오류'),
      content: Text('한동대 메일로 로그인 해주세요'),
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}

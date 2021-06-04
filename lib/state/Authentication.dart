import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:histutor/model/User.dart' as model;

class Authentication extends ChangeNotifier {
  User _auth;
  User get auth => _auth;

  Stream<model.User> getUser(String studentId) {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(studentId)
        .snapshots()
        .map((user) => model.User.fromFirebase(user));
  }

  Stream<User> getAuth() {
    return FirebaseAuth.instance.authStateChanges();
  }

  Future<void> signInWithGoogle(BuildContext context) async {

    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    if(googleUser.email.split('@')[1] != 'handong.edu'){
      handong(context);
      GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
    }
    else{
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      _auth = userCredential.user;
        String studentId = _auth.email.split('@')[0];
        String name = studentId[1]+studentId[2] + _auth.displayName.split('학부생')[0];

        final snapshot = await FirebaseFirestore.instance
            .collection('Users')
            .doc(studentId)
            .get();

        // first time login
        if (!snapshot.exists) {
          await FirebaseFirestore.instance.collection('Users').doc(studentId).set({
            'Uid': _auth.uid,
            'email': _auth.email,
            'name': name,
            'studentId': int.parse(studentId),
            'time': 0,
            'type': 'tutee'
          });
        }
      }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();

  }


  void handong(BuildContext context){
    var alert = AlertDialog(
      title: Text('오류'),
      content: Text('한동대 메일로 로그인 해주세요'),
    );

    showDialog(
        context: context,
        builder: (BuildContext context){
          return alert;
        }
    );
  }
}


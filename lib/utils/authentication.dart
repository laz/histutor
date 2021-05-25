import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

String name;
String imageUrl;
String uid;
String userEmail;
String stdId;

    Future<User> signInWithGoogle(BuildContext context) async {
  // Initialize Firebase
  await Firebase.initializeApp();
  User user;

  // The `GoogleAuthProvider` can only be used while running on the web
  GoogleAuthProvider authProvider = GoogleAuthProvider();

  try {
    final UserCredential userCredential =
    await _auth.signInWithPopup(authProvider);

    user = userCredential.user;

  } catch (e) {
    print(e);
  }

  String mail= user.email.split('@')[1];
  print(mail);
  if(mail != 'handong.edu'){
    print(context);
    handong(context);
    FirebaseAuth.instance.signOut();
    signOutGoogle();
    return null;
  }
  else if (user != null) {

    print(mail);
    uid = user.uid;
    stdId = user.email.split('@')[0];
    print(uid);
    name = user.displayName;
    print(name);
    userEmail = user.email;
    imageUrl = user.photoURL;

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    //존재하는지 확인하고
    //불러와서 time에 플러스하기 + type 받아오기
    firestore.collection('Users').doc(stdId).set({
        'email': userEmail,
        'name' : name,
        'studentId': stdId,
        'time' : 0,
        'type' : "tutee"
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('auth', true);
  }

  return user;
}

void signOutGoogle() async {
  await googleSignIn.signOut();
  await _auth.signOut();

  final UserCredential userCredential = null;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('auth', false);

  uid = null;
  name = null;
  userEmail = null;
  imageUrl = null;
  stdId = null;

  print("User signed out of Google account");
}


Future getUser() async {
  // Initialize Firebase
  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool authSignedIn = prefs.getBool('auth') ?? false;

  final User user = _auth.currentUser;

  if (authSignedIn == true) {
    if (user != null) {
      uid = user.uid;
      name = user.displayName;
      userEmail = user.email;
      imageUrl = user.photoURL;
      stdId = user.email.split('@')[0];
    }
  }
}

void handong(BuildContext context){
  var alert = AlertDialog(
    title: Text('오류'),
    content: Text('한동대 메일로 로그인 해주세요'),
  );

  showDialog(context: context,builder: (BuildContext context){
    return alert;
  }
  );
}

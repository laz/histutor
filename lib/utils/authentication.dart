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
    signOutGoogle();
    FirebaseAuth.instance.signOut();

    return null;
  }
  else if (user != null) {

    //print(mail);
    uid = user.uid;
    stdId = user.email.split('@')[0];

    //print(uid);
    name = stdId[1]+stdId[2]+user.displayName.split('학부생')[0];

    print(name);
    userEmail = user.email;
    imageUrl = user.photoURL;

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var UserData = await firestore.collection('Users').doc(uid).get();

    final snapShot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(stdId) // varuId in your case
        .get();

    if (snapShot == null || !snapShot.exists) {
      // Document with id == varuId doesn't exist.
      firestore.collection('Users').doc(stdId).set({
        'email': userEmail,
        'name' : name,
        'studentId': stdId,
        'time' : 0,
        'type' : "tutee"
      });
      // You can add data to Firebase Firestore here
    }
    else{
      print("It is exist!");
    }


    // if(UserData.data() != null){
    //   //Here The User's UserID already existed in Firestore , Perform What You want!!
    // }
    // else{
    //   //Here The User's UserID doesn't yet exists in Firestore , Perform What You want!!
    //   firestore.collection('Users').doc(stdId).set({
    //     'email': userEmail,
    //     'name' : name,
    //     'studentId': stdId,
    //     'time' : 0,
    //     'type' : "tutee"
    //   });
    // }

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
  //setState(() {
    uid = null;
    name = null;
    userEmail = null;
    imageUrl = null;
    stdId = null;
  //});


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

// String name;
// String imageUrl;
// String uid;
// String userEmail;
// String stdId;

String get_name(){
  return name;
}

String get_stdId(){
  return stdId;
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

void signOutGoogle_2() async{
  await googleSignIn.signOut();
  print("User Sign Out");
}

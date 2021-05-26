
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:histutor/model/Chat.dart';
import 'package:histutor/model/Participant.dart';
import 'package:histutor/model/Session.dart';
import 'package:histutor/model/User.dart';

class ApplicationState extends ChangeNotifier {

  // function prototypes

  User user = User(
    name: 'Joowon Park',
    studentId: 216002931,
    email: '21600293@handong.edu',
    time: 0,
    type: 'tutor',

  );

  void addUser() {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(user.studentId.toString())
        .set({
      'name': user.name,
      'studentId': user.studentId,
      'email': user.email,
      'time': user.time,
      'type': user.type,
    });
    print('added user');
  }

  void addUserSession() {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(user.studentId.toString())
        .collection('Sessions')
        .add({
      'tutor': user.name,
      'date': FieldValue.serverTimestamp(),
      'time': 10,
      'name': 'first session',
    });
    print('added userSession');
  }

}
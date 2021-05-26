
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:histutor/model/Chat.dart';
import 'package:histutor/model/Participant.dart';
import 'package:histutor/model/Session.dart';
import 'package:histutor/model/User.dart';

class ApplicationState extends ChangeNotifier {
  bool isAdmin = false;
  int selectedPage = 0;
  int selectedAdminPage = 0;
  int selectedMyPage = 0;
  // function prototypes
  void changeSelectedPage(int num){
    selectedPage = num;
    notifyListeners();
  }
  void changeSelectedAdminPage(int num){
    selectedAdminPage = num;
    notifyListeners();
  }
  void changeSelectedMyPage(int num){
    selectedMyPage = num;
    notifyListeners();
  }
  User user = User(
    name: 'Joowon Park',
    studentId: 21600293,
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

  int sessionIndex = 0;

  Session session = Session(
    sessionIndex: 0,
    tutorName: 'Joowon Park',
    sessionName: 'C coding hour',
    category: '???',
    sessionStart: DateTime(2021, 5, 19, 8, 30),
    sessionEnd: DateTime(2021, 5, 19, 10, 30),
  );

  void addSession() {
    FirebaseFirestore.instance
        .collection('Sessions')
        .doc(sessionIndex.toString())
        .set({
      'sessionIndex': sessionIndex,
      'tutorName': session.tutorName,
      'sessionName': session.sessionName,
      'category': session.category,
      'sessionStart': session.sessionStart,
      'sessionEnd': session.sessionEnd,
      'createdTime': FieldValue.serverTimestamp(),
    });
    sessionIndex++;
    print('added session');
  }

  Chat chat = Chat(
      text: 'help help',
      from: 'Joowon Park'
  );

  void addChat() {
    FirebaseFirestore.instance
        .collection('Sessions')
        .doc(sessionIndex.toString())
        .collection('Chats')
        .add({
      'text': chat.text,
      'from': chat.from,
      'time': FieldValue.serverTimestamp(),
    });
    print('added chat');
  }

  Participant participant = Participant(
    studentId: 21600293,
    name: 'Joowon Park'
  );

  void addParticipant() {
    FirebaseFirestore.instance
        .collection('Sessions')
        .doc(sessionIndex.toString())
        .collection('Participants')
        .add({
      'studentId': participant.studentId,
      'name': participant.name,
      'entrance': FieldValue.serverTimestamp(),
    });
    print('added participant');
  }

  // synchronize messages

}
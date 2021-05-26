
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:histutor/model/Chat.dart';
import 'package:histutor/model/Participant.dart';
import 'package:histutor/model/Session.dart';
import 'package:provider/provider.dart';

class SessionController extends ChangeNotifier {

  Session session = Session(
    sessionIndex: 0,
    tutorName: 'Joowon Park',
    sessionName: 'C coding hour',
    category: '???',
    sessionStart: Timestamp.fromDate(DateTime(2021, 5, 19, 8, 30)),
    sessionEnd: Timestamp.fromDate(DateTime(2021, 5, 19, 10, 30)),
  );

  Chat chat = Chat(
      text: 'help help',
      from: 'Joowon Park'
  );

  Participant partici = Participant(
      studentId: 21600293,
      name: 'Joowon Park'
  );

  void addSession(int newSessionIndex) {
    FirebaseFirestore.instance
        .collection('Sessions')
        .doc(newSessionIndex.toString())
        .set({
      'sessionIndex': newSessionIndex,
      'tutorName': session.tutorName,
      'sessionName': session.sessionName,
      'category': session.category,
      'sessionStart': session.sessionStart,
      'sessionEnd': session.sessionEnd,
      'createdTime': FieldValue.serverTimestamp(),
    });
  }

  void addParticipant(int sessionIndex) {
    FirebaseFirestore.instance
        .collection('Sessions')
        .doc(sessionIndex.toString())
        .collection('Participants')
        .add({
      'studentId': partici.studentId,
      'name': partici.name,
      'entrance': FieldValue.serverTimestamp(),
    });
  }

  void addChat(int sessionIndex) {
    FirebaseFirestore.instance
        .collection('Sessions')
        .doc(sessionIndex.toString())
        .collection('Chats')
        .add({
      'text': chat.text,
      'from': chat.from,
      'time': FieldValue.serverTimestamp(),
    });
  }


}
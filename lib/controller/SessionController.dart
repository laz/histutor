import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:histutor/model/Chat.dart';
import 'package:histutor/model/Participant.dart';
import 'package:histutor/model/Session.dart';
import 'package:provider/provider.dart';

import '../model/Participant.dart';
import '../model/Session.dart';
import '../model/User.dart';

class SessionController extends ChangeNotifier {
  Future<void> addParticipant(User auth, String session) async {
    await FirebaseFirestore.instance
        .collection('Sessions')
        .doc(session)
        .collection('Participants')
        .doc(auth.studentId.toString())
        .set({
      'entrance': FieldValue.serverTimestamp(),
      'name': auth.name,
      'studentId': auth.studentId,
      'uid': auth.Uid,
      'startTime': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateStartTime(Participant p, String session) async {
    await FirebaseFirestore.instance
        .collection('Sessions')
        .doc(session)
        .collection('Participants')
        .doc(p.studentId.toString())
        .update({
      'startTime': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteParticipants(User auth, String session) async {
    await FirebaseFirestore.instance
        .collection('Sessions')
        .doc(session)
        .collection('Participants')
        .doc(auth.studentId.toString())
        .delete();
  }

  Future<void> updateTime(User auth, Session session) async {
    print('yee');
    int t = 0;
    Timestamp start;
    bool exist = false;

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(auth.studentId.toString())
        .collection('Sessions')
        .doc(session.sessionIndex.toString())
        .get()
        .then((document) {
      exist = document.exists;
      if (exist) t = document.data()['time'];
    });

    await FirebaseFirestore.instance
        .collection('Sessions')
        .doc(session.sessionIndex.toString())
        .collection('Participants')
        .doc(auth.studentId.toString())
        .get()
        .then((value) {
      start = value.data()['startTime'];
    });

    print(start.toDate().toString());
    // Timestamp now = FieldValue.serverTimestamp() as Timestamp;
    // Duration time = start.difference(now.toDate());

    exist
        ? await FirebaseFirestore.instance
            .collection('Users')
            .doc(auth.studentId.toString())
            .collection('Sessions')
            .doc(session.sessionIndex.toString())
            .update({
            'time': 2,
          })
        : await FirebaseFirestore.instance
            .collection('Users')
            .doc(auth.studentId.toString())
            .collection('Sessions')
            .doc(session.sessionIndex.toString())
            .set({
            'date': session.sessionStart,
            'sessionName': session.sessionName,
            'time': 1,
            'tutorName': session.tutorName,
          });

    deleteParticipants(auth, session.sessionIndex.toString());
  }
}

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

    print('starttime: ' + start.toDate().toString());
    print('diff: ' + start.toDate().difference(DateTime.now()).toString());
    Duration time = DateTime.now().difference(start.toDate());
    print(time.inMinutes);

    // 튜터 시작 & 종료 버튼으로 시간 재기
    // 종료 버튼 누르면 튜티 참가자 목록에서 삭제 & 방에서 강퇴

    exist
        ? await FirebaseFirestore.instance
            .collection('Users')
            .doc(auth.studentId.toString())
            .collection('Sessions')
            .doc(session.sessionIndex.toString())
            .update({
            'time': t + time.inMinutes,
          })
        : await FirebaseFirestore.instance
            .collection('Users')
            .doc(auth.studentId.toString())
            .collection('Sessions')
            .doc(session.sessionIndex.toString())
            .set({
            'date': session.sessionStart,
            'sessionName': session.sessionName,
            'time': time.inMinutes,
            'tutorName': session.tutorName,
          });

    deleteParticipants(auth, session.sessionIndex.toString());
  }
}

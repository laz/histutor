import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:histutor/model/Participant.dart';
import 'package:histutor/model/Session.dart';

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
      'startTime': null,
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

  Future<void> deleteParticipant(Participant p, Session session, User tutor) async {

    await updateTime(p, session, tutor);

    await FirebaseFirestore.instance
        .collection('Sessions')
        .doc(session.sessionIndex.toString())
        .collection('Participants')
        .doc(p.studentId.toString())
        .delete();
  }

  Future<void> updateTotalTime(Participant p, int time, User tutor) async {
    int total = 0;

    // 튜티의 기존에 있는 총시간 가져오기
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(p.studentId.toString())
        .get()
        .then((document) {
      total = document.data()['time'];
    });

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(p.studentId.toString())
        .update({
      'time': time + total,
    });

    total = 0;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(tutor.studentId.toString())
        .get()
        .then((document) {
      total = document.data()['time'];
    });

    await FirebaseFirestore.instance
    .collection('Users')
    .doc(tutor.studentId.toString())
    .update({
      'time': time + total,
    });
  }

  Future<void> updateTime(Participant p, Session session, User tutor) async {
    int t = 0;
    int tutorT = 0;
    Timestamp start;
    bool exist = false;
    bool tutorExist = false;

    // 기존에 세션에 참가한 적이 있다면, 시간 가져오기
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(p.studentId.toString())
        .collection('Sessions')
        .doc(session.sessionIndex.toString())
        .get()
        .then((document) {
      exist = document.exists;
      if (exist) t = document.data()['time'];
    });

    // 시작 시간 가져오기
    await FirebaseFirestore.instance
        .collection('Sessions')
        .doc(session.sessionIndex.toString())
        .collection('Participants')
        .doc(p.studentId.toString())
        .get()
        .then((value) {
      start = value.data()['startTime'];
    });

    if(start == null) return;

    // 튜터링이 진행된 시간 계산하기
    Duration time = DateTime.now().difference(start.toDate());

    // 이미 세션이 존재한다면 튜터링이 진행된 시간 업데이트
    exist
        ? await FirebaseFirestore.instance
            .collection('Users')
            .doc(p.studentId.toString())
            .collection('Sessions')
            .doc(session.sessionIndex.toString())
            .update({
            'time': time.inMinutes + t,
          })
        // 세션이 존재하지 않는다면 새롭게 만들어 진행된 시간 추가
        : await FirebaseFirestore.instance
            .collection('Users')
            .doc(p.studentId.toString())
            .collection('Sessions')
            .doc(session.sessionIndex.toString())
            .set({
            'date': session.sessionStart,
            'sessionName': session.sessionName,
            'time': time.inMinutes,
            'tutorName': session.tutorName,
          });


    // 튜터의 세션 기록
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(tutor.studentId.toString())
        .collection('Sessions')
        .doc(session.sessionIndex.toString())
        .get()
        .then((document) {
      tutorExist = document.exists;
      if (tutorExist) tutorT = document.data()['time'];
    });

    tutorExist
        ? await FirebaseFirestore.instance
        .collection('Users')
        .doc(tutor.studentId.toString())
        .collection('Sessions')
        .doc(session.sessionIndex.toString())
        .update({
      'time': time.inMinutes + tutorT,
    })
    // 세션이 존재하지 않는다면 새롭게 만들어 진행된 시간 추가
        : await FirebaseFirestore.instance
        .collection('Users')
        .doc(tutor.studentId.toString())
        .collection('Sessions')
        .doc(session.sessionIndex.toString())
        .set({
      'date': session.sessionStart,
      'sessionName': session.sessionName,
      'time': time.inMinutes,
      'tutorName': session.tutorName,
    });





    updateTotalTime(p, time.inMinutes, tutor);
  }
}

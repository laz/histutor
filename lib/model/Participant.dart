
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Participant {
  final int studentId;
  final String id;
  final Timestamp entrance;
  final String nickname;
  final String uid;
  final Timestamp startTime;
  final bool alert;

  Participant({
    @required this.studentId,
    @required this.id,
    @required this.entrance,
    @required this.nickname,
    @required this.uid,
    @required this.startTime,
    @required this.alert,
  });

  factory Participant.fromFirebase(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    return Participant(
      studentId: data['studentId'],
      id: data['id'],
      entrance: data['entrance'],
      nickname: data['nickname'],
      uid: data['uid'],
      startTime: data['startTime'],
      alert: data['alert'],
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Participant {
  final int studentId;
  final Timestamp entrance;
  final String name;
  final String uid;
  final Timestamp startTime;

  Participant({
    @required this.studentId,
    @required this.entrance,
    @required this.name,
    @required this.uid,
    @required this.startTime,
  });

  factory Participant.fromFirebase(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    return Participant(
      studentId: data['studentId'],
      entrance: data['entrance'],
      name: data['name'],
      uid: data['uid'],
      startTime: data['startTime'],
    );
  }
}
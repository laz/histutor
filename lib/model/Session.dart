
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Session {
  final int sessionIndex;
  final String tutorName;
  final String sessionName;
  final String category;
  final Timestamp sessionStart;
  final Timestamp sessionEnd;
  Timestamp createdTime;

  Session({
    @required this.sessionIndex,
    @required this.tutorName,
    @required this.sessionName,
    @required this.sessionStart,
    @required this.sessionEnd,
    @required this.category,
    @required this.createdTime,
  });

  factory Session.fromFirebase(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    return Session(
      sessionIndex: data['sessionIndex'],
      tutorName: data['tutorName'],
      sessionName: data['sessionName'],
      sessionStart: data['sessionStart'],
      sessionEnd: data['sessionEnd'],
      category: data['category'],
      createdTime: data['createdTime'],
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Session {
  final String tutorId;
  final int sessionIndex;
  final String tutorName;
  final String sessionName;
  final String category;
  final Timestamp sessionStart;
  final Timestamp sessionEnd;
  final String offline;
  final String zoomLink;
  final List<dynamic> participants;
  final String actualStudentBeingTutored;
  Timestamp createdTime;

  Session({
    @required this.tutorId,
    @required this.sessionIndex,
    @required this.tutorName,
    @required this.sessionName,
    @required this.sessionStart,
    @required this.sessionEnd,
    @required this.category,
    @required this.createdTime,
    @required this.offline,
    @required this.participants,
    @required this.actualStudentBeingTutored,
    @required this.zoomLink,
  });

  factory Session.fromFirebase(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    return Session(
      tutorId: data['tutorId'],
      sessionIndex: data['sessionIndex'],
      tutorName: data['tutorName'],
      sessionName: data['sessionName'],
      sessionStart: data['sessionStart'],
      sessionEnd: data['sessionEnd'],
      category: data['category'],
      createdTime: data['createdTime'],
      offline: data['offline'],
      participants: data['participants'],
      actualStudentBeingTutored: data['actualStudentBeingTutored'],
      zoomLink: data['zoomLink'],
    );
  }
}

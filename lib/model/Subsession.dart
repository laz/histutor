import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Subsession {
  final String tutorName;
  final String sessionName;
  final Timestamp date;
  final int time;

  Subsession({
    @required this.tutorName,
    @required this.sessionName,
    @required this.date,
    @required this.time,
  });

  factory Subsession.fromFirebase(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    print(data['sessionName']);
    return Subsession(
      tutorName: data['tutorName'],
      sessionName: data['sessionName'],
      date: data['date'],
      time: data['time'],
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Tutor {
  final String name;
  final int studentId;
  final String email;
  final int time;
  final String type;

  Tutor({
    @required this.name,
    @required this.studentId,
    @required this.email,
    @required this.time,
    @required this.type,
  });

  factory Tutor.fromFirebase(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    print("tutor " + data['email']);
    return Tutor(
      name: data['name'],
      email: data['email'],
      studentId: data['studentId'],
      time: data['time'],
      type: data['type'],
    );
  }
}

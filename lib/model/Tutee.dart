import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Tutee {
  final String name;
  final int studentId;
  final String email;
  final int time;
  final String type;

  Tutee({
    @required this.name,
    @required this.studentId,
    @required this.email,
    @required this.time,
    @required this.type,
  });

  factory Tutee.fromFirebase(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    print("tutee" + data['email']);
    return Tutee(
      name: data['name'],
      email: data['email'],
      studentId: data['studentId'],
      time: data['time'],
      type: data['type'],
    );
  }
}

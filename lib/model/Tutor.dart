import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Tutor {
  final String name;
  final String id;
  final String email;
  final int tutorTime;
  final String type;

  Tutor({
    @required this.name,
    @required this.id,
    @required this.email,
    @required this.tutorTime,
    @required this.type,
  });

  factory Tutor.fromFirebase(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    return Tutor(
      name: data['nickname'],
      email: data['email'],
      id: data['id'],
      tutorTime: data['tutorTime'],
      type: data['type'],
    );
  }
}

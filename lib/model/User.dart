import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User {
  final String name;
  final int studentId;
  final String email;
  final int time;
  final String type;

  User({
    @required this.name,
    @required this.studentId,
    @required this.email,
    @required this.time,
    @required this.type,
  });

  factory User.fromFirebase(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    return User(
      name: data['name'],
      email: data['email'],
      studentId: data['studentId'],
      time: data['time'],
      type: data['tutor'],
    );
  }
}

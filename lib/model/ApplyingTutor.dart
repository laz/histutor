import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ApplyingTutor {
  final String name;
  final int studentId;


  ApplyingTutor({
    @required this.name,
    @required this.studentId,
  });

  factory ApplyingTutor.fromFirebase(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    return ApplyingTutor(
      name: data['name'],
      studentId: data['studentId'],
    );
  }
}
